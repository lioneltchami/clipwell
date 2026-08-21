# Clipwell

**Clipwell** is a native, menu-bar screen recorder for macOS. It captures displays, windows, or selected areas with system audio, microphone audio, annotations, camera overlays, trimming, and GIF export. Recordings stay on your Mac: Clipwell has no account, analytics service, watermark, or cloud upload requirement.

## Download

Download the latest signed release from [GitHub Releases](https://github.com/lioneltchami/clipwell/releases/latest). Clipwell requires **macOS 15.2 Sequoia or later** and currently ships as an Apple-silicon DMG.

On first use, grant **Screen Recording** permission in System Settings. Enable **Microphone** permission only when you want microphone audio. If macOS blocks an app after moving it, open it from `/Applications` after completing the standard installation flow.

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

The website lives in [`website/`](./website). Run it locally with `pnpm install && pnpm dev`, or create the production site with `pnpm build`.

## Updates and Releases

Clipwell releases are signed, notarized, and published through [GitHub Releases](https://github.com/lioneltchami/clipwell/releases). Sparkle reads the release `appcast.xml` to offer in-app updates. See [the release guide](./docs/RELEASE.md) for the required repository secrets, release process, recovery workflow, and verification checks.

## Documentation

Technical references, architecture notes, feature specifications, manual smoke tests, and release guidance are indexed in [docs/README.md](./docs/README.md).

## Privacy

Clipwell records only the content and audio sources that you select. Output is written to the configured local folder. The app does not require an account and does not upload recordings or telemetry.

## License and Attribution

Clipwell is distributed under the [MIT License](./LICENSE). It is a renamed and extended derivative of BetterCapture; the original copyright notice and license terms are preserved in [`LICENSE`](./LICENSE). See [NOTICE.md](./NOTICE.md) for attribution and migration context.

## Website and Source

The public site is [lioneltchami.github.io/clipwell](https://lioneltchami.github.io/clipwell/). Source and issue tracking are at [lioneltchami/clipwell](https://github.com/lioneltchami/clipwell).
