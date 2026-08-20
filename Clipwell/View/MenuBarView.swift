//
//  MenuBarView.swift
//  Clipwell
//
//  Created by Joshua Sattler on 29.01.26.
//

import SwiftUI
import ScreenCaptureKit

/// The main menu bar interface for Clipwell
struct MenuBarView: View {
    @Bindable var viewModel: RecorderViewModel
    @Environment(\.openSettings) private var openSettings
    @Environment(\.dismiss) private var dismiss
    @State private var currentPreview: NSImage?

    private var isRecording: Bool { viewModel.isRecording }

    var body: some View {
        VStack(spacing: 0) {
            // Permission status banner (only when idle)
            if !isRecording,
               viewModel.permissionService.screenRecordingState != .granted ||
                (viewModel.settings.captureMicrophone && viewModel.permissionService.microphoneState != .granted) {
                PermissionStatusBanner(
                    permissionService: viewModel.permissionService,
                    showMicrophonePermission: viewModel.settings.captureMicrophone
                )
                MenuBarDivider()
            }

            if let error = viewModel.lastError, !isRecording {
                ErrorBanner(message: error.localizedDescription)
                MenuBarDivider()
            }

            // Recording button (stop + timer) or Start button
            if isRecording {
                HStack(spacing: 8) {
                    RecordingButton(
                        duration: viewModel.formattedDuration
                    ) {
                        Task {
                            await viewModel.stopRecording()
                        }
                    }

                    PauseButton(isPaused: viewModel.isPaused) {
                        Task {
                            await viewModel.togglePauseRecording()
                        }
                    }
                }
                .padding(.top, 8)

                if viewModel.settings.cameraCaptureMode == .builtInOverlay {
                    RecordingCameraLayoutRow(viewModel: viewModel)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 4)
                } else if viewModel.settings.cameraCaptureMode == .systemPresenterOverlay {
                    Text("Change camera layout from the macOS Video menu.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 4)
                }
            } else {
                MenuBarActionButton(
                    title: "Start Recording",
                    systemImage: "record.circle",
                    accentColor: .green,
                    isDisabled: !viewModel.canStartRecording
                ) {
                    Task {
                        await viewModel.startRecording()
                        dismiss()
                    }
                }
                .padding(.top, 8)
            }

            MenuBarDivider()

            // Content Selection
            ContentSelectionButton(viewModel: viewModel) { dismiss() }
                .disabled(isRecording)

            // Preview thumbnail
            if viewModel.hasContentSelected {
                PreviewThumbnailView(
                    previewImage: currentPreview,
                    isLivePreviewActive: viewModel.previewService.isCapturing,
                    onStartLivePreview: {
                        Task {
                            await viewModel.startPreview()
                        }
                    },
                    onStopLivePreview: {
                        Task {
                            await viewModel.stopPreview()
                        }
                    }
                )
                .onChange(of: viewModel.previewService.previewImage) { _, newImage in
                    currentPreview = newImage
                }
                .onAppear {
                    currentPreview = viewModel.previewService.previewImage
                }

                Button {
                    Task {
                        await viewModel.resetSelection()
                    }
                } label: {
                    Text("Reset Selection")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(.gray.opacity(0.15), in: .rect(cornerRadius: 6))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 12)
                .disabled(isRecording)
            }

            if !viewModel.recentRecordingURLs.isEmpty && !isRecording {
                MenuBarDivider()
                RecentRecordingsList(urls: viewModel.recentRecordingURLs)
            }

            MenuBarDivider()

            // Settings Sections
            Group {
                VideoSettingsSection(settings: viewModel.settings)

                PresenterOverlaySettingsSection(
                    settings: viewModel.settings,
                    cameraDeviceService: viewModel.cameraDeviceService
                )

                AudioSettingsSection(
                    settings: viewModel.settings,
                    audioDeviceService: viewModel.audioDeviceService
                )
            }
            .disabled(isRecording)

            MenuBarDivider()

            // Bottom Actions
            MenuBarActionButton(title: "Open Output Folder", systemImage: "folder") {
                let settings = viewModel.settings
                let didStart = settings.startAccessingOutputDirectory()
                defer {
                    if didStart {
                        settings.stopAccessingOutputDirectory()
                    }
                }
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: settings.outputDirectory.path)
            }

            MenuBarActionButton(title: "Settings...", systemImage: "gear") {
                NSApplication.shared.activate(ignoringOtherApps: true)
                openSettings()
            }

            MenuBarActionButton(title: "Quit...", systemImage: "power") {
                NSApplication.shared.terminate(nil)
            }
            .padding(.bottom, 8)
        }
        .frame(width: 320)
        .background(.ultraThinMaterial)
        .sheet(isPresented: Binding(
            get: { viewModel.showPostRecordingSheet && viewModel.lastRecordingURL != nil },
            set: { isPresented in
                if !isPresented { viewModel.dismissPostRecordingSheet() }
            }
        )) {
            if let url = viewModel.lastRecordingURL {
                PostRecordingSheet(
                    recordingURL: url,
                    outputDirectory: url.deletingLastPathComponent()
                ) {
                    viewModel.dismissPostRecordingSheet()
                }
            }
        }
    }
}

