//
//  CameraControlPanel.swift
//  BetterCapture
//

import AppKit
import SwiftUI

/// Floating control strip for switching built-in camera layouts during recording.
@MainActor
final class CameraControlPanel {

    private var panel: NSPanel?
    private var onLayoutSelected: ((CameraOverlayLayout) -> Void)?

    func show(layout: CameraOverlayLayout, onLayoutSelected: @escaping (CameraOverlayLayout) -> Void) {
        self.onLayoutSelected = onLayoutSelected

        if panel != nil {
            return
        }

        let width: CGFloat = 260
        let height: CGFloat = 52
        let screen = NSScreen.main ?? NSScreen.screens[0]
        let origin = CGPoint(
            x: screen.frame.midX - width / 2,
            y: screen.frame.maxY - NSStatusBar.system.thickness - height - 12
        )

        let newPanel = NSPanel(
            contentRect: CGRect(origin: origin, size: CGSize(width: width, height: height)),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        newPanel.isOpaque = false
        newPanel.backgroundColor = .clear
        newPanel.hasShadow = true
        newPanel.level = .floating
        newPanel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        newPanel.isReleasedWhenClosed = false

        let hostingView = NSHostingView(
            rootView: CameraControlPanelView(
                selectedLayout: layout,
                onSelect: { [weak self] layout in
                    self?.onLayoutSelected?(layout)
                }
            )
        )
        hostingView.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        newPanel.contentView = hostingView
        newPanel.orderFrontRegardless()
        panel = newPanel
    }

    func updateLayout(_ layout: CameraOverlayLayout) {
        guard let panel, let hostingView = panel.contentView as? NSHostingView<CameraControlPanelView> else {
            return
        }
        hostingView.rootView = CameraControlPanelView(
            selectedLayout: layout,
            onSelect: { [weak self] layout in
                self?.onLayoutSelected?(layout)
            }
        )
    }

    func dismiss() {
        panel?.orderOut(nil)
        panel = nil
        onLayoutSelected = nil
    }
}

private struct CameraControlPanelView: View {
    let selectedLayout: CameraOverlayLayout
    let onSelect: (CameraOverlayLayout) -> Void

    var body: some View {
        HStack(spacing: 6) {
            ForEach(CameraOverlayLayout.allCases) { layout in
                Button {
                    onSelect(layout)
                } label: {
                    Label(layout.displayName, systemImage: layout.systemImage)
                        .labelStyle(.iconOnly)
                        .frame(width: 28, height: 28)
                }
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(selectedLayout == layout ? Color.accentColor.opacity(0.25) : Color.gray.opacity(0.15))
                )
                .help(layout.displayName)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
    }
}
