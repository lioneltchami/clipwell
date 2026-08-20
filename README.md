# Clipwell

Native macOS screen recorder — menu bar, local files, MIT license.

**Brand note:** App binary may still show CaptureForge / BetterCapture in places; product name going forward is **Clipwell**.

## Features

- ScreenCaptureKit capture (display / window / area)
- System audio + microphone
- Camera overlay layouts, pause/resume
- Click / keystroke overlays + annotation drawing
- Trim + GIF export
- No cloud account, no watermark

## Requirements

macOS 15.2 Sequoia or later.

## Website

Marketing site lives in [`website/`](./website) (Astro + Svelte + Tailwind).

```bash
cd website && pnpm install && pnpm dev
```

## App

Open `BetterCapture.xcodeproj` in Xcode and run the CaptureForge scheme (rename to Clipwell pending).

## License

MIT — see [LICENSE](./LICENSE).
