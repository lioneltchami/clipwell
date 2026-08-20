//
//  PermissionService.swift
//  Clipwell
//
//  Created by Joshua Sattler on 07.02.26.
//

import Foundation
import ScreenCaptureKit
import AVFoundation
import AVFAudio
import OSLog
import CoreGraphics
import AppKit

/// Service responsible for checking and requesting system permissions
@MainActor
@Observable
final class PermissionService {

    // MARK: - Permission States

    enum PermissionState {
        case unknown
        case granted
        case denied
    }

    private(set) var screenRecordingState: PermissionState = .unknown
    private(set) var microphoneState: PermissionState = .unknown

    var allPermissionsGranted: Bool {
        screenRecordingState == .granted && microphoneState == .granted
    }

    var hasAnyPermissionDenied: Bool {
        screenRecordingState == .denied || microphoneState == .denied
    }

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "Clipwell",
        category: "PermissionService"
    )

    // MARK: - Initialization

    init() {
        updatePermissionStates()
    }

    // MARK: - Permission Checking

    /// Updates all permission states
    func updatePermissionStates() {
        screenRecordingState = checkScreenRecordingPermission()
        microphoneState = checkMicrophonePermission()

        logger.info("Permission states - Screen: \(String(describing: self.screenRecordingState)), Microphone: \(String(describing: self.microphoneState))")
    }

    private func checkScreenRecordingPermission() -> PermissionState {
        CGPreflightScreenCaptureAccess() ? .granted : .denied
    }

    private func checkMicrophonePermission() -> PermissionState {
        if #available(macOS 14.0, *) {
            switch AVAudioApplication.shared.recordPermission {
            case .granted:
                return .granted
            case .denied:
                return .denied
            case .undetermined:
                return .unknown
            @unknown default:
                return .unknown
            }
        }

        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            return .granted
        case .notDetermined:
            return .unknown
        case .denied, .restricted:
            return .denied
        @unknown default:
            return .unknown
        }
    }

    // MARK: - Permission Requests

    /// Requests required permissions on app launch
    /// - Parameter includeMicrophone: Whether to also request microphone permission
    func requestPermissions(includeMicrophone: Bool) async {
        logger.info("Requesting permissions (includeMicrophone: \(includeMicrophone))...")

        // Request screen recording permission first (synchronous)
        requestScreenRecordingPermission()

        // Request microphone permission only if needed (asynchronous)
        if includeMicrophone {
            await requestMicrophonePermission()
        }

        // Update states after requests
        updatePermissionStates()
    }

    /// Requests screen recording permission
    /// - Note: This will open System Settings if permission was previously denied
    func requestScreenRecordingPermission() {
        // Avoid re-triggering the TCC prompt after the user already granted access
        // for this exact app identity.
        if CGPreflightScreenCaptureAccess() {
            screenRecordingState = .granted
            return
        }

        let wasGranted = CGRequestScreenCaptureAccess()
        screenRecordingState = wasGranted ? .granted : .denied
        logger.info("Screen recording permission request result: \(wasGranted)")
    }

    /// Requests microphone permission
    func requestMicrophonePermission() async {
        activateForPermissionPrompt()
        defer { restoreMenuBarActivationPolicy() }

        // Menu bar apps need a moment to become key before TCC shows a dialog.
        try? await Task.sleep(for: .milliseconds(150))

        if #available(macOS 14.0, *) {
            let status = AVAudioApplication.shared.recordPermission
            switch status {
            case .granted:
                microphoneState = .granted
                await probeMicrophoneAccess()
                return
            case .undetermined:
                await triggerMicrophoneAccessViaCaptureSession()
                let granted = await AVAudioApplication.requestRecordPermission()
                microphoneState = granted ? .granted : .denied
                logger.info("Microphone permission request result (AVAudioApplication): \(granted)")
                if granted {
                    await probeMicrophoneAccess()
                } else {
                    try? await Task.sleep(for: .milliseconds(500))
                    updatePermissionStates()
                }
                return
            case .denied:
                microphoneState = .denied
                logger.info("Microphone permission previously denied")
                return
            @unknown default:
                break
            }
        }

        let status = AVCaptureDevice.authorizationStatus(for: .audio)

        switch status {
        case .authorized:
            microphoneState = .granted
            await probeMicrophoneAccess()
        case .notDetermined:
            await triggerMicrophoneAccessViaCaptureSession()
            let granted = await AVCaptureDevice.requestAccess(for: .audio)
            microphoneState = granted ? .granted : .denied
            logger.info("Microphone permission request result (AVCaptureDevice): \(granted)")
            if granted {
                await probeMicrophoneAccess()
            } else {
                try? await Task.sleep(for: .milliseconds(500))
                updatePermissionStates()
            }
        case .denied, .restricted:
            microphoneState = .denied
        @unknown default:
            microphoneState = .unknown
        }
    }

    /// Requests microphone access without opening System Settings.
    func promptMicrophonePermission() async {
        await requestMicrophonePermission()
        updatePermissionStates()
    }

    /// Brings Clipwell to the foreground so TCC can present its microphone dialog.
    private func activateForPermissionPrompt() {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }

    private func restoreMenuBarActivationPolicy() {
        NSApp.setActivationPolicy(.accessory)
    }

    /// Starting a capture session while permission is undetermined triggers the system prompt
    /// for menu bar apps where `requestRecordPermission()` alone can fail silently.
    private func triggerMicrophoneAccessViaCaptureSession() async {
        guard let device = AVCaptureDevice.default(for: .audio) else { return }

        let session = AVCaptureSession()
        session.beginConfiguration()
        defer { session.commitConfiguration() }

        guard let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        else { return }

        session.addInput(input)

        await runCaptureSession(session)
    }

    /// Touching the default input registers the app with TCC after approval.
    private func probeMicrophoneAccess() async {
        guard microphoneState == .granted || AVCaptureDevice.authorizationStatus(for: .audio) == .authorized else {
            return
        }
        guard let device = AVCaptureDevice.default(for: .audio) else { return }

        let session = AVCaptureSession()
        session.beginConfiguration()
        defer { session.commitConfiguration() }

        guard let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        else { return }

        session.addInput(input)
        await runCaptureSession(session)
    }

    private func runCaptureSession(_ session: AVCaptureSession) async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
                continuation.resume()
            }
        }
        try? await Task.sleep(for: .milliseconds(300))
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            DispatchQueue.global(qos: .userInitiated).async {
                session.stopRunning()
                continuation.resume()
            }
        }
    }

    /// Opens System Settings to the Screen Recording preferences pane
    func openScreenRecordingSettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture") {
            NSWorkspace.shared.open(url)
        }
    }

    /// Opens System Settings to the Microphone preferences pane
    func openMicrophoneSettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Microphone") {
            NSWorkspace.shared.open(url)
        }
    }
}
