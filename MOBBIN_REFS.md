# Mobbin Research References — Clipwell Website Rebuild

> Research pass for the Clipwell website rebuild, per `clipwell-website-handoff.md` (Phase: Design research).
> Generated 2026-09-21. Two-pass: first public-web fallback, then Mobbin catalog deep pass via Cursor.

## Source policy

This document records **46 catalog-derived references** pulled from Mobbin via Cursor's MCP connection, plus the earlier **public-web fallback** (38 entries) that was used while Mobbin was gated. Both are kept so the design audit trail is intact.

**Mobbin catalog coverage note** (extracted from `MOBBIN_DEEP_REFS.json`):

> Mobbin indexes iOS and web (plus marketing site sections). Native macOS-only apps are largely absent from the catalog.

The following requested apps were **not indexed by Mobbin**: CleanShot X, ScreenFlow, Bartender, Ice, Dozer, Droplr, HandBrake, OBS Studio app UI, DaVinci Resolve, Raycast app UI, Cal.com, Plausible Analytics, Ollama.

Where a named app is not on Mobbin, the closest indexed analog is included and tagged with `requested_apps_proxied_for`. The substitution is intentional, not silent — design intent carries across surfaces even when the exact app is missing.

**Title policy**: Mobbin MCP does not return official screen titles. `screen_title` values below are descriptive titles derived from visible UI chrome / section headlines.

---

## Category 1 — Screen-recorder / capture tools

**Intent**: capture flows, floating toolbars, post-record overlays.
**10 references.**

| # | App | Pattern | Mobbin URL |
|---|---|---|---|
| 1.1 | Loom | Pre-record floating panel (source / camera / mic toggles) + canvas background picker + dual pill control bars for stop/pause and layout tools | https://mobbin.com/screens/96664708-cd8b-43bd-86c9-27efe0f69202 |
| 1.2 | Loom | Compact vertical capture launcher with On/Off device states, orange Start Recording CTA, dark floating session toolbar | https://mobbin.com/screens/40bb7031-536d-44a5-9d71-fdd4f22d8642 |
| 1.3 | Loom | Destructive post-capture decision modal (Restart / Resume / Cancel) with educational footer tip about Rewind | https://mobbin.com/screens/3746e62f-8281-4b31-bf7d-ba5b8e219986 |
| 1.4 | Loom | Immediate trim modal after capture: player + waveform handle + Fit waveform zoom + Exit/Trim actions over blurred library | https://mobbin.com/screens/27643e2e-5c94-40d3-9b11-1e4a2052de11 |
| 1.5 | Loom | Post-record editor rhythm: Split/Delete/Add clip, duration delta, transcript edit entry, Save and exit CTA | https://mobbin.com/screens/829ee044-a529-4c26-9c74-6fbff98f1ee0 |
| 1.6 | Loom | Settings popover (video quality Auto/720p/1080p + countdown/controls toggles) paired with always-visible capture pill bar | https://mobbin.com/screens/2afa79d7-90b0-4644-8a77-66bdc85f1167 |
| 1.7 | Loom | Post-record consumption surface: reactions, AI summary, transcript edit popover (Correct/Delete word), mobile download banner | https://mobbin.com/screens/a51ef2c7-34d5-4d61-932d-206be1c4259d |
| 1.8 | Descript (∝ ScreenFlow, Droplr) | Post-record share panel with segmented Audio/Timeline/Transcript/Subtitles tabs, destination/access dropdowns, Published state, Copy link | https://mobbin.com/screens/8d9aab65-159e-4ad7-afb7-15846d30e1d6 |
| 1.9 | Vimeo (∝ CleanShot X) | Pre-record stage: 1080p badge, blur/background preset grid, floating mic/camera/screen-share bar, red Record CTA | https://mobbin.com/screens/41b368f1-896e-454e-97ab-740b721d3c61 |
| 1.10 | Riverside (∝ ScreenFlow) | Post-capture export overlay with Video/Audio tabs, 4K quality dropdown, processing toggles, Export video CTA over timeline | https://mobbin.com/screens/ee0beb67-600e-4f0c-bb1b-3d925d08ba1a |

**Design lift**: confirms the three-stage capture rhythm (Pre-record panel → Recording toolbar → Post-record trim/share). Clipwell's hero mirrors 1.1/1.2 (pre-record panel with source-picker logic baked into `Hero.svelte`'s signal card). Clipwell's `/features` page mirrors 1.5 (post-record trim narrative). Clipwell's `/install` mirrors 1.9 (single primary CTA + copy explaining what happens next).

