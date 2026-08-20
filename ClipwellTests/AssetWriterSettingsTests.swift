//
//  AssetWriterSettingsTests.swift
//  ClipwellTests
//

import AVFoundation
import Testing
import VideoToolbox
@testable import Clipwell

@MainActor
struct AssetWriterSettingsTests {

    private let videoSize = CGSize(width: 1920, height: 1080)

    @Test func hevcHDRUsesMain10MetadataAndBT2020PQ() throws {
        let settings = makeStore()
        settings.videoCodec = .hevc
        settings.captureHDR = true

        let output = AssetWriterSettings.video(from: settings, size: videoSize)
        let compression = try #require(output[AVVideoCompressionPropertiesKey] as? [String: Any])
        let colorProperties = try #require(output[AVVideoColorPropertiesKey] as? [String: String])

        #expect(compression[AVVideoProfileLevelKey] as? String == kVTProfileLevel_HEVC_Main10_AutoLevel as String)
        #expect(compression[kVTCompressionPropertyKey_HDRMetadataInsertionMode as String] as? String == kVTHDRMetadataInsertionMode_Auto as String)
        #expect(colorProperties[AVVideoColorPrimariesKey] == AVVideoColorPrimaries_ITU_R_2020)
        #expect(colorProperties[AVVideoTransferFunctionKey] == AVVideoTransferFunction_SMPTE_ST_2084_PQ)
        #expect(colorProperties[AVVideoYCbCrMatrixKey] == AVVideoYCbCrMatrix_ITU_R_2020)
    }

    @Test func proResHDRDefersColorMetadataToFrames() {
        let settings = makeStore()
        settings.videoCodec = .proRes422
        settings.captureHDR = true

        let output = AssetWriterSettings.video(from: settings, size: videoSize)

        #expect(output[AVVideoColorPropertiesKey] == nil)
    }

    @Test func h264UsesSDRColorMetadataEvenWhenHDRIsRequested() throws {
        let settings = makeStore()
        settings.videoCodec = .h264
        settings.captureHDR = true

        let output = AssetWriterSettings.video(from: settings, size: videoSize)
        let colorProperties = try #require(output[AVVideoColorPropertiesKey] as? [String: String])

        #expect(colorProperties[AVVideoColorPrimariesKey] == AVVideoColorPrimaries_ITU_R_709_2)
        #expect(colorProperties[AVVideoTransferFunctionKey] == AVVideoTransferFunction_ITU_R_709_2)
        #expect(colorProperties[AVVideoYCbCrMatrixKey] == AVVideoYCbCrMatrix_ITU_R_709_2)
    }

    private func makeStore() -> SettingsStore {
        let suiteName = "com.lionel.ClipwellTests.\(UUID().uuidString)"
        return SettingsStore(defaults: UserDefaults(suiteName: suiteName)!)
    }
}
