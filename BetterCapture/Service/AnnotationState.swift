//
//  AnnotationState.swift
//  BetterCapture
//

import Foundation
import os

/// Thread-safe store of annotation strokes for compositing on the capture queue.
nonisolated final class AnnotationState: @unchecked Sendable {

    private let lock = OSAllocatedUnfairLock<[AnnotationStroke]>(initialState: [])

    func addStroke(_ stroke: AnnotationStroke) {
        guard stroke.points.count >= 2 else { return }
        lock.withLock { strokes in
            strokes.append(stroke)
        }
    }

    func replaceStrokes(_ strokes: [AnnotationStroke]) {
        lock.withLock { $0 = strokes }
    }

    func clear() {
        lock.withLock { $0.removeAll() }
    }

    func snapshot() -> [AnnotationStroke] {
        lock.withLock { $0 }
    }
}
