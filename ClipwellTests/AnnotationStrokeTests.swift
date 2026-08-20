//
//  AnnotationStrokeTests.swift
//  ClipwellTests
//

import CoreGraphics
import Testing
@testable import Clipwell

struct AnnotationStrokeTests {

    @Test func normalizedPointClampsToUnitSquare() {
        let point = AnnotationPoint(location: CGPoint(x: 200, y: -10), in: CGSize(width: 100, height: 50))
        #expect(point.x == 1)
        #expect(point.y == 0)
    }

    @Test func strokeRequiresAtLeastTwoPoints() {
        let state = AnnotationState()
        state.addStroke(AnnotationStroke(points: [AnnotationPoint(x: 0.1, y: 0.1)]))
        #expect(state.snapshot().isEmpty)
    }
}