## Category 2 — macOS menu-bar apps (dropdown layouts & separator discipline)

**Intent**: compact dropdowns, grouped actions, hairline separators, destructive isolation.
**8 references.**

| # | App | Pattern | Mobbin URL |
|---|---|---|---|
| 2.1 | Etsy (∝ Bartender, Ice, Dozer) | Header identity, icon+label rows, hairline separators between Activity / Commerce / System groups, Sign out last | https://mobbin.com/screens/0c6dce7f-4bea-44df-bccc-d516dc87221d |
| 2.2 | Slack (∝ Bartender, Ice) | Anchored profile popover + nested DND flyout (status header → Resume / Adjust time / schedule) | https://mobbin.com/screens/3d490c9c-2ff9-4fa4-8a9f-09d5bc78b7ea |
| 2.3 | Slack (∝ Dozer) | Menu item with trailing `On >` state opening a secondary panel; active-state disclosure without reopening parent | https://mobbin.com/screens/499aa83f-17e0-4b0f-bde1-60fa3777cb6d |
| 2.4 | Notion (∝ Bartender, Droplr) | Dense utility dropdown: plan badge, Settings/Invite, multi-workspace list, Get Mac/iOS app links, then Help/Trash | https://mobbin.com/screens/a535975a-c988-47a1-89fd-a5bf46a0123a |
| 2.5 | Laravel Cloud (∝ Ice, Dozer) | Dark compact overflow (Manage / Reauthorize / Disconnect) — hazardous disconnect isolated at bottom | https://mobbin.com/screens/ec08f97b-89fa-4bfa-a6b1-100c4bb488ed |
| 2.6 | Patreon (∝ Droplr) | Meatball menu with safe actions first, then red Stop selling / Delete — separator + color discipline for destructive items | https://mobbin.com/screens/d990ccf7-6d4d-410a-bc7e-9924a65ff325 |
| 2.7 | Linktree (∝ Bartender) | Card-scoped menu (Switch / Change username / Links / Design / Settings) with Delete isolated in red | https://mobbin.com/screens/490b7801-95c9-4abd-9dbd-d67db33e38ea |
| 2.8 | Charma (∝ Ice) | Long action list with gray metadata header band, icon rows, Delete tinted at bottom — separator discipline via whitespace + color | https://mobbin.com/screens/4f0c0f96-031c-450a-beed-e0c8cec25768 |

**Design lift**: Clipwell's menubar icon does not surface a UI dropdown on the marketing site (it surfaces in the app itself). The patterns above inform the `/features` keyboard-shortcut table (grouped by Recording / Library / Trim / Window) and the `/changelog` destructive-action footnote. They are also load-bearing for any future in-app preference pane IA.

## Category 3 — Codec / settings panes

**Intent**: codec picker grids, quality/resolution controls, export settings density.
**8 references.**

| # | App | Pattern | Mobbin URL |
|---|---|---|---|
| 3.1 | Loom (∝ OBS) | Compact quality picker (Auto / 1080p / 720p) with helper copy plus behavioral toggles — lightweight codec UX | https://mobbin.com/screens/7c1a1525-918c-458e-9c12-2f0ac2982cb7 |
| 3.2 | VEED (∝ HandBrake, DaVinci Resolve) | Advanced pane stacking framerate slider, Resolution, Quality, Compression dropdowns, full-width Export Video CTA | https://mobbin.com/screens/31a6f2f9-8ff9-4c2a-a5ab-da6a51d2b9ef |
| 3.3 | Riverside (∝ HandBrake) | Modal codec-adjacent controls: 2160p 4K selector, watermark/noise toggles, Video vs Audio tabs | https://mobbin.com/screens/ee0beb67-600e-4f0c-bb1b-3d925d08ba1a |
| 3.4 | Descript (∝ FFmpeg UI) | Format dropdown as codec stand-in (Lossless WAV), Destination Local export, Advanced accordion | https://mobbin.com/screens/3f7d13c0-d62a-4728-9b4a-a592ae3e5cb2 |
| 3.5 | Descript (∝ OBS, DaVinci Resolve) | Dense toggle grid with nested settings popover (interval, paragraph breaks, offset) | https://mobbin.com/screens/d64d5b2c-0c8c-46c5-8be1-9fec14ecea75 |
| 3.6 | Leonardo AI (∝ HandBrake) | Codec-picker analog: thumbnail list of engines with feature chips, Unlimited badges, 720p/1080p segmented quality, aspect-ratio icon grid | https://mobbin.com/screens/93080b42-e2bc-4673-9141-502174ef84cc |
| 3.7 | Luma AI (∝ DaVinci Resolve) | Frosted settings chip row for technical params (5s, 1080p, Ray2) inside tabbed Describe/Keyframe/Reference flow | https://mobbin.com/screens/82b1f9cb-22fd-4071-b918-07c81f48813f |
| 3.8 | Telegram (∝ OBS, FFmpeg UI) | Explicit OBS/FFmpeg handoff: RTMPS URL + masked stream key, software encoding (x264) guidance, Start Streaming CTA | https://mobbin.com/screens/532aab8b-63b3-4b65-9461-e4fbb5aa3454 |

