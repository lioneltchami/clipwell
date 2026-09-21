# Clipwell Release Process

The current public release of Clipwell is a free, MIT-licensed artifact published to the public `lioneltchami/clipwell` GitHub repository. Each release is signed, notarized, stapled, Sparkle-signed, and uploaded to the GitHub Release page; the Sparkle appcast is hosted at the same release so users receive auto-updates.

The historic v1.0.0 and v1.0.1 public releases remain MIT-era baselines. Do not describe them as exclusive commercial artifacts.

## Versioning

Use semantic versioning: `vMAJOR.MINOR.PATCH`.

- Increment `PATCH` for compatible bug fixes.
- Increment `MINOR` for compatible features.
- Increment `MAJOR` for incompatible user-facing, update, or automation changes.
- Use prerelease tags (for example `v1.2.0-beta.1`) for internal preview builds.

## Free Release Checklist

1. Confirm `swiftlint lint` has no errors or warnings, the full test suite passes, and the Release build succeeds.
2. Confirm the source tree ships `LICENSE` and `NOTICE.md` so MIT rights and upstream attribution remain preserved.
3. Verify the Apple signing and notarization secrets used by the existing release workflow.
4. Build, sign, notarize, staple, and Sparkle-sign the DMG. Upload it to the public GitHub Release for the tag.
5. Compute and record the DMG SHA-256 checksum in the GitHub Release body.
6. Generate the Sparkle appcast entry (`scripts/update_appcast.py`) using `RELEASE_URL` and `RELEASE_NOTES`, and upload `appcast.xml` as the GitHub Release asset `appcast.xml`.
7. Confirm `https://github.com/lioneltchami/clipwell/releases/latest/download/appcast.xml` resolves and exposes a public DMG enclosure for the new version.

## Future Commercial Staging

> **Not the v1.1.0 delivery path.** This section is preserved so the staged-commerce work is not lost, but v1.1.0 ships free and public. Revisit this checklist only when a genuine commercial offer (original paid value, buyer portal, signed commercial DMG, fulfillment infrastructure) is actually being prepared.

### Commercial Release Checklist

1. Confirm `swiftlint lint` has no errors or warnings, the full test suite passes, and the Release build succeeds.
2. Confirm the commercial release contains the original **Recording Presets** feature beyond the historic MIT-covered public baseline. Preserve `LICENSE` and `NOTICE.md` in every distribution that includes covered material.
3. Confirm the documentation, buyer-facing product copy, support scope, refund policy, and seller disclosures are accurate.
4. Verify the Apple signing and notarization secrets used by the existing private release workflow.
5. Build, sign, notarize, staple, and Sparkle-sign the DMG through the private release workflow. A private GitHub Release may retain the build-team artifact, but it is **not** the customer delivery channel.
6. Compute and record the DMG SHA-256 checksum.
7. Upload the DMG to the private `clipwell-commercial-releases` R2 bucket under a versioned key, such as `commercial/1.1.0/Clipwell-1.1.0.dmg`. Do not enable a public bucket URL.
8. Insert or activate the corresponding `releases` record in the `clipwell-fulfillment` D1 database. Record the commercial channel, version, object key, SHA-256 checksum, and attachment-safe filename.
9. Confirm `https://clipwell-fulfillment.apoti.workers.dev/appcast.xml` provides an informational update notice only. It must not expose a public DMG enclosure.
10. Test buyer portal download, re-download, refund revocation, Gatekeeper/notarization, code signing, checksum, Recording Presets save/apply behavior, and the Sparkle informational update path.
11. Only after the checkout, webhook, release record, private object, transactional email, and buyer-flow tests pass may the live Payment Link be reactivated.

### Sparkle Policy

New free builds use the public GitHub Release appcast (`https://github.com/lioneltchami/clipwell/releases/latest/download/appcast.xml`). The appcast exposes the public DMG enclosure so Sparkle can deliver auto-updates to free users.

For future commercial builds, the Clipwell fulfillment appcast at `https://clipwell-fulfillment.apoti.workers.dev/appcast.xml` sends buyers to the secure portal when a commercial update exists. It does not contain a public DMG enclosure.

An authenticated in-app automatic-update channel requires device registration, buyer tokens, rotation, revocation policy, and a separate security review. Until then, keep the free Sparkle flow pointing at the public GitHub Release appcast and use the buyer portal for commercial update downloads.

## Release Ownership

| Surface | Purpose | Access |
|---|---|---|
| Public `lioneltchami/clipwell` repository | Source, CI, signing, and release traceability | Public |
| Public GitHub Release | Customer delivery channel for free releases (DMG + Sparkle appcast asset); build-team artifact for commercial staging | Public |
| Public Sparkle appcast (`/releases/latest/download/appcast.xml`) | Auto-update feed for free users | Public |
| Private GitHub Release | Build-team artifact for commercial staging | Build team only |
| Private R2 bucket | Versioned commercial DMGs | Fulfillment Worker only |
| Clipwell fulfillment Worker | Webhook verification, entitlements, portal, downloads, and informational appcast | Public routes with buyer authorization where required |
| Public marketing site | Product information | Public |

No release should claim to revoke or replace rights already granted for MIT-covered material. Consult qualified counsel before final terms of sale, seller disclosures, consumer rights, and tax treatment are published.