// MARK: - Menu Bar Action Button

/// A styled action button for menu bar window with hover effect
struct MenuBarActionButton: View {
    let title: String
    var systemImage: String?
    var accentColor: Color = .primary
    var isDisabled: Bool = false
    let action: () -> Void
    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let systemImage {
                    ZStack {
                        Circle()
                            .fill(.gray.opacity(0.2))
                            .frame(width: 24, height: 24)

                        Image(systemName: systemImage)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(isDisabled ? Color.gray.opacity(0.3) : accentColor.opacity(0.8))
                    }
                }
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(isDisabled ? Color.gray.opacity(0.5) : Color.primary)
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(isHovered && !isDisabled ? accentColor.opacity(0.1) : .clear)
                .padding(.horizontal, 4)
        )
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

// MARK: - Recording Button

/// A combined button that shows recording status and allows stopping
struct RecordingButton: View {
    let duration: String
    let action: () -> Void
    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Pulsing red dot with stop icon
                ZStack {
                    Circle()
                        .fill(.gray.opacity(0.2))
                        .frame(width: 24, height: 24)

                    Image(systemName: "stop.circle")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.red.opacity(0.8))
                }

                Text("Stop Recording")
                    .font(.system(size: 13, weight: .semibold))

                Spacer()

                Text(duration)
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(isHovered ? .red.opacity(0.1) : .clear)
                .padding(.horizontal, 4)
        )
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

struct PauseButton: View {
    let isPaused: Bool
    let action: () -> Void
    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            Image(systemName: isPaused ? "play.fill" : "pause.fill")
                .font(.system(size: 12, weight: .semibold))
                .frame(width: 26, height: 26)
                .background(
                    Circle()
                        .fill(.gray.opacity(0.2))
                )
                .foregroundStyle(isPaused ? .green : .primary)
        }
        .buttonStyle(.plain)
        .help(isPaused ? "Resume recording" : "Pause recording")
        .background(
            Circle()
                .fill(isHovered ? .gray.opacity(0.08) : .clear)
                .frame(width: 32, height: 32)
        )
        .onHover { isHovered = $0 }
    }
}

struct RecentRecordingsList: View {
    let urls: [URL]

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Recent")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 12)
                .padding(.top, 4)

            ForEach(urls, id: \.path) { url in
                Button {
                    NSWorkspace.shared.activateFileViewerSelecting([url])
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "film")
                            .font(.system(size: 11))
                            .foregroundStyle(.secondary)
                        Text(url.lastPathComponent)
                            .font(.system(size: 11))
                            .lineLimit(1)
                            .truncationMode(.middle)
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 3)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.bottom, 4)
    }
}

// MARK: - Content Selection Button

/// A split button that triggers the active content selection mode, with a dropdown chevron to switch modes.
/// The left portion triggers the action; the right chevron opens a dropdown to change the mode.
/// Styled consistently with other menu bar rows.
struct ContentSelectionButton: View {
    let viewModel: RecorderViewModel
    var onDismissPanel: (() -> Void)?
    @AppStorage(ContentSelectionMode.storageKey) private var mode: ContentSelectionMode = .pickContent
    @State private var isDropdownExpanded = false
    @State private var isMainHovered = false
    @State private var isChevronHovered = false

    /// Whether content has been selected via the currently active mode
    private var hasActiveSelection: Bool {
        switch mode {
        case .pickContent:
            viewModel.hasContentSelected && !viewModel.isAreaSelection
        case .selectArea:
            viewModel.isAreaSelection
        }
    }

    private var buttonLabel: String {
        hasActiveSelection ? "Change \(mode.label.split(separator: " ").last, default: "Content")..." : "\(mode.label)..."
    }

