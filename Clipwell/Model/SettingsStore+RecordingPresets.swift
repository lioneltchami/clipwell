//
//  SettingsStore+RecordingPresets.swift
//  Clipwell
//

import Foundation

extension SettingsStore {
    // MARK: - Recording Presets

    var recordingPresets: [RecordingPreset] {
        get {
            access(keyPath: \.recordingPresets)
            guard let data = defaults.data(forKey: "recordingPresets") else {
                return []
            }
            return (try? JSONDecoder().decode([RecordingPreset].self, from: data)) ?? []
        }
        set {
            withMutation(keyPath: \.recordingPresets) {
                guard let data = try? JSONEncoder().encode(newValue) else {
                    return
                }
                defaults.set(data, forKey: "recordingPresets")
            }
        }
    }

    @discardableResult
    func saveRecordingPreset(named name: String) -> RecordingPreset {
        let preset = RecordingPreset(name: availablePresetName(for: name), settings: self)
        recordingPresets.append(preset)
        return preset
    }

    func applyRecordingPreset(_ preset: RecordingPreset) {
        preset.apply(to: self)
    }

    func deleteRecordingPreset(_ preset: RecordingPreset) {
        recordingPresets.removeAll { $0.id == preset.id }
    }

    private func availablePresetName(for name: String) -> String {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let baseName = trimmedName.isEmpty ? "Recording Preset" : trimmedName
        let existingNames = Set(recordingPresets.map { $0.name.localizedLowercase })

        guard existingNames.contains(baseName.localizedLowercase) else {
            return baseName
        }

        var index = 2
        while existingNames.contains("\(baseName) \(index)".localizedLowercase) {
            index += 1
        }
        return "\(baseName) \(index)"
    }
}
