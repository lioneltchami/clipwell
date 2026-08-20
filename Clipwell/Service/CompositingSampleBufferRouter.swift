//
//  CompositingSampleBufferRouter.swift
//  Clipwell
//

import CoreMedia
import CoreVideo
import os
import ScreenCaptureKit

/// Wraps a Core Video buffer for lock-safe handoff across capture queues.
nonisolated struct SendablePixelBuffer: @unchecked Sendable {
    let value: CVPixelBuffer
}

/// Forwards capture samples to the asset writer, optionally compositing built-in camera frames.
nonisolated final class CompositingSampleBufferRouter: CaptureEngineSampleBufferDelegate, @unchecked Sendable {

    private let writer: AssetWriter
    private let overlayState: BuiltInOverlayState

    init(writer: AssetWriter, overlayState: BuiltInOverlayState) {
        self.writer = writer
        self.overlayState = overlayState
    }

    nonisolated func captureEngine(didOutputVideoSampleBuffer sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            writer.appendVideoSample(sampleBuffer)
            return
        }

        let (layout, cameraFrame) = overlayState.snapshot()
        if layout != .hidden, let cameraFrame {
            _ = FrameCompositor.composite(
                screen: pixelBuffer,
                camera: cameraFrame.value,
                layout: layout
            )
        }

        writer.appendVideoSample(sampleBuffer)
    }

    nonisolated func captureEngine(didOutputAudioSampleBuffer sampleBuffer: CMSampleBuffer) {
        writer.appendAudioSample(sampleBuffer)
    }

    nonisolated func captureEngine(didOutputMicrophoneSampleBuffer sampleBuffer: CMSampleBuffer) {
        writer.appendMicrophoneSample(sampleBuffer)
    }
}

/// Thread-safe snapshot of built-in overlay settings for the capture queue.
nonisolated final class BuiltInOverlayState: @unchecked Sendable {

    private let lock = OSAllocatedUnfairLock<(CameraOverlayLayout, SendablePixelBuffer?)>(
        initialState: (CameraOverlayLayout.smallCorner, nil)
    )

    func update(layout: CameraOverlayLayout, frame: SendablePixelBuffer?) {
        lock.withLock { state in
            state = (layout, frame)
        }
    }

    func snapshot() -> (CameraOverlayLayout, SendablePixelBuffer?) {
        lock.withLock { $0 }
    }
}
