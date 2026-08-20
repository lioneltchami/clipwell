//
//  FrameCompositor.swift
//  Clipwell
//

import CoreImage
import CoreVideo
import Foundation

/// Composites a camera frame onto a screen capture frame for built-in overlay mode.
nonisolated enum FrameCompositor {

    private static let context = CIContext(options: [.useSoftwareRenderer: false])

    /// Draws the camera feed onto the screen buffer using the given layout.
    static func composite(
        screen: CVPixelBuffer,
        camera: CVPixelBuffer,
        layout: CameraOverlayLayout
    ) -> CVPixelBuffer? {
        guard let overlayRect = layout.normalizedOverlayRect(
            aspectFitIn: CGSize(
                width: CVPixelBufferGetWidth(screen),
                height: CVPixelBufferGetHeight(screen)
            )
        ) else {
            return screen
        }

        let width = CVPixelBufferGetWidth(screen)
        let height = CVPixelBufferGetHeight(screen)

        let screenImage = CIImage(cvPixelBuffer: screen)
        var cameraImage = CIImage(cvPixelBuffer: camera)

        // Mirror front-facing camera for a natural selfie preview.
        cameraImage = cameraImage
            .transformed(by: CGAffineTransform(scaleX: -1, y: 1))
            .transformed(by: CGAffineTransform(translationX: cameraImage.extent.width, y: 0))

        let targetRect = CGRect(
            x: overlayRect.origin.x * CGFloat(width),
            y: overlayRect.origin.y * CGFloat(height),
            width: overlayRect.width * CGFloat(width),
            height: overlayRect.height * CGFloat(height)
        )

        let scaleX = targetRect.width / cameraImage.extent.width
        let scaleY = targetRect.height / cameraImage.extent.height
        let scale = min(scaleX, scaleY)

        let scaledCamera = cameraImage
            .transformed(by: CGAffineTransform(scaleX: scale, y: scale))

        let centeredX = targetRect.midX - scaledCamera.extent.width / 2
        let centeredY = targetRect.midY - scaledCamera.extent.height / 2
        let positionedCamera = scaledCamera.transformed(
            by: CGAffineTransform(translationX: centeredX, y: centeredY)
        )

        let composited = positionedCamera.composited(over: screenImage)
        context.render(composited, to: screen)
        return screen
    }
}
