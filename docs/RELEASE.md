# Clipwell Release Process

Clipwell ships signed and notarized DMGs through [GitHub Releases](https://github.com/lioneltchami/clipwell/releases). Each stable release also publishes `appcast.xml`, which Sparkle uses for in-app updates.

## Versioning

Use semantic versioning: `vMAJOR.MINOR.PATCH`. The first Clipwell release is `v1.0.0`.

- Increment `PATCH` for compatible bug fixes.
- Increment `MINOR` for compatible features.
- Increment `MAJOR` for incompatible user-facing, update, or automation changes.
- Use GitHub prereleases for preview builds, such as `v1.1.0-beta.1`.

## Stable Release Checklist

1. Confirm `swiftlint lint` has no errors or warnings, the full test suite passes, and the Release build succeeds.
2. Confirm the documentation, website, app icon, version notes, and migration notes are accurate.
3. Verify these repository Actions secrets exist: `APPLE_CERTIFICATE_BASE64`, `APPLE_CERTIFICATE_PASSWORD`, `APPLE_TEAM_ID`, `APPLE_ID`, `APPLE_ID_PASSWORD`, `SPARKLE_PUBLIC_EDDSA_KEY`, and `SPARKLE_PRIVATE_EDDSA_KEY`.
4. Create a **draft GitHub Release** from the intended `main` commit with a new tag such as `v1.0.1`. Write clear release notes.
5. Publish the release. The `Build and Release` workflow then archives the app, signs it with Developer ID, notarizes and staples it, creates a DMG, signs the DMG for Sparkle, generates `appcast.xml`, and uploads both files to that release.
6. Confirm the workflow passes, the release contains `Clipwell-[version]-arm64.dmg` and `appcast.xml`, and both direct public URLs return HTTP 200.
7. Install the DMG on a clean macOS user account and validate first launch, permissions, update detection, and update installation.

## Releasing an Existing Draft or Published Release

The stable workflow supports manual recovery through **Actions → Build and Release → Run workflow**. Enter the version without the `v` prefix, for example `1.0.0`. The existing matching GitHub Release tag must already exist. The workflow rebuilds, notarizes, regenerates the appcast, and replaces that release’s DMG and `appcast.xml` assets.

Use this path only to repair release automation or rebuild the same source intentionally. For a product change, create a new semantic version and GitHub Release instead.

## Pre-releases

Creating a GitHub prerelease triggers `Build Pre-release`, which builds and uploads a signed DMG to that prerelease. Pre-releases are not part of the stable Sparkle feed. Do not treat a prerelease artifact as a notarized stable release without separately verifying its intended distribution policy.

## Release Ownership

GitHub Releases are Clipwell’s authoritative distribution channel. The website’s Download links target the latest GitHub Release. If an official Homebrew formula is introduced later, document its repository, tap ownership, and release procedure here before advertising it.
