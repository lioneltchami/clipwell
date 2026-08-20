//
//  CameraCaptureMode.swift
//  Clipwell
//

import Foundation

/// How the camera is included in a recording.
enum CameraCaptureMode: String, CaseIterable, Identifiable, Sendable {
    /// No camera integration.
    case off
    /// macOS Video menu bar Presenter Overlay (layout controlled by the system).
    case systemPresenterOverlay
    /// In-app camera composited into the video with switchable layouts.
    case builtInOverlay

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .off:
            "Off"
        case .systemPresenterOverlay:
            "System Presenter Overlay"
        case .builtInOverlay:
            "Built-in Camera (switchable)"
        }
    }

    var detail: String {
        switch self {
        case .off:
            "Record screen only."
        case .systemPresenterOverlay:
            "Use the macOS Video menu to change small/large overlay. Layout switching is system-controlled."
        case .builtInOverlay:
            "Switch camera size and position during recording with buttons or shortcuts."
        }
    }
}
