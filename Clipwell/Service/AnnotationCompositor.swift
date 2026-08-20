//
//  AnnotationCompositor.swift
//  Clipwell
//

import CoreGraphics
import CoreImage
import CoreVideo
import Foundation

/// Burns annotation strokes onto a captured video frame.
nonisolated enum AnnotationCompositor {

    private static let context = CIContext(options: [.useSoftwareRenderer: false])

    static func composite(strokes: [AnnotationStroke], onto pixelBuffer: CVPixelBuffer) {
        guard !strokes.isEmpty,
            let overlay = renderOverlay(
                strokes: strokes,
                width: CVPixelBufferGetWidth(pixelBuffer),
                height: CVPixelBufferGetHeight(pixelBuffer)
            )
        else { return }

        let screenImage = CIImage(cvPixelBuffer: pixelBuffer)
        let overlayImage = CIImage(cgImage: overlay)
        let composited = overlayImage.composited(over: screenImage)
        context.render(composited, to: pixelBuffer)
    }

    private static func renderOverlay(
        strokes: [AnnotationStroke],
        width: Int,
        height: Int
    ) -> CGImage? {
        guard width > 0, height > 0 else { return nil }

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let ctx = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else { return nil }

        ctx.clear(CGRect(x: 0, y: 0, width: width, height: height))
        ctx.translateBy(x: 0, y: CGFloat(height))
        ctx.scaleBy(x: 1, y: -1)
        ctx.setStrokeColor(CGColor(red: 1, green: 0.25, blue: 0.2, alpha: 0.92))
        ctx.setLineWidth(4)
        ctx.setLineCap(.round)
        ctx.setLineJoin(.round)

        for stroke in strokes {
            guard let first = stroke.points.first else { continue }
            ctx.beginPath()
            ctx.move(to: pixelPoint(first, width: width, height: height))
            for point in stroke.points.dropFirst() {
                ctx.addLine(to: pixelPoint(point, width: width, height: height))
            }
            ctx.strokePath()
        }

        return ctx.makeImage()
    }

    private static func pixelPoint(
        _ point: AnnotationPoint,
        width: Int,
        height: Int
    ) -> CGPoint {
        CGPoint(
            x: point.x * CGFloat(width),
            y: point.y * CGFloat(height)
        )
    }
}
