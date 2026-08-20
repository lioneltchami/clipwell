//
//  RecordingSettingsTypes.swift
//  Clipwell
//

import AppKit
import Foundation

/// Video codec options for recording
enum VideoCodec: String, CaseIterable, Identifiable {
    case h264 = "H.264"
    case hevc = "H.265"
    case proRes422 = "ProRes 422"
    case proRes4444 = "ProRes 4444"

    var id: String { rawValue }

    /// Whether this codec supports alpha channel capture
    var supportsAlphaChannel: Bool {
        switch self {
        case .hevc, .proRes4444:
            return true
        case .h264, .proRes422:
            return false
        }
    }

    /// Whether alpha channel is always enabled (cannot be disabled)
    var alwaysHasAlpha: Bool {
        switch self {
        case .proRes4444:
            return true
        case .hevc, .h264, .proRes422:
            return false
        }
    }

    /// Whether alpha channel can be toggled by the user
    var canToggleAlpha: Bool {
        switch self {
        case .hevc:
            return true
        case .h264, .proRes422, .proRes4444:
            return false
        }
    }

    /// Whether this codec supports HDR (10-bit) recording
    var supportsHDR: Bool {
        switch self {
        case .hevc, .proRes422, .proRes4444:
            return true
        case .h264:
            return false
        }
    }

    /// The pixel format ScreenCaptureKit and AVAssetWriter should use for HDR capture.
    ///
    /// Each codec requires a specific chroma subsampling and bit depth:
    /// - HEVC Main 10: 10-bit 4:2:0
    /// - ProRes 422: 10-bit 4:2:2
    /// - ProRes 4444: 16-bit half-float RGBA
    var hdrPixelFormat: OSType {
        switch self {
        case .hevc:
            return kCVPixelFormatType_420YpCbCr10BiPlanarVideoRange
        case .proRes422:
            return kCVPixelFormatType_422YpCbCr10BiPlanarVideoRange
        case .proRes4444:
            return kCVPixelFormatType_64RGBAHalf
        case .h264:
            return kCVPixelFormatType_32BGRA
        }
    }

    /// Whether this codec supports user-adjustable quality/bitrate settings.
    ///
    /// ProRes codecs use fixed-quality encoding and ignore bitrate controls.
    var supportsQualitySetting: Bool {
        switch self {
        case .h264, .hevc:
            return true
        case .proRes422, .proRes4444:
            return false
        }
    }
}

/// Container format for output files
enum ContainerFormat: String, CaseIterable, Identifiable {
    case mov
    case mp4

    var id: String { rawValue }

    var fileExtension: String { rawValue }

    /// Video codecs supported by this container format
    var supportedVideoCodecs: [VideoCodec] {
        switch self {
        case .mov:
            // MOV (QuickTime) supports all codecs including ProRes and HEVC with alpha
            return VideoCodec.allCases
        case .mp4:
            // MP4 (MPEG-4) only supports H.264 and HEVC (without alpha)
            return [.h264, .hevc]
        }
    }

    /// Whether this container supports alpha channel video
    var supportsAlphaChannel: Bool {
        switch self {
        case .mov:
            return true
        case .mp4:
            // MP4 does not support alpha channel (HEVC with alpha or ProRes 4444)
            return false
        }
    }

    /// Audio codecs supported by this container format
    var supportedAudioCodecs: [AudioCodec] {
        switch self {
        case .mov:
            // MOV supports all audio codecs
            return AudioCodec.allCases
        case .mp4:
            // MP4 only supports AAC (not raw PCM)
            return [.aac]
        }
    }
}

/// Audio codec options
enum AudioCodec: String, CaseIterable, Identifiable {
    case aac = "AAC"
    case pcm = "PCM"

    var id: String { rawValue }
}

/// Frame rate options for recording
enum FrameRate: Int, CaseIterable, Identifiable {
    case native = 0
    case fps24 = 24
    case fps30 = 30
    case fps60 = 60

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .native:
            return "Native"
        default:
            return "\(rawValue) fps"
        }
    }

    /// The frame rate in Hz the recording is captured and written at.
    ///
    /// For explicit rates this returns the selected value. `.native` resolves to
    /// 60: ScreenCaptureKit only delivers frames when content changes, so a
    /// higher ceiling produced a heavily variable frame rate that broke
    /// concatenation and upload tools without adding useful frames.
    ///
    /// `CaptureEngine` uses this for `minimumFrameInterval`, `AssetWriter` uses it
    /// as the constant frame rate grid, and both use it for the bitrate budget.
    var effectiveFrameRate: Double {
        switch self {
        case .native: 60.0
        default:      Double(rawValue)
        }
    }
}

/// Video quality presets controlling compression bitrate for H.264 and HEVC.
///
/// Each preset defines a bits-per-pixel multiplier used to calculate the
/// target average bitrate: `width * height * bpp * frameRate`.
/// ProRes codecs ignore this setting since they use fixed-quality encoding.
enum VideoQuality: String, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"

    var id: String { rawValue }

    /// Bits-per-pixel multiplier for H.264
    var h264BitsPerPixel: Double {
        switch self {
        case .low:    0.04
        case .medium: 0.2
        case .high:   0.6
        }
    }

    /// Bits-per-pixel multiplier for HEVC (more efficient codec)
    var hevcBitsPerPixel: Double {
        switch self {
        case .low:    0.02
        case .medium: 0.15
        case .high:   0.4
        }
    }

    /// Returns the bits-per-pixel multiplier for the given codec
    func bitsPerPixel(for codec: VideoCodec) -> Double? {
        switch codec {
        case .h264: h264BitsPerPixel
        case .hevc: hevcBitsPerPixel
        case .proRes422, .proRes4444: nil
        }
    }
}

/// Describes which ScreenCaptureKit HDR configuration is active, so the
/// ``AssetWriter`` can tag the output container with matching colorimetry.
enum HDRPreset {
    /// SDR capture — no HDR color properties needed.
    case sdr

    /// Manual BT.2020 / PQ configuration applied to a plain
    /// `SCStreamConfiguration`. Used on macOS 15–25 to produce
    /// HDR10-compatible output (BT.2020 primaries, PQ transfer
    /// function, BT.2020 YCbCr matrix).
    case hdr10Manual

    /// ``SCStreamConfiguration.Preset.captureHDRRecordingPreservedSDRHDR10``
    /// (macOS 26+). Same BT.2020 / PQ colorimetry as `.hdr10Manual`, but
    /// also injects static HDR10 mastering metadata and preserves SDR UI
    /// appearance on HDR screens.
    case hdr10PreservedSDR
}