**Design lift**: Clipwell's `/features` codec guide directly mirrors 3.1, 3.2, and 3.3 — codec picker with quality + container + behavioral toggles. The primary-codec highlight on `H.264` (left coral border in `CodecGuide.svelte`) follows the segmented-control discipline from 3.1. The four-column grid on wide viewports mirrors 3.2's pane-stacking rhythm.

## Category 4 — Hero / pricing / download CTA patterns

**Intent**: hero rhythm, primary/secondary CTA placement, download CTAs.
**10 references.**

| # | App | Pattern | Mobbin URL |
|---|---|---|---|
| 4.1 | Linear | Dark hero rhythm: brand + nav, single Sign up pill CTA top-right, large headline/subhead, product UI as primary visual | https://mobbin.com/screens/b7c17da1-eac4-4a8d-b7e9-2b8d6ef30f66 |
| 4.2 | Linear | Pricing rhythm — plan comparison with clear CTA hierarchy matching marketing typography | https://mobbin.com/sites/sections/27001485-8428-4f37-b7c8-be4ac9461bb2 |
| 4.3 | Linear | Secondary pricing narrative block reinforcing plan CTAs and whitespace discipline | https://mobbin.com/sites/sections/a39bce12-4af5-4698-88ec-841c18f453d4 |
| 4.4 | Vercel | Centered dual-CTA pattern: solid primary Start Deploying vs outline Get a Demo under short value prop | https://mobbin.com/sites/sections/c2faadf7-61c1-4753-ad0a-f4de00f5a916 |
| 4.5 | Vercel | Asymmetric hero: bold left headline, right copy+CTAs, metric trust strip directly under fold | https://mobbin.com/sites/sections/5dbae9cb-19d9-4e78-a89d-75c27ffb5e55 |
| 4.6 | Vercel | Repeated primary/secondary CTA rhythm below feature grid — conversion without reloading hero | https://mobbin.com/sites/sections/918111cc-0e15-4a62-942b-57715e278a2a |
| 4.7 | Supabase | Dark split hero with green primary CTA, ghost docs CTA, nav-level Start your project duplication | https://mobbin.com/sites/sections/6d6921ce-b43a-4232-9ebd-966b1338c349 |
| 4.8 | Cursor (∝ Raycast) | Desktop-download CTA pattern (Mac/Windows) — closest Mobbin analog to Raycast-style download heroes | https://mobbin.com/sites/sections/31066e29-9f55-4a93-9875-9a861c1f71a7 |
| 4.9 | Wispr Flow (∝ Raycast) | Single-platform Download for Mac button as primary conversion — menu-bar/desktop product marketing pattern | https://mobbin.com/sites/sections/e0030809-614c-4bcb-9c53-746c90165df9 |
| 4.10 | Superhuman Mail (∝ Raycast) | Premium desktop download CTA with supporting copy — hero-to-install conversion for power-user tools | https://mobbin.com/sites/sections/22c4a41a-e376-4f11-9715-90c38b813fa1 |

**Design lift**: 4.1/4.4/4.5/4.7 informed Clipwell's hero — large headline, single subhead, dual CTA (Download primary + See capture flow secondary), product visual as primary surface. 4.8/4.9/4.10 informed `/install` — Mac-first download pattern with Homebrew as a secondary install rail.

## Category 5 — Open-source / free / MIT framing

