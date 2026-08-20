//
//  BuiltInCameraService.swift
//  Clipwell
//

import AVFoundation
import OSLog
import AppKit

/// Captures camera frames and exposes the latest buffer for real-time compositing.
@MainActor
final class BuiltInCameraService: NSObject {

    private(set) var layout: CameraOverlayLayout = .smallCorner
    private(set) var isRunning = false

    /// Updated on the capture queue so compositing can read the latest camera frame.
    nonisolated(unsafe) weak var overlayState: BuiltInOverlayState?

    private var session: AVCaptureSession?
    private let layoutLock = OSAllocatedUnfairLock(initialState: CameraOverlayLayout.smallCorner)
    private let output = AVCaptureVideoDataOutput()
    private let frameLock = OSAllocatedUnfairLock<SendablePixelBuffer?>(initialState: nil)
    private let queue = DispatchQueue(label: "com.clipwell.builtInCamera", qos: .userInteractive)
    private let controlPanel = CameraControlPanel()
    private var onLayoutChange: ((CameraOverlayLayout) -> Void)?

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "Clipwell",
        category: "BuiltInCameraService"
    )

    func setLayout(_ layout: CameraOverlayLayout) {
        self.layout = layout
        layoutLock.withLock { $0 = layout }
        overlayState?.update(layout: layout, frame: latestFrame().map { SendablePixelBuffer(value: $0) })
        controlPanel.updateLayout(layout)
        onLayoutChange?(layout)
    }

    func cycleLayoutForward() {
        let visibleLayouts = CameraOverlayLayout.allCases.filter { $0 != .hidden }
        guard let index = visibleLayouts.firstIndex(of: layout) else {
            setLayout(.smallCorner)
            return
        }
        let next = visibleLayouts[(index + 1) % visibleLayouts.count]
        setLayout(next)
    }

    func latestFrame() -> CVPixelBuffer? {
        let boxed = frameLock.withLock { $0 }
        return boxed?.value
    }

    func start(deviceID: String?, onLayoutChange: ((CameraOverlayLayout) -> Void)? = nil) async {
        self.onLayoutChange = onLayoutChange
        guard session == nil else { return }

        let device: AVCaptureDevice? = if let deviceID {
            AVCaptureDevice(uniqueID: deviceID)
        } else {
            AVCaptureDevice.default(for: .video)
        }

        guard let device else {
            logger.warning("No camera available for built-in overlay")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: device)
            let newSession = AVCaptureSession()
            newSession.beginConfiguration()
            newSession.sessionPreset = .medium

            guard newSession.canAddInput(input) else { return }
            newSession.addInput(input)

            output.videoSettings = [
                kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
            ]
            output.alwaysDiscardsLateVideoFrames = true
            output.setSampleBufferDelegate(self, queue: queue)

            guard newSession.canAddOutput(output) else { return }
            newSession.addOutput(output)

            newSession.commitConfiguration()
            session = newSession

            nonisolated(unsafe) let runnable = newSession
            let running = await withCheckedContinuation { continuation in
                queue.async {
                    runnable.startRunning()
                    continuation.resume(returning: runnable.isRunning)
                }
            }

            isRunning = running
            controlPanel.show(layout: layout) { [weak self] layout in
                self?.setLayout(layout)
            }
            logger.info("Built-in camera started (running: \(running))")
        } catch {
            logger.error("Failed to start built-in camera: \(error.localizedDescription)")
        }
    }

    func stop() {
        frameLock.withLock { $0 = nil }
        controlPanel.dismiss()
        guard let current = session else { return }
        session = nil
        isRunning = false

        nonisolated(unsafe) let stoppable = current
        queue.async {
            stoppable.stopRunning()
        }
        logger.info("Built-in camera stopped")
    }
}

extension BuiltInCameraService: AVCaptureVideoDataOutputSampleBufferDelegate {
    nonisolated func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let boxed = SendablePixelBuffer(value: pixelBuffer)
        frameLock.withLock { $0 = boxed }
        let layout = layoutLock.withLock { $0 }
        overlayState?.update(layout: layout, frame: boxed)
    }
}
