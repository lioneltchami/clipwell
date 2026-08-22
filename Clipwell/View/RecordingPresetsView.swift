//
//  RecordingPresetsView.swift
//  Clipwell
//

import SwiftUI

/// Recording Presets controls for applying saved capture setups before recording.
struct RecordingPresetsMenuSection: View {
    @Bindable var settings: SettingsStore
    @State private var presetName = ""

    var body: some View {
        VStack(spacing: 0) {
            SectionHeader(title: "Recording Presets")

            MenuBarExpandableSection(title: settings.recordingPresets.isEmpty ? "Save Current Setup" : "Apply or Save Setup") {
                VStack(alignment: .leading, spacing: 6) {
                    if settings.recordingPresets.isEmpty {
                        Text("Save your current video, audio, overlay, and capture settings for later.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 6)
                    } else {
                        ForEach(settings.recordingPresets) { preset in
                            HStack(spacing: 8) {
                                Text(preset.name)
                                    .lineLimit(1)
                                Spacer()
                                Button("Apply") {
                                    settings.applyRecordingPreset(preset)
                                }
                                .buttonStyle(.borderless)

                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    settings.deleteRecordingPreset(preset)
                                }
                                .buttonStyle(.borderless)
                                .labelStyle(.iconOnly)
                                .help("Delete \(preset.name)")
                            }
                            .font(.caption)
                        }
                    }

                    TextField("Preset name", text: $presetName)
                        .textFieldStyle(.roundedBorder)

                    Button("Save Current Setup", systemImage: "plus") {
                        settings.saveRecordingPreset(named: presetName)
                        presetName = ""
                    }
                    .buttonStyle(.borderless)
                }
                .padding(.vertical, 6)
                .padding(.trailing, 12)
            }
        }
    }
}

/// Full settings-window management surface for Recording Presets.
struct RecordingPresetsSettingsView: View {
    @Bindable var settings: SettingsStore
    @State private var presetName = ""

    var body: some View {
        Form {
            Section("Saved Presets") {
                if settings.recordingPresets.isEmpty {
                    Text("No recording presets yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(settings.recordingPresets) { preset in
                        LabeledContent(preset.name) {
                            HStack {
                                Button("Apply") {
                                    settings.applyRecordingPreset(preset)
                                }
                                Button("Delete", role: .destructive) {
                                    settings.deleteRecordingPreset(preset)
                                }
                            }
                        }
                    }
                }
            }

            Section("Save Current Setup") {
                TextField("Preset name", text: $presetName)
                Button("Save Current Settings", systemImage: "plus") {
                    settings.saveRecordingPreset(named: presetName)
                    presetName = ""
                }
            }

            Section {
                Text(
                    "A preset captures portable video, audio, camera, countdown, overlay, and content-filter settings. " +
                        "It does not change your selected screen, window, capture area, device selection, or output folder."
                )
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .formStyle(.grouped)
        .padding()
    }
}

#Preview {
    RecordingPresetsSettingsView(settings: SettingsStore())
}
