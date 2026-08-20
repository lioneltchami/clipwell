//
//  RecordingExportService.swift
//  Clipwell
//

import AVFoundation
import CoreMedia
import ImageIO
import UniformTypeIdentifiers
import Foundation
import OSLog

enum RecordingExportError: LocalizedError {
    case exportFailed(String)
    case noVideoTrack
    case gifEncodingFailed

    var errorDescription: String? {
        switch self {
        case .exportFailed(let reason):
            "Export failed: \(reason)"
        case .noVideoTrack:
            "Recording has no video track."
        case .gifEncodingFailed:
            "Could not create GIF."
        }
    }
}

/// Post-recording export helpers (trim, GIF).
enum RecordingExportService {

    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "Clipwell",
        category: "RecordingExportService"
    )

    /// Trims a recording to the given time range and writes a new file alongside the original.
    static func trim(
        source: URL,
        start: CMTime,
        end: CMTime,
        outputDirectory: URL
    ) async throws -> URL {
        let asset = AVURLAsset(url: source)
        let duration = try await asset.load(.duration)
        let clampedStart = max(.zero, min(start, duration))
        let clampedEnd = max(clampedStart, min(end, duration))

        guard clampedEnd > clampedStart else {
            throw RecordingExportError.exportFailed("Invalid trim range.")
        }

        let outputURL = outputDirectory
            .appending(path: trimmedFilename(for: source))
        try? FileManager.default.removeItem(at: outputURL)

        guard let exportSession = AVAssetExportSession(
            asset: asset,
            presetName: AVAssetExportPresetHighestQuality
        ) else {
            throw RecordingExportError.exportFailed("Could not create export session.")
        }

        exportSession.outputURL = outputURL
        exportSession.outputFileType = source.pathExtension.lowercased() == "mp4" ? .mp4 : .mov
        exportSession.timeRange = CMTimeRange(start: clampedStart, end: clampedEnd)

        try await export(exportSession)
        logger.info("Trimmed recording saved to \(outputURL.lastPathComponent)")
        return outputURL
    }

    /// Exports an animated GIF (10 fps, max 15 seconds) next to the source file.
    static func exportGIF(
        source: URL,
        outputDirectory: URL,
        maximumDuration: TimeInterval = 15,
        framesPerSecond: Int = 10
    ) async throws -> URL {
        let asset = AVURLAsset(url: source)
        let videoTracks = try await asset.loadTracks(withMediaType: .video)
        guard !videoTracks.isEmpty else {
            throw RecordingExportError.noVideoTrack
        }

        let duration = try await asset.load(.duration)
        let exportDuration = min(duration.seconds, maximumDuration)
        guard exportDuration > 0 else {
            throw RecordingExportError.exportFailed("Recording has zero duration.")
        }

        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.requestedTimeToleranceBefore = .zero
        generator.requestedTimeToleranceAfter = .zero

        let frameCount = max(1, Int(exportDuration * Double(framesPerSecond)))
        var images: [CGImage] = []
        images.reserveCapacity(frameCount)

        for index in 0..<frameCount {
            let seconds = Double(index) / Double(framesPerSecond)
            let time = CMTime(seconds: seconds, preferredTimescale: 600)
            let (image, _) = try await generator.image(at: time)
            images.append(image)
        }

        let outputURL = outputDirectory
            .appending(path: gifFilename(for: source))

        try? FileManager.default.removeItem(at: outputURL)
        try writeGIF(images: images, to: outputURL, delaySeconds: 1.0 / Double(framesPerSecond))

        logger.info("GIF saved to \(outputURL.lastPathComponent)")
        return outputURL
    }

    // MARK: - Private

    private static func export(_ session: AVAssetExportSession) async throws {
        guard let outputURL = session.outputURL, let outputFileType = session.outputFileType else {
            throw RecordingExportError.exportFailed("Export session is missing output settings.")
        }

        do {
            try await session.export(to: outputURL, as: outputFileType)
        } catch {
            throw RecordingExportError.exportFailed(error.localizedDescription)
        }
    }

    private static func writeGIF(
        images: [CGImage],
        to url: URL,
        delaySeconds: Double
    ) throws {
        guard let destination = CGImageDestinationCreateWithURL(
            url as CFURL,
            UTType.gif.identifier as CFString,
            images.count,
            nil
        ) else {
            throw RecordingExportError.gifEncodingFailed
        }

        let frameProperties = [
            kCGImagePropertyGIFDictionary: [
                kCGImagePropertyGIFDelayTime: delaySeconds
            ]
        ] as CFDictionary

        let fileProperties = [
            kCGImagePropertyGIFDictionary: [
                kCGImagePropertyGIFLoopCount: 0
            ]
        ] as CFDictionary

        CGImageDestinationSetProperties(destination, fileProperties)

        for image in images {
            CGImageDestinationAddImage(destination, image, frameProperties)
        }

        guard CGImageDestinationFinalize(destination) else {
            throw RecordingExportError.gifEncodingFailed
        }
    }

    private static func trimmedFilename(for source: URL) -> String {
        let base = source.deletingPathExtension().lastPathComponent
        let ext = source.pathExtension
        return "\(base)-trimmed.\(ext)"
    }

    private static func gifFilename(for source: URL) -> String {
        let base = source.deletingPathExtension().lastPathComponent
        return "\(base).gif"
    }
}
