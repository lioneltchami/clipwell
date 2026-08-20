//
//  AnnotationCompositorTests.swift
//  ClipwellTests
//

import CoreGraphics
import CoreVideo
import Testing
@testable import Clipwell

struct AnnotationCompositorTests {

    @Test func compositingStrokeChangesPixelBuffer() throws {
        let width = 64
        let height = 64
        let buffer = try makeBGRABuffer(width: width, height: height)
        fill(buffer, red: 0, green: 0, blue: 0, alpha: 255)

        let before = samplePixel(buffer, horizontal: width / 2, vertical: height / 2)

        let stroke = AnnotationStroke(points: [
            AnnotationPoint(x: 0.1, y: 0.5),
            AnnotationPoint(x: 0.9, y: 0.5)
        ])
        AnnotationCompositor.composite(strokes: [stroke], onto: buffer)

        let after = samplePixel(buffer, horizontal: width / 2, vertical: height / 2)
        #expect(before != after)
        #expect(after.red > before.red)
    }

    @Test func emptyStrokeListIsNoOp() throws {
        let buffer = try makeBGRABuffer(width: 32, height: 32)
        fill(buffer, red: 10, green: 20, blue: 30, alpha: 255)
        let before = samplePixel(buffer, horizontal: 8, vertical: 8)

        AnnotationCompositor.composite(strokes: [], onto: buffer)

        #expect(samplePixel(buffer, horizontal: 8, vertical: 8) == before)
    }

    // MARK: - Helpers

    private struct Pixel: Equatable {
        let red: UInt8
        let green: UInt8
        let blue: UInt8
        let alpha: UInt8
    }

    private func makeBGRABuffer(width: Int, height: Int) throws -> CVPixelBuffer {
        var buffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32BGRA,
            [
                kCVPixelBufferIOSurfacePropertiesKey as String: [:]
            ] as CFDictionary,
            &buffer
        )
        #expect(status == kCVReturnSuccess)
        return try #require(buffer)
    }

    private func fill(
        _ buffer: CVPixelBuffer,
        red: UInt8,
        green: UInt8,
        blue: UInt8,
        alpha: UInt8
    ) {
        CVPixelBufferLockBaseAddress(buffer, [])
        defer { CVPixelBufferUnlockBaseAddress(buffer, []) }

        let width = CVPixelBufferGetWidth(buffer)
        let height = CVPixelBufferGetHeight(buffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(buffer)
        guard let base = CVPixelBufferGetBaseAddress(buffer) else { return }

        for rowIndex in 0..<height {
            let row = base.advanced(by: rowIndex * bytesPerRow).assumingMemoryBound(to: UInt8.self)
            for columnIndex in 0..<width {
                let offset = columnIndex * 4
                row[offset] = blue
                row[offset + 1] = green
                row[offset + 2] = red
                row[offset + 3] = alpha
            }
        }
    }

    private func samplePixel(
        _ buffer: CVPixelBuffer,
        horizontal: Int,
        vertical: Int
    ) -> Pixel {
        CVPixelBufferLockBaseAddress(buffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(buffer, .readOnly) }

        let bytesPerRow = CVPixelBufferGetBytesPerRow(buffer)
        let base = CVPixelBufferGetBaseAddress(buffer)!
        let row = base.advanced(by: vertical * bytesPerRow).assumingMemoryBound(to: UInt8.self)
        let offset = horizontal * 4
        return Pixel(
            red: row[offset + 2],
            green: row[offset + 1],
            blue: row[offset],
            alpha: row[offset + 3]
        )
    }
}
