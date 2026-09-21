# Clipwell Website

The Clipwell website is an Astro 5, Svelte 5, and Tailwind 4 site. Deployed to GitHub Pages at [lioneltchami.github.io/clipwell](https://lioneltchami.github.io/clipwell/).

## Pages

- `/` — landing page (hero, product demo, workbench, spec, release download, trust, pricing preview, FAQ, dive-deeper, CTA)
- `/features/` — capture matrix, codec & container guide, keyboard shortcuts, URL-scheme automation
- `/install/` — DMG, Homebrew, URL-scheme install methods, system requirements, artifact verification
- `/changelog/` — release history and semantic-versioning cadence
- `/open-source/` — MIT license, attribution to BetterCapture by Joshua Sattler, contribution channels, commercial framework
- `/use-cases/` — six common workflows, each with a recommended codec and output
- `/privacy-policy/` — privacy policy
- `/404` — custom not-found page

All subpages share the same brand tokens (`tokens.css`), BaseLayout, Navbar, and Footer.

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

## Project structure

```text
src/
  components/    Svelte 5 components, one per surface
  layouts/       BaseLayout.astro — SEO, OG, structured data, skip link
  pages/         Astro file-based routing
  styles/        global.css — Tailwind entry point
public/          Product screenshots, OG image, icons, favicon, robots.txt, manifest
tokens.css       Brand tokens — palette, typography, spacing, motion
tailwind.config.mjs
astro.config.mjs
```

## Adding a new page

1. Create `src/pages/<name>.astro` and import `BaseLayout`.
2. Use `PageHeader.svelte` for the eyebrow / title / lede pattern.
3. Use existing brand tokens. Do not hard-code colors, padding, or font sizes.
4. Add a structured-data JSON-LD object for `WebPage` or a more specific schema type.
5. Add the page to `Navbar.svelte`'s `commands` palette list.
6. Add the page to `Footer.svelte`'s `groups` list.
7. If the page belongs in the dive-deeper rail on the home page, add it to `DiveDeeper.svelte`.

## Brand

Clipwell uses a deep indigo, violet, and coral palette with high-contrast light typography on dark paper. The macOS app icon is maintained separately in `../Clipwell/Assets.xcassets/Clipwell.appiconset`.

## Deploy

### GitHub Pages (current production)

`base: '/clipwell/'` in `astro.config.mjs`. The GitHub Pages workflow at `.github/workflows/` publishes `dist/` to the `gh-pages` branch. Canonical URL: `https://lioneltchami.github.io/clipwell/`.

### Cloudflare Pages (experimental)

`wrangler.toml` is configured for the `clipwell` project. Build command: `pnpm build`. Output directory: `dist`. To enable Cloudflare deploys alongside GitHub Pages, set up a Cloudflare account with the Pages project and a custom domain that points to `lioneltchami.github.io/clipwell`. **Be aware that moving the canonical URL changes the address documented in the migration guide** — only switch once a custom domain is in place.