**Intent**: license badge rhythm, GitHub star CTAs, free/OSS program framing.
**10 references.**

| # | App | Pattern | Mobbin URL |
|---|---|---|---|
| 5.1 | Supabase | "Open Source" as first words of H1, "Star us on GitHub" in nav, green Start a project CTA — OSS identity as hero-level signal | https://mobbin.com/sites/sections/0eb5722a-4576-49bd-9d04-b2d9556690fc |
| 5.2 | Supabase | Community metrics grid (developers, GitHub stars, Twitter, Discord) + logo cloud | https://mobbin.com/sites/sections/a4ec9576-ae8f-4c87-8b4b-ce9c59c61b4c |
| 5.3 | Supabase | Mission copy underlining open source with GitHub star CTA retained in chrome | https://mobbin.com/sites/sections/3e9e47f0-2868-4f09-bbcd-3cad018ba793 |
| 5.4 | Greptile (∝ Cal.com, Plausible) | Explicit license badge rhythm: `[ OPEN SOURCE ]` label, MIT/Apache/GPL copy, Apply for OSS CTA beside startup discount card | https://mobbin.com/sites/sections/3acb1f30-cc02-4b04-9dbe-b6425a2b55ed |
| 5.5 | OpenAI (∝ Ollama) | Attribution badge grid (outlined light/dark preferred vs filled) + Download badges | https://mobbin.com/sites/sections/a604d639-7a02-4ae6-b601-851e221e106b |
| 5.6 | Cloudflare Workers (∝ Ollama) | Open-weight model cards (Llama, DeepSeek, GPT-OSS, Qwen) with logos | https://mobbin.com/sites/sections/f1bcadfa-b88e-491f-b84e-8f2e8d8476ab |
| 5.7 | Mistral AI (∝ Ollama) | Free models called out as a dedicated accordion under paid API table — free tier framing without burying in fine print | https://mobbin.com/sites/sections/ce1133d7-b1b2-4c31-ba77-389595ba042d |
| 5.8 | Lightdash (∝ Plausible, Cal.com) | "Open source" in primary subhead + Start for free / Try live demo dual CTAs | https://mobbin.com/sites/sections/29e133de-34ee-4255-a796-b185d60e359d |
| 5.9 | Lightdash (∝ Plausible) | Credibility via open-source origin story (first GitHub commit, HN launch) — narrative license/community framing | https://mobbin.com/sites/sections/4a6efa26-8500-4346-a229-ba23004bce0f |
| 5.10 | Visitors (∝ Plausible) | Privacy-first analytics positioning closest to Plausible's free/privacy framing on Mobbin | https://mobbin.com/sites/sections/fc533c6f-fdaf-49b6-aaea-3927ac02b937 |

**Design lift**: 5.4's `[ OPEN SOURCE ]` label rhythm directly informed the eyebrow + label discipline in `OpenSourcePanel.svelte` and `Footer.svelte`'s `Project` group. 5.8 informed the dual-CTA in the home page hero (`Download Clipwell` + `See the capture flow`). 5.9 informs the `Open source` page's "MIT. Free. With the rights spelled out." headline structure.

---

## Validation: design choices vs catalog data

| Site surface | Catalog pattern matched | Status |
|---|---|---|
| Hero CTA structure | 4.1 (Linear), 4.7 (Supabase) — single primary pill + secondary ghost CTA | ✓ aligned |
| Hero rhythm (eyebrow → headline → lede → CTA) | 4.4 (Vercel) — centered dual-CTA under short value prop | ✓ aligned |
| Download rail pattern | 4.8/4.9/4.10 (Cursor, Wispr, Superhuman) — single Mac download CTA + secondary install rail | ✓ aligned |
| Codec picker layout | 3.1/3.2 (Loom, VEED) — quality dropdown + helper copy + tabbed advanced settings | ✓ aligned |
| Codec primary-accent | 3.1 (Loom) — segmented quality control | ✓ aligned (left coral border on `H.264`) |
| Keyboard shortcut groupings | 2.1/2.4 (Etsy, Notion) — hairline-separated groups | ✓ aligned (`Recording` / `Library` / `Trim` / `Window`) |
| Open-source framing | 5.1/5.4/5.8 (Supabase, Greptile, Lightdash) — license badge + Start for free + dual CTA | ✓ aligned |
| Footer link grouping | 2.1 (Etsy) — Activity / Commerce / System groups | ✓ aligned (`Product` / `Project`) |
| Changelog rhythm | 4.6 (Vercel) — repeated CTA rhythm below feature grid | ✓ aligned (no secondary CTA, but cadence table follows the discipline) |

