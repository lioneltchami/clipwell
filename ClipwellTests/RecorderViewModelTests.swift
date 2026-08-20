//
//  RecorderViewModelTests.swift
//  ClipwellTests
//
//  Created by Joshua Sattler on 28.03.26.
//

import CoreGraphics
import Testing
@testable import Clipwell

/// Tests for RecorderViewModel's pure derived state and formatting.
///
/// These test the computed properties and initial state without
/// triggering any ScreenCaptureKit or system interactions.
@MainActor
struct RecorderViewModelTests {

    // MARK: - formattedDuration

    @Test func formattedDurationAtZero() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.formattedDuration == "00:00")
    }

    // MARK: - Initial State

    @Test func initialStateIsIdle() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.isRecording == false)
    }

    @Test func cannotStartRecordingWithoutContentFilter() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.canStartRecording == false)
    }

    @Test func hasNoContentSelectedByDefault() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.hasContentSelected == false)
    }

    @Test func isNotAreaSelectionByDefault() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.isAreaSelection == false)
    }

    @Test func presenterOverlayInactiveByDefault() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.isPresenterOverlayActive == false)
    }

    @Test func lastErrorIsNilByDefault() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.lastError == nil)
    }

    // MARK: - Capture Resolution

    @Test func nativeResolutionUsesTheContentScale() {
        let size = RecorderViewModel.outputSize(
            contentRect: CGRect(x: 0, y: 0, width: 1440, height: 900),
            sourceRect: nil,
            pointPixelScale: 2,
            useNativeResolution: true,
            fallbackSize: .zero
        )

        #expect(size == CGSize(width: 2880, height: 1800))
    }

    @Test func logicalResolutionPreservesPointDimensions() {
        let size = RecorderViewModel.outputSize(
            contentRect: CGRect(x: 0, y: 0, width: 1440, height: 900),
            sourceRect: nil,
            pointPixelScale: 2,
            useNativeResolution: false,
            fallbackSize: .zero
        )

        #expect(size == CGSize(width: 1440, height: 900))
    }

    @Test func areaSelectionUsesTheChosenResolutionMode() {
        let size = RecorderViewModel.outputSize(
            contentRect: CGRect(x: 0, y: 0, width: 1440, height: 900),
            sourceRect: CGRect(x: 100, y: 100, width: 640, height: 400),
            pointPixelScale: 2,
            useNativeResolution: true,
            fallbackSize: .zero
        )

        #expect(size == CGSize(width: 1280, height: 800))
    }

    @Test func nativeResolutionScalesTheFallbackSize() {
        let size = RecorderViewModel.outputSize(
            contentRect: .zero,
            sourceRect: nil,
            pointPixelScale: 2,
            useNativeResolution: true,
            fallbackSize: CGSize(width: 1920, height: 1080)
        )

        #expect(size == CGSize(width: 3840, height: 2160))
    }

    @Test func logicalResolutionPreservesTheFallbackSize() {
        let fallbackSize = CGSize(width: 1920, height: 1080)
        let size = RecorderViewModel.outputSize(
            contentRect: .zero,
            sourceRect: nil,
            pointPixelScale: 2,
            useNativeResolution: false,
            fallbackSize: fallbackSize
        )

        #expect(size == fallbackSize)
    }

    @Test func recordingDurationIsZeroByDefault() {
        let viewModel = RecorderViewModel()
        #expect(viewModel.recordingDuration == 0)
    }
}
