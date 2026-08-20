//
//  RecordingAidsOverlay.swift
//  BetterCapture
//

import AppKit
import Combine
import SwiftUI

@MainActor
final class RecordingAidsOverlay {
    private var panel: NSPanel?
    private var model = RecordingAidsModel()
    private var clickMonitor: Any?
    private var keyMonitor: Any?
    private weak var annotationState: AnnotationState?
    private var captureFrame: CGRect = .zero
    private(set) var isDrawModeEnabled = false

    func show(
        on screen: NSScreen?,
        captureFrame: CGRect,
        showClicks: Bool,
        showKeys: Bool,
        enableAnnotation: Bool,
        annotationState: AnnotationState
    ) {
        guard showClicks || showKeys || enableAnnotation else { return }

        self.annotationState = annotationState
        self.captureFrame = captureFrame
        isDrawModeEnabled = false

        if panel == nil {
            createPanel(frame: captureFrame)
        } else if let panel {
            panel.setFrame(captureFrame, display: true)
        }

        model.resetForSession(
            showClicks: showClicks,
            showKeys: showKeys,
            enableAnnotation: enableAnnotation,
            existingStrokes: annotationState.snapshot()
        )
        applyInteractionMode()
        panel?.orderFrontRegardless()

        if showClicks, clickMonitor == nil {
            clickMonitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] event in
                Task { @MainActor in
                    self?.model.registerClick(at: event.locationInWindow)
                }
            }
        }

        if showKeys, keyMonitor == nil {
            keyMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
                Task { @MainActor in
                    self?.model.registerKey(event.charactersIgnoringModifiers ?? "")
                }
            }
        }
    }

    func setDrawModeEnabled(_ enabled: Bool) {
        guard model.enableAnnotation else { return }
        isDrawModeEnabled = enabled
        model.isDrawModeEnabled = enabled
        applyInteractionMode()
    }

    func clearAnnotations() {
        model.clearStrokes()
        annotationState?.clear()
    }

    func dismiss() {
        if let clickMonitor {
            NSEvent.removeMonitor(clickMonitor)
            self.clickMonitor = nil
        }
        if let keyMonitor {
            NSEvent.removeMonitor(keyMonitor)
            self.keyMonitor = nil
        }
        isDrawModeEnabled = false
        panel?.orderOut(nil)
        panel = nil
        annotationState = nil
    }

    private func applyInteractionMode() {
        panel?.ignoresMouseEvents = !isDrawModeEnabled
    }

    private func createPanel(frame: CGRect) {
        let newPanel = NSPanel(
            contentRect: frame,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        newPanel.isOpaque = false
        newPanel.backgroundColor = .clear
        newPanel.level = .floating
        newPanel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        newPanel.isReleasedWhenClosed = false
        newPanel.ignoresMouseEvents = true

        let host = NSHostingView(
            rootView: RecordingAidsView(model: model) { [weak self] stroke in
                self?.annotationState?.addStroke(stroke)
            }
        )
        host.frame = CGRect(origin: .zero, size: frame.size)
        newPanel.contentView = host
        panel = newPanel
    }
}

@MainActor
final class RecordingAidsModel: ObservableObject {
    @Published var showClicks = false
    @Published var showKeys = false
    @Published var enableAnnotation = false
    @Published var isDrawModeEnabled = false
    @Published var strokes: [AnnotationStroke] = []
    @Published var activeStrokePoints: [AnnotationPoint] = []
    @Published var lastClick: CGPoint?
    @Published var lastKey = ""

    func resetForSession(
        showClicks: Bool,
        showKeys: Bool,
        enableAnnotation: Bool,
        existingStrokes: [AnnotationStroke]
    ) {
        self.showClicks = showClicks
        self.showKeys = showKeys
        self.enableAnnotation = enableAnnotation
        isDrawModeEnabled = false
        strokes = existingStrokes
        activeStrokePoints = []
        lastClick = nil
        lastKey = ""
    }

