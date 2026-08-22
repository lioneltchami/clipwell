//
//  SettingsStore.swift
//  Clipwell
//
//  Created by Joshua Sattler on 29.01.26.
//

import AppKit
import Foundation

/// Persists user preferences using UserDefaults
@MainActor
@Observable
final class SettingsStore {

    // MARK: - Dependencies

    private let defaults: UserDefaults

    // MARK: - Initialization

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - Video Settings

    var frameRate: FrameRate {
        get {
            FrameRate(rawValue: frameRateRaw) ?? .fps60
        }
        set {
            frameRateRaw = newValue.rawValue
        }
    }

    var videoQuality: VideoQuality {
        get {
            VideoQuality(rawValue: videoQualityRaw) ?? .medium
        }
        set {
            videoQualityRaw = newValue.rawValue
        }
    }

    var videoCodec: VideoCodec {
        get {
            VideoCodec(rawValue: videoCodecRaw) ?? .hevc
        }
        set {
            // Ensure the codec is compatible with the current container format
            guard containerFormat.supportedVideoCodecs.contains(newValue) else {
                // If codec is not compatible, switch to MOV container first
                containerFormatRaw = ContainerFormat.mov.rawValue
                videoCodecRaw = newValue.rawValue
                return
            }

            videoCodecRaw = newValue.rawValue

            // Set alpha channel based on codec and container capabilities
            if newValue.alwaysHasAlpha {
                // ProRes 4444 always has alpha, requires MOV container
                captureAlphaChannel = true
            } else if !newValue.supportsAlphaChannel || !containerFormat.supportsAlphaChannel {
                // H.264, ProRes 422 never have alpha, or container doesn't support it
                captureAlphaChannel = false
            }
            // HEVC can toggle alpha (if container supports it), so leave it as-is

            // Disable HDR for codecs that don't support it
            if !newValue.supportsHDR {
                captureHDR = false
            }

            // HEVC with alpha uses a separate codec type that doesn't support
            // Main 10 HDR, so alpha and HDR are mutually exclusive for HEVC.
            if newValue == .hevc && captureHDR {
                captureAlphaChannel = false
            }
        }
    }

    var containerFormat: ContainerFormat {
        get {
            ContainerFormat(rawValue: containerFormatRaw) ?? .mov
        }
        set {
            containerFormatRaw = newValue.rawValue

            // Ensure current video codec is compatible with new container
            if !newValue.supportedVideoCodecs.contains(videoCodec) {
                // Switch to a compatible codec (prefer HEVC for quality)
                videoCodec = .hevc
            }

            // Disable alpha channel if container doesn't support it
            if !newValue.supportsAlphaChannel {
                captureAlphaChannel = false
            }

            // Ensure current audio codec is compatible with new container
            if !newValue.supportedAudioCodecs.contains(audioCodec) {
                audioCodec = .aac
            }
        }
    }

    var captureAlphaChannel: Bool {
        get {
            access(keyPath: \.captureAlphaChannel)
            // ProRes 4444 always has alpha regardless of stored value
            if videoCodec.alwaysHasAlpha {
                return true
            }
            // If codec or container doesn't support alpha, always return false
            if !videoCodec.supportsAlphaChannel || !containerFormat.supportsAlphaChannel {
                return false
            }
            // HEVC with alpha uses a different codec type incompatible with Main 10 HDR
            if videoCodec == .hevc && captureHDR {
                return false
            }
            return defaults.bool(forKey: "captureAlphaChannel")
        }
        set {
            // Only allow alpha channel if both codec and container support it
            let canEnable = videoCodec.supportsAlphaChannel && containerFormat.supportsAlphaChannel
            var finalValue = newValue && canEnable

            // HEVC alpha and HDR are mutually exclusive
            if videoCodec == .hevc && finalValue && captureHDR {
                finalValue = false
            }

            withMutation(keyPath: \.captureAlphaChannel) {
                defaults.set(finalValue, forKey: "captureAlphaChannel")
            }
        }
    }

    var captureHDR: Bool {
        get {
            access(keyPath: \.captureHDR)
            return defaults.bool(forKey: "captureHDR")
        }
        set {
            withMutation(keyPath: \.captureHDR) {
                defaults.set(newValue, forKey: "captureHDR")
            }

            // HEVC alpha and HDR are mutually exclusive
            if newValue && videoCodec == .hevc {
                captureAlphaChannel = false
            }
        }
    }