    var body: some View {
        VStack(spacing: 0) {
            // Main button row
            HStack(spacing: 0) {
                // Left: action button
                Button {
                    triggerAction()
                } label: {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(hasActiveSelection ? .blue.opacity(0.8) : .gray.opacity(0.2))
                                .frame(width: 24, height: 24)

                            Image(systemName: mode.icon)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(hasActiveSelection ? .white : .primary)
                        }

                        Text(buttonLabel)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.primary)

                        Spacer()
                    }
                    .padding(.leading, 12)
                    .padding(.vertical, 4)
                    .contentShape(.rect)
                }
                .buttonStyle(.plain)
                .onHover { hovering in
                    isMainHovered = hovering
                }

                // Right: chevron dropdown toggle
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isDropdownExpanded.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isDropdownExpanded ? 90 : 0))
                        .frame(width: 28, height: 28)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 12)
                .onHover { hovering in
                    isChevronHovered = hovering
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill((isMainHovered || isChevronHovered) ? .gray.opacity(0.1) : .clear)
                    .padding(.horizontal, 4)
            )

            // Dropdown options
            if isDropdownExpanded {
                VStack(spacing: 0) {
                    DeviceRow(
                        name: ContentSelectionMode.pickContent.label,
                        icon: ContentSelectionMode.pickContent.icon,
                        isSelected: mode == .pickContent
                    ) {
                        mode = .pickContent
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isDropdownExpanded = false
                        }
                    }

                    DeviceRow(
                        name: ContentSelectionMode.selectArea.label,
                        icon: ContentSelectionMode.selectArea.icon,
                        isSelected: mode == .selectArea
                    ) {
                        mode = .selectArea
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isDropdownExpanded = false
                        }
                    }
                }
                .padding(.leading, 12)
                .background(.quaternary.opacity(0.3))
            }
        }
    }

    private func triggerAction() {
        switch mode {
        case .pickContent:
            // Keep the menu-bar window open while the system picker is active.
            viewModel.presentPicker()
        case .selectArea:
            onDismissPanel?()
            Task {
                await viewModel.presentAreaSelection()
            }
        }
    }
}

// MARK: - Permission Status Banner

/// A banner showing missing permissions with buttons to open System Settings
struct PermissionStatusBanner: View {
    let permissionService: PermissionService
    let showMicrophonePermission: Bool

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.orange)
                Text("Permissions Required")
                    .font(.system(size: 13, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.top, 8)

            if permissionService.screenRecordingState != .granted {
                PermissionRow(
                    title: "Screen Recording",
                    isGranted: false
                ) {
                    // Request first so TCC creates a row for this exact app identity,
                    // then open Settings so the user can enable it.
                    permissionService.requestScreenRecordingPermission()
                    permissionService.openScreenRecordingSettings()
                }

                Text("Enable **Clipwell** in the list — not the old Clipwell entries.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 4)
            }

            if showMicrophonePermission && permissionService.microphoneState != .granted {
                PermissionRow(
                    title: "Allow Microphone",
                    isGranted: false
                ) {
                    Task {
                        await permissionService.promptMicrophonePermission()
                    }
                }

                if permissionService.microphoneState == .denied {
                    PermissionRow(
                        title: "Open Microphone Settings",
                        isGranted: false
                    ) {
                        permissionService.openMicrophoneSettings()
                    }
                }

                Text("Click **Allow Microphone** first. Clipwell appears in Settings only after you approve the system dialog.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 4)
            }
        }
        .padding(.bottom, 8)
    }
}

/// A single permission row with status and action button
struct PermissionRow: View {
    let title: String
    let isGranted: Bool
    let action: () -> Void
    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: isGranted ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(isGranted ? .green : .red)
                    .font(.system(size: 12))

                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(.primary)

                Spacer()

                if !isGranted {
                    Text("Open Settings")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(isHovered ? .gray.opacity(0.1) : .clear)
                .padding(.horizontal, 4)
        )
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

// MARK: - Error Banner

struct ErrorBanner: View {
    let message: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.orange)
            Text(message)
                .font(.caption)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}

// MARK: - Camera Layout Row

struct RecordingCameraLayoutRow: View {
    let viewModel: RecorderViewModel

    var body: some View {
        HStack(spacing: 6) {
            ForEach(CameraOverlayLayout.allCases) { layout in
                Button {
                    viewModel.setCameraOverlayLayout(layout)
                } label: {
                    Image(systemName: layout.systemImage)
                        .frame(width: 26, height: 26)
                }
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(viewModel.cameraOverlayLayout == layout ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.12))
                )
                .help(layout.displayName)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MenuBarView(viewModel: RecorderViewModel())
}
