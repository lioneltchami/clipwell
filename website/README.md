# Clipwell Website

The Clipwell website is an Astro, Svelte, and Tailwind landing page deployed to [lioneltchami.github.io/clipwell](https://lioneltchami.github.io/clipwell/).

## Develop

```bash
pnpm install
pnpm dev
```

## Validate and Build

```bash
pnpm build
pnpm preview
```

Run `pnpm build` before committing website changes. The GitHub Pages workflow builds this directory from `main` and publishes the generated site.

## Product Assets

Keep product images in `public/` and use authentic Clipwell screens wherever possible. Do not reuse the hero recording image as a workflow-step image, and update screenshots whenever visible product branding changes. The website uses `screenshot-basic.png` for the hero and `screenshot-content-filter-clipwell.png`, `screenshot-frame-rate.png`, and a dedicated recording-aids visual for the Workbench sequence.

## Brand

Clipwell uses a deep indigo, violet, and coral palette with high-contrast light typography. The macOS app icon is maintained separately in `../Clipwell/Assets.xcassets/Clipwell.appiconset`.
