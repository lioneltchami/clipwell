# Clipwell

**Clipwell** is a native menu-bar screen recorder for macOS. It captures displays, windows, or selected areas with system audio, microphone audio, annotations, camera overlays, trimming, and GIF export. Recordings stay on your Mac: Clipwell has no account, analytics service, watermark, or cloud-upload requirement.

## Distribution Status

Clipwell is a public, open-source project. The current public release is free to download and distributed under the MIT license; no paid plan, checkout, or commercial entitlement is offered today. The application source, build pipeline, and release artifacts live at `https://github.com/lioneltchami/clipwell`.

The historic v1.0.0 and v1.0.1 public releases remain MIT-era baselines. Any distributed material containing substantial MIT-covered code must retain [`LICENSE`](./LICENSE) and [`NOTICE.md`](./NOTICE.md).

## v1.1.0

v1.1.0 is the current free public release. There is no separate changelog file in this repository — the GitHub Release body at `https://github.com/lioneltchami/clipwell/releases/tag/v1.1.0` is the source of truth for what shipped.

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

v1.1.0+ uses a public Sparkle appcast hosted at the GitHub Release (`/releases/latest/download/appcast.xml`) so users get auto-updates. Each release is signed, notarized, and stapled before the DMG is published to the GitHub Release page. See [the release guide](./docs/RELEASE.md).

## Commercial Staging (Deferred)

The Stripe Product, $19 one-time Price, fulfillment Worker, private D1 database, private R2 bucket, and Stripe webhook exist in the build pipeline but are not active for the free v1.1.0 release. The original paid entitlement draft was **Recording Presets** (named reusable capture setups for video, audio, camera, countdown, overlay, and content-filter settings), with `support@getclipwell.com` as the buyer support contact and a 30-day refund window. These are stage-only artifacts and do not represent a live commercial offer. See the [commercialization policy](./docs/COMMERCIALIZATION.md) and [Stripe fulfillment guide](./docs/STRIPE_CHECKOUT.md) for the deferred plan.

## Documentation

Technical references, architecture notes, feature specifications, manual smoke tests, release guidance, and commercialization policy are indexed in [docs/README.md](./docs/README.md).

## Privacy

Clipwell records only the content and audio sources that the user selects. Output is written to the configured local folder. The app does not require an account and does not upload recordings or telemetry.

## License and Attribution

Clipwell contains MIT-covered material and remains subject to the [MIT License](./LICENSE) for that material. It is a renamed and extended derivative of BetterCapture; the original copyright notice and license terms are preserved in [`LICENSE`](./LICENSE). See [NOTICE.md](./NOTICE.md) for attribution and migration context.

## Project Locations

The application source, build pipeline, release artifacts, and documentation live at `https://github.com/lioneltchami/clipwell`. The public marketing site is deployed to `https://lioneltchami.github.io/clipwell`.
