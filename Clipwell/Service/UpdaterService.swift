//
//  UpdaterService.swift
//  Clipwell
//
//  Created by Joshua Sattler on 08.02.26.
//

import Foundation
import Sparkle

/// Wraps Sparkle's updater controller for use in SwiftUI
///
/// This service owns the `SPUStandardUpdaterController` and exposes
/// observable state for whether the user can check for updates, and
/// a binding to the automatic-check preference managed by Sparkle.
@MainActor
@Observable
final class UpdaterService {

    // MARK: - Properties

    /// Whether the updater is currently able to check for updates
    private(set) var canCheckForUpdates = false

    /// The underlying Sparkle updater controller
    private let controller: SPUStandardUpdaterController

    /// KVO observation for `canCheckForUpdates`
    private var canCheckObservation: NSKeyValueObservation?

    /// Convenience accessor for the updater
    var updater: SPUUpdater {
        controller.updater
    }

    /// Whether Sparkle should automatically check for updates.
    /// This directly reads/writes Sparkle's own user-defaults-backed property.
    var automaticallyChecksForUpdates: Bool {
        get { updater.automaticallyChecksForUpdates }
        set { updater.automaticallyChecksForUpdates = newValue }
    }

    // MARK: - Initialization

    /// Validates Sparkle's base64-encoded 32-byte Ed25519 public key.
    static func isValidPublicKey(_ publicKey: String?) -> Bool {
        guard let publicKey else { return false }
        let trimmedKey = publicKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedKey != "SPARKLE_PUBLIC_KEY",
              let keyData = Data(base64Encoded: trimmedKey) else {
            return false
        }
        return keyData.count == 32
    }

    init() {
        let publicKey = Bundle.main.infoDictionary?["SUPublicEDKey"] as? String
        let hasValidKey = Self.isValidPublicKey(publicKey)

        controller = SPUStandardUpdaterController(
            startingUpdater: hasValidKey,
            updaterDelegate: nil,
            userDriverDelegate: nil
        )

        guard hasValidKey else { return }

        // Observe Sparkle's canCheckForUpdates via KVO
        canCheckObservation = updater.observe(
            \.canCheckForUpdates,
            options: [.initial, .new]
        ) { [weak self] updater, _ in
            MainActor.assumeIsolated {
                self?.canCheckForUpdates = updater.canCheckForUpdates
            }
        }
    }

    // MARK: - Actions

    /// Triggers a user-initiated check for updates
    func checkForUpdates() {
        updater.checkForUpdates()
    }
}
