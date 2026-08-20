//
//  CameraOverlayLayout.swift
//  BetterCapture
//

import CoreGraphics
import Foundation

/// Built-in camera picture-in-picture layout on the exported video.
nonisolated enum CameraOverlayLayout: String, CaseIterable, Identifiable, Sendable {
    case smallCorner
    case largeCorner
    case bottomBar
    case hidden

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .smallCorner: "Small"
        case .largeCorner: "Large"
        case .bottomBar: "Bar"
        case .hidden: "Hidden"
        }
    }

    var systemImage: String {
        switch self {
        case .smallCorner: "rectangle.inset.bottomright.filled"
        case .largeCorner: "rectangle.bottomhalf.inset.filled"
        case .bottomBar: "rectangle.bottomthird.inset.filled"
        case .hidden: "video.slash"
        }
    }

    /// Normalized overlay rect in unit coordinates (origin top-left, matching CIImage space).
    func normalizedOverlayRect(aspectFitIn containerSize: CGSize) -> CGRect? {
        guard self != .hidden else { return nil }

        switch self {
        case .smallCorner:
            return CGRect(x: 0.68, y: 0.68, width: 0.28, height: 0.28)
        case .largeCorner:
            return CGRect(x: 0.55, y: 0.45, width: 0.42, height: 0.42)
        case .bottomBar:
            return CGRect(x: 0.05, y: 0.72, width: 0.9, height: 0.23)
        case .hidden:
            return nil
        }
    }
}
