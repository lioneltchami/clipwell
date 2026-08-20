//
//  CountdownOverlay.swift
//  BetterCapture
//

import AppKit
import SwiftUI

@MainActor
final class CountdownOverlay {
    private var panel: NSPanel?
    private var label = CountdownOverlayLabel(number: 3)

    func show(number: Int) {
        if panel == nil {
            createPanel()
        }
        label = CountdownOverlayLabel(number: number)
        if let hostingView = panel?.contentView as? NSHostingView<CountdownOverlayLabel> {
            hostingView.rootView = label
        }
        panel?.orderFrontRegardless()
    }

    func dismiss() {
        panel?.orderOut(nil)
        panel = nil
    }

    private func createPanel() {
        guard let screen = NSScreen.main ?? NSScreen.screens.first else { return }
        let size = CGSize(width: 180, height: 180)
        let origin = CGPoint(
            x: screen.frame.midX - size.width / 2,
            y: screen.frame.midY - size.height / 2
        )

        let newPanel = NSPanel(
            contentRect: CGRect(origin: origin, size: size),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        newPanel.isOpaque = false
        newPanel.backgroundColor = .clear
        newPanel.hasShadow = false
        newPanel.level = .screenSaver
        newPanel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        newPanel.ignoresMouseEvents = true
        newPanel.isReleasedWhenClosed = false

        let hostingView = NSHostingView(rootView: label)
        hostingView.frame = CGRect(origin: .zero, size: size)
        newPanel.contentView = hostingView
        panel = newPanel
    }
}

private struct CountdownOverlayLabel: View {
    let number: Int

    var body: some View {
        ZStack {
            Circle()
                .fill(.black.opacity(0.45))
            Text(number.formatted())
                .font(.system(size: 96))
                .bold()
                .foregroundStyle(.white)
        }
        .padding(8)
    }
}