**One observation worth a future change**: none of the captured screens show a `Recap / What's next` block at the end of release notes. Clipwell's changelog ends with the semver cadence table, which is sufficient — but adding a "Looking ahead" closing block (currently absent) would mirror the 4.6 conversion discipline. Out of scope for the initial rebuild; flagged for a future pass.

---

## Public-web fallback (preserved for traceability)

While Mobbin was gated, the following 38 public-web references were collected. They are retained so the design audit trail is intact and so any future contributor can re-trace the original sources.

### 1. Screen-recorder / capture-tool patterns

1. **Loom — `https://www.loom.com/screen-recorder`** — Three-step pre-record → countdown → record → auto-upload pipeline.
2. **Loom — capture-mode UX** (`Atlassian blog`) — Movable recording menu, hide-controls-in-final-video toggle, dynamic audio waveform.
3. **CleanShot X — `https://cleanshot.com/features`** — Quick Access Overlay for post-record viewing/annotating/sharing.
4. **CleanShot X — `https://cleanshot.com/screen-recording`** — Capture-matrix page walking through separate audio sources.
5. **CleanShot X — URL scheme docs** (`https://cleanshot.com/docs-api`) — Public reference for the `cleanshot://capture-fullscreen` URL scheme.
6. **Mobbin — Audio & Video Recorder** (`https://mobbin.com/explore/web/screens/audio-video-recorder`) — 190 captured screens.
7. **Droplr — `https://help.droplr.com/getting-started/what-is-droplr-main-features/`** — Screenshot → Annotate → Upload → Share funnel.
8. **Loom capture modes** (`Atlassian support`) — Three-mode selector pattern.
9. **Droplr — `hackdesign.org/toolkit/droplr/`** — Menubar-first capture pattern description.
10. **Mobbin — Web > Audio & Video Recorder (mobile)** (`https://mobbin.com/explore/mobile/screens/audio-video-recorder`) — 698 screens.

### 2. macOS-native menu-bar app patterns

11. **Droplr — `https://droplr.com/updates/`** — Feature-icon-then-label rows in menubar dropdowns.
12. **CleanShot X — `https://cleanshot.com/changelog`** — Visual reference for macOS-native changelog rhythm.
13. **Dribbble — "mac menu bar" tag** (`https://dribbble.com/search/mac-menu-bar`) — 96+ shots of menubar dropdown UIs.
14. **Dribbble — "macos menu bar app" tag** (`https://dribbble.com/search/macos-menu-bar-app`) — Concept shots for menubar apps.
15. **Dribbble — "Menu Bar App" tag** (`https://dribbble.com/tags/menu-bar-app`) — Curated menubar shots.
16. **CleanShot X — `https://cleanshot.com/`** — macOS-native marketing benchmark.
17. **Raycast — `https://ai2.design/inspiration/raycast`** — Long-form design breakdown.
18. **Raycast design system notes** (`github.com/VoltAgent/awesome-design-md`) — Pure-near-black, Inter with `ss03`, white CTA pill.

### 3. Settings panes with codec/container grids

19. **Mobbin — Settings & Preferences** (`https://mobbin.com/explore/web/screens/settings-preferences`) — 3,000+ settings screens.
20. **Mobbin — "Project Settings Overview"** — Side-rail nav + section rows.
21. **Mobbin — "General Settings Page"** — Tab-based settings.
22. **Mobbin — "Updated Profile"** — Text Field + Tab settings.
23. **Mobbin — "Updated Color Palette" by Databricks** — Color picker layout.
24. **HandBrake** (general public pattern) — Codec picker pattern: stacked rows with `Format` / `Codec` / `Quality`.
25. **FFmpeg `man` page convention** — Dense-but-organized technical reference pattern.

### 4. Hero / pricing / download CTA patterns