    func clearStrokes() {
        strokes = []
        activeStrokePoints = []
    }

    func beginStroke(at location: CGPoint, in size: CGSize) {
        activeStrokePoints = [AnnotationPoint(location: location, in: size)]
    }

    func extendStroke(to location: CGPoint, in size: CGSize) {
        let point = AnnotationPoint(location: location, in: size)
        if activeStrokePoints.last != point {
            activeStrokePoints.append(point)
        }
    }

    func finishStroke(onCommit: (AnnotationStroke) -> Void) {
        guard activeStrokePoints.count >= 2 else {
            activeStrokePoints = []
            return
        }
        let stroke = AnnotationStroke(points: activeStrokePoints)
        strokes.append(stroke)
        onCommit(stroke)
        activeStrokePoints = []
    }

    func registerClick(at point: CGPoint) {
        lastClick = point
        Task {
            try? await Task.sleep(for: .milliseconds(350))
            if self.lastClick == point {
                self.lastClick = nil
            }
        }
    }

    func registerKey(_ key: String) {
        guard !key.isEmpty else { return }
        lastKey = key.uppercased()
        Task {
            try? await Task.sleep(for: .milliseconds(1200))
            if self.lastKey == key.uppercased() {
                self.lastKey = ""
            }
        }
    }
}

private struct RecordingAidsView: View {
    @ObservedObject var model: RecordingAidsModel
    let onStrokeCommitted: (AnnotationStroke) -> Void

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                annotationLayer(in: proxy.size)

                if model.showClicks, let point = model.lastClick {
                    Circle()
                        .stroke(.red, lineWidth: 4)
                        .frame(width: 46, height: 46)
                        .position(x: point.x, y: proxy.size.height - point.y)
                }

                if model.showKeys, !model.lastKey.isEmpty {
                    Text(model.lastKey)
                        .font(.system(size: 26))
                        .bold()
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(.black.opacity(0.55), in: .rect(cornerRadius: 10))
                        .foregroundStyle(.white)
                        .padding(16)
                }

                if model.enableAnnotation, model.isDrawModeEnabled {
                    Text("Drawing · exit or clear from shortcuts")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.black.opacity(0.55), in: .rect(cornerRadius: 8))
                        .foregroundStyle(.white)
                        .padding(.top, 12)
                        .padding(.leading, 12)
                }
            }
        }
    }

    @ViewBuilder
    private func annotationLayer(in size: CGSize) -> some View {
        if model.enableAnnotation {
            Canvas { context, canvasSize in
                var strokePath = Path()
                for stroke in model.strokes {
                    append(stroke: stroke, to: &strokePath, in: canvasSize)
                }
                if !model.activeStrokePoints.isEmpty {
                    append(points: model.activeStrokePoints, to: &strokePath, in: canvasSize)
                }
                context.stroke(
                    strokePath,
                    with: .color(.red.opacity(0.92)),
                    style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
                )
            }
            .allowsHitTesting(model.isDrawModeEnabled)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard model.isDrawModeEnabled else { return }
                        if model.activeStrokePoints.isEmpty {
                            model.beginStroke(at: value.location, in: size)
                        } else {
                            model.extendStroke(to: value.location, in: size)
                        }
                    }
                    .onEnded { _ in
                        guard model.isDrawModeEnabled else { return }
                        model.finishStroke(onCommit: onStrokeCommitted)
                    }
            )
        }
    }

    private func append(stroke: AnnotationStroke, to path: inout Path, in size: CGSize) {
        append(points: stroke.points, to: &path, in: size)
    }

    private func append(points: [AnnotationPoint], to path: inout Path, in size: CGSize) {
        guard let first = points.first else { return }
        path.move(to: scaled(first, in: size))
        for point in points.dropFirst() {
            path.addLine(to: scaled(point, in: size))
        }
    }

    private func scaled(_ point: AnnotationPoint, in size: CGSize) -> CGPoint {
        CGPoint(x: point.x * size.width, y: point.y * size.height)
    }
}
