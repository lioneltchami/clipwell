//
//  RecordingPreset.swift
//  Clipwell
//

import Foundation

/// A named snapshot of the portable recording settings that can be applied before capture.
struct RecordingPreset: Codable, Equatable, Identifiable {
    struct CaptureSettings: Codable, Equatable {
        let frameRate: Int
        let videoQuality: String
        let videoCodec: String
        let containerFormat: String
        let captureAlphaChannel: Bool
        let captureHDR: Bool
        let captureNativeResolution: Bool
        let captureMicrophone: Bool
        let captureSystemAudio: Bool
        let audioCodec: String
        let cameraCaptureMode: String
        let showPostRecordingSheet: Bool
        let recordingCountdownSeconds: Int
        let showClickHighlighter: Bool
        let showKeystrokeOverlay: Bool
        let enableAnnotationLayer: Bool
        let showCursor: Bool
        let showWallpaper: Bool
        let showMenuBar: Bool
        let showDock: Bool
        let showWindowShadows: Bool
        let showClipwell: Bool
    }

    let id: UUID
    var name: String
    let captureSettings: CaptureSettings
    let createdAt: Date

    init(name: String, settings: SettingsStore) {
        id = UUID()
        self.name = name
        createdAt = Date()
        captureSettings = .init(
            frameRate: settings.frameRate.rawValue,
            videoQuality: settings.videoQuality.rawValue,
            videoCodec: settings.videoCodec.rawValue,
            containerFormat: settings.containerFormat.rawValue,
            captureAlphaChannel: settings.captureAlphaChannel,
            captureHDR: settings.captureHDR,
            captureNativeResolution: settings.captureNativeResolution,
            captureMicrophone: settings.captureMicrophone,
            captureSystemAudio: settings.captureSystemAudio,
            audioCodec: settings.audioCodec.rawValue,
            cameraCaptureMode: settings.cameraCaptureMode.rawValue,
            showPostRecordingSheet: settings.showPostRecordingSheet,
            recordingCountdownSeconds: settings.recordingCountdownSeconds,
            showClickHighlighter: settings.showClickHighlighter,
            showKeystrokeOverlay: settings.showKeystrokeOverlay,
            enableAnnotationLayer: settings.enableAnnotationLayer,
            showCursor: settings.showCursor,
            showWallpaper: settings.showWallpaper,
            showMenuBar: settings.showMenuBar,
            showDock: settings.showDock,
            showWindowShadows: settings.showWindowShadows,
            showClipwell: settings.showClipwell
        )
    }

    /// Applies supported stored values through SettingsStore so its compatibility rules remain authoritative.
    func apply(to settings: SettingsStore) {
        if let containerFormat = ContainerFormat(rawValue: captureSettings.containerFormat) {
            settings.containerFormat = containerFormat
        }
        if let videoCodec = VideoCodec(rawValue: captureSettings.videoCodec) {
            settings.videoCodec = videoCodec
        }
        if let audioCodec = AudioCodec(rawValue: captureSettings.audioCodec) {
            settings.audioCodec = audioCodec
        }
        if let frameRate = FrameRate(rawValue: captureSettings.frameRate) {
            settings.frameRate = frameRate
        }
        if let videoQuality = VideoQuality(rawValue: captureSettings.videoQuality) {
            settings.videoQuality = videoQuality
        }
        if let cameraCaptureMode = CameraCaptureMode(rawValue: captureSettings.cameraCaptureMode) {
            settings.cameraCaptureMode = cameraCaptureMode
        }

        settings.captureAlphaChannel = captureSettings.captureAlphaChannel
        settings.captureHDR = captureSettings.captureHDR
        settings.captureNativeResolution = captureSettings.captureNativeResolution
        settings.captureMicrophone = captureSettings.captureMicrophone
        settings.captureSystemAudio = captureSettings.captureSystemAudio
        settings.showPostRecordingSheet = captureSettings.showPostRecordingSheet
        settings.recordingCountdownSeconds = captureSettings.recordingCountdownSeconds
        settings.showClickHighlighter = captureSettings.showClickHighlighter
        settings.showKeystrokeOverlay = captureSettings.showKeystrokeOverlay
        settings.enableAnnotationLayer = captureSettings.enableAnnotationLayer
        settings.showCursor = captureSettings.showCursor
        settings.showWallpaper = captureSettings.showWallpaper
        settings.showMenuBar = captureSettings.showMenuBar
        settings.showDock = captureSettings.showDock
        settings.showWindowShadows = captureSettings.showWindowShadows
        settings.showClipwell = captureSettings.showClipwell
    }
}
