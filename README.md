# Clipwell

**Clipwell** is a native menu-bar screen recorder for macOS. It captures displays, windows, or selected areas with system audio, microphone audio, annotations, camera overlays, trimming, and GIF export. Recordings stay on your Mac: Clipwell has no account, analytics service, watermark, or cloud-upload requirement.

## Distribution Status

The Clipwell source repository and future build artifacts are private. The public product site is deployed separately from the private source tree. Future paid distribution, if launched, will use a verified buyer portal and private artifact storage rather than anonymous GitHub release URLs.

This privacy change does not retract historic MIT rights. The public v1.0.0 and v1.0.1 releases were MIT-era releases, and any distributed material containing substantial MIT-covered code must retain [`LICENSE`](./LICENSE) and [`NOTICE.md`](./NOTICE.md).

## Features

- ScreenCaptureKit display, window, and area capture.
- System audio and microphone recording.
- Native or logical output resolution, HDR where the selected codec supports it, and ProRes, HEVC, or H.264 output.
- Click highlights, keystroke overlays, and live annotation strokes composited into recordings.
- Built-in camera overlay layouts, pause/resume, post-recording trim, and GIF export.
- Local files, no account, no watermark, and no cloud dependency.

## Build from Source

Open `Clipwell.xcodeproj` in Xcode and run the **Clipwell** scheme. The project targets macOS 15.2+, uses Swift 6 concurrency, and has no application runtime dependencies beyond Apple frameworks and Sparkle for updates.

```bash
xcodebuild test \
  -project Clipwell.xcodeproj \
  -scheme Clipwell \
  -destination "platform=macOS" \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_REQUIRED=NO
```

## Updates and Releases

Future commercial builds are signed, notarized, and retained in private build-team releases. Buyer delivery is handled by the Clipwell fulfillment service, which verifies payment events, creates entitlements, and streams a DMG from private artifact storage through short-lived download grants.

Sparkle uses a public **informational** appcast at `https://clipwell-fulfillment.apoti.workers.dev/appcast.xml`. It may notify a buyer that an update exists, but it does not expose a public DMG enclosure. Buyer access and downloads remain in the portal until an authenticated in-app update design is separately implemented and security-reviewed. See [the release guide](./docs/RELEASE.md).

## Commercial Status

The Stripe Product, $19 one-time Price, fulfillment Worker, private D1 database, private R2 bucket, and Stripe webhook exist, but the live Payment Link is intentionally deactivated. The public site must not advertise a paid purchase until the seller identity, terms, tax/privacy position, original paid entitlement, transactional email, commercial release artifact, and end-to-end acceptance tests are complete.

The approved buyer support contact is `support@getclipwell.com`, and the intended refund window is 30 days. These facts do not substitute for final sales terms. See the [commercialization policy](./docs/COMMERCIALIZATION.md) and [Stripe fulfillment guide](./docs/STRIPE_CHECKOUT.md).

## Documentation

Technical references, architecture notes, feature specifications, manual smoke tests, release guidance, and commercialization policy are indexed in [docs/README.md](./docs/README.md).

## Privacy

Clipwell records only the content and audio sources that the user selects. Output is written to the configured local folder. The app does not require an account and does not upload recordings or telemetry. Any future buyer portal collects only the data required for purchase fulfilment and support as described in final published privacy terms.

## License and Attribution

Clipwell contains MIT-covered material and remains subject to the [MIT License](./LICENSE) for that material. It is a renamed and extended derivative of BetterCapture; the original copyright notice and license terms are preserved in [`LICENSE`](./LICENSE). See [NOTICE.md](./NOTICE.md) for attribution and migration context.

## Project Locations

The public marketing deployment is currently hosted independently at `https://clipwell-site-1cn.pages.dev`. The application source, build pipeline, and support documentation reside in the private `lioneltchami/clipwell` repository.
