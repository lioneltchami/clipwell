//
//  ClipwellApp.swift
//  Clipwell
//
//  Created by Joshua Sattler on 29.01.26.
//

import AppKit
import KeyboardShortcuts
import SwiftUI

@main
struct ClipwellApp: App {
    @State private var viewModel = RecorderViewModel()
    @State private var updaterService = UpdaterService()
    var body: some Scene {
        // Menu bar extra - the primary interface
        // Using .window style to support custom toggle switches
        MenuBarExtra {
            MenuBarView(viewModel: viewModel)
                .task {
                    await viewModel.requestPermissionsOnLaunch()
                    registerKeyboardShortcuts()
                }
                .onOpenURL { url in
                    handleURL(url)
                }
        } label: {
            MenuBarLabel(viewModel: viewModel)
        }
        .menuBarExtraStyle(.window)

        // Settings window
        Settings {
            SettingsView(settings: viewModel.settings, updaterService: updaterService)
        }
    }

    // MARK: - URL Scheme

    private func handleURL(_ url: URL) {
        // Preserve prior automation links during the Clipwell migration.
        let supportedSchemes: Set<String> = ["clipwell", "captureforge", "bettercapture"]
        guard let scheme = url.scheme?.lowercased(), supportedSchemes.contains(scheme) else { return }

        switch url.host {
        case "toggle", "toggle-copy":
            let copyToClipboard = url.host == "toggle-copy"
            Task { @MainActor in
                if viewModel.isRecording {
                    await viewModel.stopRecording(copyToClipboard: copyToClipboard)
                } else {
                    await viewModel.toggleRecording()
                }
            }
        case "open-recordings":
            Task { @MainActor in
                let settings = viewModel.settings
                let didStart = settings.startAccessingOutputDirectory()
                defer {
                    if didStart {
                        settings.stopAccessingOutputDirectory()
                    }
                }
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: settings.outputDirectory.path)
            }
        default:
            break
        }
    }

    // MARK: - Keyboard Shortcuts

    private func registerKeyboardShortcuts() {
        KeyboardShortcuts.onKeyUp(for: .toggleRecording) { [viewModel] in
            Task { @MainActor in
                await viewModel.toggleRecording()
            }
        }

        KeyboardShortcuts.onKeyUp(for: .selectContent) { [viewModel] in
            Task { @MainActor in
                viewModel.presentPicker()
            }
        }

        KeyboardShortcuts.onKeyUp(for: .selectArea) { [viewModel] in
            Task { @MainActor in
                await viewModel.presentAreaSelection()
            }
        }

        KeyboardShortcuts.onKeyUp(for: .cycleCameraLayout) { [viewModel] in
            Task { @MainActor in
                guard viewModel.isRecording,
                      viewModel.settings.cameraCaptureMode == .builtInOverlay else { return }
                viewModel.cycleCameraOverlayLayout()
            }
        }

        KeyboardShortcuts.onKeyUp(for: .cameraLayoutSmall) { [viewModel] in
            Task { @MainActor in
                guard viewModel.isRecording,
                      viewModel.settings.cameraCaptureMode == .builtInOverlay else { return }
                viewModel.setCameraOverlayLayout(.smallCorner)
            }
        }

        KeyboardShortcuts.onKeyUp(for: .cameraLayoutLarge) { [viewModel] in
            Task { @MainActor in
                guard viewModel.isRecording,
                      viewModel.settings.cameraCaptureMode == .builtInOverlay else { return }
                viewModel.setCameraOverlayLayout(.largeCorner)
            }
        }

        KeyboardShortcuts.onKeyUp(for: .cameraLayoutBar) { [viewModel] in
            Task { @MainActor in
                guard viewModel.isRecording,
                      viewModel.settings.cameraCaptureMode == .builtInOverlay else { return }
                viewModel.setCameraOverlayLayout(.bottomBar)
            }
        }

        KeyboardShortcuts.onKeyUp(for: .cameraLayoutHidden) { [viewModel] in
            Task { @MainActor in
                guard viewModel.isRecording,
                      viewModel.settings.cameraCaptureMode == .builtInOverlay else { return }
                viewModel.setCameraOverlayLayout(.hidden)
            }
        }

        KeyboardShortcuts.onKeyUp(for: .togglePauseRecording) { [viewModel] in
            Task { @MainActor in
                await viewModel.togglePauseRecording()
            }
        }

        KeyboardShortcuts.onKeyUp(for: .toggleAnnotationDrawMode) { [viewModel] in
            Task { @MainActor in
                viewModel.toggleAnnotationDrawMode()
            }
        }

        KeyboardShortcuts.onKeyUp(for: .clearAnnotations) { [viewModel] in
            Task { @MainActor in
                viewModel.clearAnnotations()
            }
        }
    }
}

/// The label shown in the menu bar (icon or duration timer)
struct MenuBarLabel: View {
    let viewModel: RecorderViewModel

    var body: some View {
        if viewModel.isRecording {
            // Render the duration into a fixed-size image so the
            // NSStatusItem never recalculates its width on each tick.
            if let image = timerImage {
                Image(nsImage: image)
            }
        } else {
            Image(systemName: "record.circle")
        }
    }

    /// Renders the formatted duration into an ``NSImage`` with a stable
    /// width derived from the widest possible string for the current format.
    private var timerImage: NSImage? {
        let text = viewModel.formattedDuration

        // Use the widest possible string for the current format to
        // compute a stable size that won't change between ticks.
        let referenceText: String = if viewModel.recordingDuration >= 3600 {
            "0:00:00"
        } else {
            "00:00"
        }

        let font = NSFont.monospacedDigitSystemFont(ofSize: 13, weight: .regular)
        let attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: NSColor.white
        ]

        let referenceSize = (referenceText as NSString).size(withAttributes: attrs)
        let imageSize = NSSize(width: ceil(referenceSize.width), height: ceil(referenceSize.height))

        let textSize = (text as NSString).size(withAttributes: attrs)
        let origin = NSPoint(
            x: (imageSize.width - textSize.width) / 2,
            y: (imageSize.height - textSize.height) / 2
        )

        let image = NSImage(size: imageSize, flipped: false) { _ in
            (text as NSString).draw(at: origin, withAttributes: attrs)
            return true
        }
        image.isTemplate = true
        return image
    }
}