26. **Mobbin — Sign Up UI Page Design Ideas** (`https://mobbin.com/explore/web/screens/signup`) — SaaS signup CTAs.
27. **Mobbin — Web > Login Page Design Examples** (`https://mobbin.com/explore/web/screens/login`) — Pitch login flow + Folk login flow.
28. **Mobbin — Web > Dark Mode Design** (`https://mobbin.com/explore/web/screens/dark-mode`) — 1,000+ screens.
29. **Linear brand palette page** (`https://mobbin.com/colors/brand/linear`) — Canonical 5-key brand palette.
30. **Raycast design breakdown** (`https://norrly.io/inspiration/raycast-com`) — Quantitative color extraction.
31. **Vercel-style hero rhythm** (Mobbin `https://mobbin.com/browse/web/marketing-pages`) — Marketing-page category index.
32. **Linear landing inspiration** (Mobbin `5a1facac-b69f-4b76-ab6e-f274577fef03`) — Universal SaaS landing flow.

### 5. Open-source / "free / MIT" framing

33. **Supabase landing** (Mobbin SaaS-dashboard category) — "Start for free" + "View on GitHub" dual-CTA pattern.
34. **Cal.com-style open-source product pages** — License badge, GitHub link, contributor count, "Deploy your own" CTA.
35. **Ollama local-first framing** — "100% private, runs offline" headline pattern.
36. **MIT-licensed landing page templates** (`mirislomovmirjalol/Saas-landing-page`, `stormynynynight9/saasstellar`) — MIT as trust signal.
37. **Dev Landing Page** (`https://template0.com/item/dev-landing-page`) — MIT-licensed GitHub-Pages-ready template.
38. **Mobbin `Changelog` and `Open Source` mentions** (`https://mobbin.com/browse/web/marketing-pages`) — Category index.

---

## Synthesis — what Clipwell's rebuild commits to

Drawing on both passes:

- **Hero structure**: single product visualization (floating menubar panel) over a dark canvas, one-wordmark line, one subtitle, two CTAs (`Download for macOS` primary + `See the capture flow →` secondary). Pattern: 4.1 (Linear) + 4.4 (Vercel) + 4.7 (Supabase).
- **Brand register**: macOS-native vibrancy, monospaced numerics in spec callouts, SF Pro / Inter (with `ss03`). Pattern: Raycast design system (18, 30).
- **Five-key palette discipline**: Indigo + violet + coral + ink + warm cream. Pattern: Linear's 5-key palette (29) but warmer.
- **Capture-flow copy**: Three-mode picker (Displays / Windows / Areas), pre-record audio indicator, post-record Quick Access panel — borrowed from 1.1/1.4 (Loom) and Vimeo 1.9.
- **Codec guide**: Tabbed advanced settings + quality dropdowns with helper copy. Pattern: 3.1 (Loom) + 3.2 (VEED).
- **Open-source framing**: License badge in the hero, GitHub star count, `brew install` command block, no "buy" CTA — parallel to 5.1 (Supabase), 5.4 (Greptile), 5.8 (Lightdash).
- **Footer grouping**: Two labeled groups (`Product` / `Project`) with hairline separator discipline. Pattern: 2.1 (Etsy).
- **No copyright violation**: every screen referenced on the Clipwell site comes from `website/public/` (the actual product screenshots already shipped with the repo). Mobbin references are *pattern inspiration* only — never copied wholesale.

## Re-research triggers

Run this pass again when:

1. Mobbin begins indexing macOS-native apps (CleanShot X, Bartender, Raycast app UI) — drop the substitution policy and pull direct references.
2. Clipwell ships a new feature surface (e.g., cloud sync) — re-run the open-source-framing pass.
3. The brand palette is reworked — re-run the hero / CTA pass for new accent-discipline references.
4. The changelog cadence moves from MIT-public to a commercial split — re-run the open-source-framing pass.

## Evidence trail

- **First pass** (public-web fallback, 2026-09-21): `web_search` × 24 (`site:mobbin.com` + public competitor + Dribbble queries); `web_fetch` × 5 (Mobbin category index pages + Linear color page); `mcode-tools connector tools --keyword mobbin` → no local MCP at the time.
- **Second pass** (Mobbin catalog deep, 2026-09-21): Cursor MCP `search_screens` + `search_sections` queries across 5 categories. Raw output preserved in `MOBBIN_DEEP_REFS.json` (46 entries with substitution policy).
- **MCP server configuration**: `https://api.mobbin.com/mcp` (streamable-http + OAuth via DCR), registered in this Mavis session via `mavis mcp create`. OAuth handshake is browser-mediated; Cursor handled the dance, Mavis session does not have `tool_search` available so cannot trigger it directly.