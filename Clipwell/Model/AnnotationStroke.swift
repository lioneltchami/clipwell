//
//  AnnotationStroke.swift
//  Clipwell
//

import CoreGraphics
import Foundation

/// A single freehand annotation stroke in normalized capture coordinates (0…1, origin top-left).
struct AnnotationStroke: Sendable, Identifiable, Equatable {
    let id: UUID
    let points: [AnnotationPoint]

    init(id: UUID = UUID(), points: [AnnotationPoint]) {
        self.id = id
        self.points = points
    }
}

struct AnnotationPoint: Sendable, Equatable {
    let x: Double
    let y: Double

    init(x: Double, y: Double) {
        self.x = min(max(x, 0), 1)
        self.y = min(max(y, 0), 1)
    }

    init(location: CGPoint, in size: CGSize) {
        guard size.width > 0, size.height > 0 else {
            self.init(x: 0, y: 0)
            return
        }
        self.init(
            x: location.x / size.width,
            y: location.y / size.height
        )
    }
}
