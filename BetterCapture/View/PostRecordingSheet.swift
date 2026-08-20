//
//  PostRecordingSheet.swift
//  BetterCapture
//

import AVFoundation
import SwiftUI

/// Actions shown after a recording finishes successfully.
struct PostRecordingSheet: View {
    let recordingURL: URL
    let outputDirectory: URL
    let onDismiss: () -> Void

    @State private var duration: TimeInterval = 0
    @State private var trimStart: TimeInterval = 0
    @State private var trimEnd: TimeInterval = 0
    @State private var isWorking = false
    @State private var statusMessage: String?
    @State private var lastExportedURL: URL?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recording saved")
                .font(.headline)

            Text(recordingURL.lastPathComponent)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            if duration > 0 {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Trim")
                        .font(.subheadline)
                        .bold()

                    HStack {
                        Text("Start")
                        Slider(value: $trimStart, in: 0...max(trimEnd - 0.1, 0))
                        Text(trimStart, format: .number.precision(.fractionLength(1)))
                            .monospacedDigit()
                            .frame(width: 36, alignment: .trailing)
                    }

                    HStack {
                        Text("End")
                        Slider(value: $trimEnd, in: min(trimStart + 0.1, duration)...duration)
                        Text(trimEnd, format: .number.precision(.fractionLength(1)))
                            .monospacedDigit()
                            .frame(width: 36, alignment: .trailing)
                    }
                }
            }

            if let statusMessage {
                Text(statusMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Button("Reveal in Finder") {
                    NSWorkspace.shared.activateFileViewerSelecting([recordingURL])
                }

                Button("Copy file") {
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.writeObjects([recordingURL as NSURL])
                    statusMessage = "Copied to clipboard."
                }

                Spacer()

                Button("Export GIF") {
                    Task { await exportGIF() }
                }
                .disabled(isWorking || duration == 0)

                Button("Save trim") {
                    Task { await saveTrim() }
                }
                .disabled(isWorking || duration == 0 || trimEnd <= trimStart)
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .frame(width: 420)
        .task {
            await loadDuration()
        }
    }

    private func loadDuration() async {
        let asset = AVURLAsset(url: recordingURL)
        if let loaded = try? await asset.load(.duration).seconds, loaded.isFinite {
            duration = loaded
            trimEnd = loaded
        }
    }

    private func saveTrim() async {
        isWorking = true
        defer { isWorking = false }

        do {
            let url = try await RecordingExportService.trim(
                source: recordingURL,
                start: CMTime(seconds: trimStart, preferredTimescale: 600),
                end: CMTime(seconds: trimEnd, preferredTimescale: 600),
                outputDirectory: outputDirectory
            )
            lastExportedURL = url
            statusMessage = "Saved \(url.lastPathComponent)"
            NSWorkspace.shared.activateFileViewerSelecting([url])
        } catch {
            statusMessage = error.localizedDescription
        }
    }

    private func exportGIF() async {
        isWorking = true
        defer { isWorking = false }

        do {
            let url = try await RecordingExportService.exportGIF(
                source: recordingURL,
                outputDirectory: outputDirectory
            )
            lastExportedURL = url
            statusMessage = "Saved \(url.lastPathComponent)"
            NSWorkspace.shared.activateFileViewerSelecting([url])
        } catch {
            statusMessage = error.localizedDescription
        }
    }
}
