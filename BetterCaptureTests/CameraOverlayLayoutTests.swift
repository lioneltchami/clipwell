//
//  CameraOverlayLayoutTests.swift
//  BetterCaptureTests
//

import Testing
import CoreGraphics
@testable import BetterCapture

struct CameraOverlayLayoutTests {

    @Test func hiddenLayoutHasNoOverlayRect() {
        #expect(CameraOverlayLayout.hidden.normalizedOverlayRect(aspectFitIn: CGSize(width: 1920, height: 1080)) == nil)
    }

    @Test func smallCornerFitsInsideUnitSquare() {
        let rect = CameraOverlayLayout.smallCorner.normalizedOverlayRect(aspectFitIn: CGSize(width: 100, height: 100))
        #expect(rect != nil)
        #expect(rect!.maxX <= 1.0)
        #expect(rect!.maxY <= 1.0)
    }
}
