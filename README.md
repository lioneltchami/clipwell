# Clipwell

Native macOS screen recorder — menu bar, local files, MIT license.

**Clipwell** is the canonical product identity for the app, releases, documentation, and website.

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

The public site is [lioneltchami.github.io/clipwell](https://lioneltchami.github.io/clipwell/). Its source lives in [`website/`](./website) (Astro + Svelte + Tailwind), and the source repository is [lioneltchami/clipwell](https://github.com/lioneltchami/clipwell).

```bash
cd website && pnpm install && pnpm dev
```

## App

Open `Clipwell.xcodeproj` in Xcode and run the `Clipwell` scheme.

## License

MIT — see [LICENSE](./LICENSE).