    var captureNativeResolution: Bool {
        get {
            access(keyPath: \.captureNativeResolution)
            return defaults.object(forKey: "captureNativeResolution") as? Bool ?? true
        }
        set {
            withMutation(keyPath: \.captureNativeResolution) {
                defaults.set(newValue, forKey: "captureNativeResolution")
            }
        }
    }

    /// The active HDR preset for the current codec and OS version.
    ///
    /// Both ``CaptureEngine`` and ``AssetWriter`` use this to ensure the
    /// stream configuration and output color tags stay in sync.
    var hdrPreset: HDRPreset {
        guard captureHDR && videoCodec.supportsHDR else { return .sdr }
        if #available(macOS 26, *) {
            return .hdr10PreservedSDR
        }
        return .hdr10Manual
    }

    // MARK: - Audio Settings

    var captureMicrophone: Bool {
        get {
            access(keyPath: \.captureMicrophone)
            return defaults.bool(forKey: "captureMicrophone")
        }
        set {
            withMutation(keyPath: \.captureMicrophone) {
                defaults.set(newValue, forKey: "captureMicrophone")
            }
        }
    }

    var captureSystemAudio: Bool {
        get {
            access(keyPath: \.captureSystemAudio)
            return defaults.bool(forKey: "captureSystemAudio")
        }
        set {
            withMutation(keyPath: \.captureSystemAudio) {
                defaults.set(newValue, forKey: "captureSystemAudio")
            }
        }
    }

    var audioCodec: AudioCodec {
        get {
            AudioCodec(rawValue: audioCodecRaw) ?? .aac
        }
        set {
            // Ensure the audio codec is compatible with the current container format
            guard containerFormat.supportedAudioCodecs.contains(newValue) else {
                // If codec is not compatible, switch to MOV container first
                containerFormatRaw = ContainerFormat.mov.rawValue
                audioCodecRaw = newValue.rawValue
                return
            }

            audioCodecRaw = newValue.rawValue
        }
    }

    var selectedMicrophoneID: String? {
        get {
            access(keyPath: \.selectedMicrophoneID)
            return defaults.string(forKey: "selectedMicrophoneID")
        }
        set {
            withMutation(keyPath: \.selectedMicrophoneID) {
                defaults.set(newValue, forKey: "selectedMicrophoneID")
            }
        }
    }

    // MARK: - Camera Settings

    var cameraCaptureMode: CameraCaptureMode {
        get {
            access(keyPath: \.cameraCaptureMode)
            if let raw = defaults.string(forKey: "cameraCaptureMode"),
               let mode = CameraCaptureMode(rawValue: raw) {
                return mode
            }
            if defaults.bool(forKey: "presenterOverlayEnabled") {
                return .systemPresenterOverlay
            }
            return .off
        }
        set {
            withMutation(keyPath: \.cameraCaptureMode) {
                defaults.set(newValue.rawValue, forKey: "cameraCaptureMode")
            }
        }
    }

    /// Legacy toggle mapped to system Presenter Overlay mode.
    var presenterOverlayEnabled: Bool {
        get { cameraCaptureMode == .systemPresenterOverlay }
        set { cameraCaptureMode = newValue ? .systemPresenterOverlay : .off }
    }

    var showPostRecordingSheet: Bool {
        get {
            access(keyPath: \.showPostRecordingSheet)
            return defaults.object(forKey: "showPostRecordingSheet") as? Bool ?? true
        }
        set {
            withMutation(keyPath: \.showPostRecordingSheet) {
                defaults.set(newValue, forKey: "showPostRecordingSheet")
            }
        }
    }

    /// Seconds to wait before capture starts (0, 3, or 5).
    var recordingCountdownSeconds: Int {
        get {
            access(keyPath: \.recordingCountdownSeconds)
            let value = defaults.integer(forKey: "recordingCountdownSeconds")
            return [0, 3, 5].contains(value) ? value : 0
        }
        set {
            withMutation(keyPath: \.recordingCountdownSeconds) {
                defaults.set(newValue, forKey: "recordingCountdownSeconds")
            }
        }
    }

    var recentRecordingPaths: [String] {
        get {
            access(keyPath: \.recentRecordingPaths)
            return defaults.stringArray(forKey: "recentRecordingPaths") ?? []
        }
        set {
            withMutation(keyPath: \.recentRecordingPaths) {
                defaults.set(newValue, forKey: "recentRecordingPaths")
            }
        }
    }

    var showClickHighlighter: Bool {
        get {
            access(keyPath: \.showClickHighlighter)
            return defaults.object(forKey: "showClickHighlighter") as? Bool ?? false
        }
        set {
            withMutation(keyPath: \.showClickHighlighter) {
                defaults.set(newValue, forKey: "showClickHighlighter")
            }
        }
    }

    var showKeystrokeOverlay: Bool {
        get {
            access(keyPath: \.showKeystrokeOverlay)
            return defaults.object(forKey: "showKeystrokeOverlay") as? Bool ?? false
        }
        set {
            withMutation(keyPath: \.showKeystrokeOverlay) {
                defaults.set(newValue, forKey: "showKeystrokeOverlay")
            }
        }
    }

    var enableAnnotationLayer: Bool {
        get {
            access(keyPath: \.enableAnnotationLayer)
            return defaults.object(forKey: "enableAnnotationLayer") as? Bool ?? false
        }
        set {
            withMutation(keyPath: \.enableAnnotationLayer) {
                defaults.set(newValue, forKey: "enableAnnotationLayer")
            }
        }
    }

    /// The selected camera device ID for Presenter Overlay, or `nil` for the system default.
    var selectedCameraID: String? {
        get {
            access(keyPath: \.selectedCameraID)
            return defaults.string(forKey: "selectedCameraID")
        }
        set {
            withMutation(keyPath: \.selectedCameraID) {
                defaults.set(newValue, forKey: "selectedCameraID")
            }
        }
    }

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

    // MARK: - Content Filter Settings

    var showCursor: Bool {
        get {
            access(keyPath: \.showCursor)
            return defaults.object(forKey: "showCursor") as? Bool ?? true
        }
        set {
            withMutation(keyPath: \.showCursor) {
                defaults.set(newValue, forKey: "showCursor")
            }
        }
    }

    var showWallpaper: Bool {
        get {
            access(keyPath: \.showWallpaper)
            return defaults.object(forKey: "showWallpaper") as? Bool ?? true
        }
        set {
            withMutation(keyPath: \.showWallpaper) {
                defaults.set(newValue, forKey: "showWallpaper")
            }
        }
    }

    var showMenuBar: Bool {
        get {
            access(keyPath: \.showMenuBar)
            return defaults.object(forKey: "showMenuBar") as? Bool ?? true
        }
        set {
            withMutation(keyPath: \.showMenuBar) {
                defaults.set(newValue, forKey: "showMenuBar")
            }
        }
    }

    var showDock: Bool {
        get {
            access(keyPath: \.showDock)
            return defaults.object(forKey: "showDock") as? Bool ?? true
        }
        set {
            withMutation(keyPath: \.showDock) {
                defaults.set(newValue, forKey: "showDock")
            }
        }
    }

    var showWindowShadows: Bool {
        get {
            access(keyPath: \.showWindowShadows)
            return defaults.object(forKey: "showWindowShadows") as? Bool ?? true
        }
        set {
            withMutation(keyPath: \.showWindowShadows) {
                defaults.set(newValue, forKey: "showWindowShadows")
            }
        }
    }

    var showClipwell: Bool {
        get {
            access(keyPath: \.showClipwell)
            return defaults.object(forKey: "showClipwell") as? Bool ?? false
        }
        set {
            withMutation(keyPath: \.showClipwell) {
                defaults.set(newValue, forKey: "showClipwell")
            }
        }
    }

    // MARK: - Output Settings

    /// The default output directory (Movies/Clipwell)
    var defaultOutputDirectory: URL {
        URL.homeDirectory.appending(path: "Movies/Clipwell")
    }

    /// Security-scoped bookmark data for the custom output directory
    private var customOutputDirectoryBookmark: Data? {
        get {
            access(keyPath: \.customOutputDirectoryBookmark)
            return defaults.data(forKey: "customOutputDirectoryBookmark")
        }
        set {
            withMutation(keyPath: \.customOutputDirectoryBookmark) {
                defaults.set(newValue, forKey: "customOutputDirectoryBookmark")
            }
        }
    }

    /// Whether a custom output directory has been set
    var hasCustomOutputDirectory: Bool {
        customOutputDirectoryBookmark != nil
    }

    /// The current output directory, using custom path if set
    var outputDirectory: URL {
        guard let bookmarkData = customOutputDirectoryBookmark else {
            return defaultOutputDirectory
        }

        do {
            var isStale = false
            let url = try URL(
                resolvingBookmarkData: bookmarkData,
                options: .withSecurityScope,
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            )

            if isStale {
                // Bookmark is stale, try to recreate it
                if url.startAccessingSecurityScopedResource() {
                    defer { url.stopAccessingSecurityScopedResource() }
                    if let newBookmark = try? url.bookmarkData(
                        options: .withSecurityScope,
                        includingResourceValuesForKeys: nil,
                        relativeTo: nil
                    ) {
                        customOutputDirectoryBookmark = newBookmark
                    }
                }
            }

            return url
        } catch {
            // If bookmark resolution fails, fall back to default
            return defaultOutputDirectory
        }
    }

    /// Sets a custom output directory from a user-selected URL
    /// - Parameter url: The URL selected by the user via NSOpenPanel
    func setCustomOutputDirectory(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }

        do {
            let bookmarkData = try url.bookmarkData(
                options: .withSecurityScope,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
            customOutputDirectoryBookmark = bookmarkData
        } catch {
            // Failed to create bookmark, ignore
        }
    }

    /// Resets to the default output directory
    func resetOutputDirectory() {
        customOutputDirectoryBookmark = nil
    }

    /// Starts accessing the security-scoped output directory resource
    /// Call this before writing files to a custom output directory
    /// - Returns: Whether access was successfully started (always true for default directory)
    func startAccessingOutputDirectory() -> Bool {
        guard customOutputDirectoryBookmark != nil else {
            return true // Default directory doesn't need security scope
        }
        return outputDirectory.startAccessingSecurityScopedResource()
    }

    /// Stops accessing the security-scoped output directory resource
    func stopAccessingOutputDirectory() {
        guard customOutputDirectoryBookmark != nil else {
            return // Default directory doesn't need security scope
        }
        outputDirectory.stopAccessingSecurityScopedResource()
    }

    // MARK: - Private Storage

    private var frameRateRaw: Int {
        get {
            access(keyPath: \.frameRateRaw)
            guard defaults.object(forKey: "frameRate") != nil else {
                return FrameRate.fps60.rawValue
            }
            return defaults.integer(forKey: "frameRate")
        }
        set {
            withMutation(keyPath: \.frameRateRaw) {
                defaults.set(newValue, forKey: "frameRate")
            }
        }
    }

    private var videoQualityRaw: String {
        get {
            access(keyPath: \.videoQualityRaw)
            return defaults.string(forKey: "videoQuality") ?? VideoQuality.medium.rawValue
        }
        set {
            withMutation(keyPath: \.videoQualityRaw) {
                defaults.set(newValue, forKey: "videoQuality")
            }
        }
    }

    private var videoCodecRaw: String {
        get {
            access(keyPath: \.videoCodecRaw)
            return defaults.string(forKey: "videoCodec") ?? VideoCodec.hevc.rawValue
        }
        set {
            withMutation(keyPath: \.videoCodecRaw) {
                defaults.set(newValue, forKey: "videoCodec")
            }
        }
    }

    private var containerFormatRaw: String {
        get {
            access(keyPath: \.containerFormatRaw)
            return defaults.string(forKey: "containerFormat") ?? ContainerFormat.mov.rawValue
        }
        set {
            withMutation(keyPath: \.containerFormatRaw) {
                defaults.set(newValue, forKey: "containerFormat")
            }
        }
    }

    private var audioCodecRaw: String {
        get {
            access(keyPath: \.audioCodecRaw)
            return defaults.string(forKey: "audioCodec") ?? AudioCodec.aac.rawValue
        }
        set {
            withMutation(keyPath: \.audioCodecRaw) {
                defaults.set(newValue, forKey: "audioCodec")
            }
        }
    }

    // MARK: - Helper Methods

    /// Generates a filename based on the current timestamp
    func generateFilename() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH.mm.ss"
        let timestamp = formatter.string(from: Date())
        return "Clipwell_\(timestamp).\(containerFormat.fileExtension)"
    }

    /// Returns the full output URL for a new recording
    func generateOutputURL() -> URL {
        outputDirectory.appending(path: generateFilename())
    }
}
