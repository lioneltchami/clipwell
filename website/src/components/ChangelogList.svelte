<script lang="ts">
  const releases = [
    {
      version: 'v1.1.0',
      tag: 'current',
      date: 'In progress · 2026',
      headline: 'Free MIT release. Surface tuning, no commercial fork.',
      highlights: [
        'Recording Presets stay inside the MIT branch — historic MIT-covered material is preserved in every distribution.',
        'Smoke-test matrix extended to 21 cases (full display, single window, application group, custom area; H.264, HEVC, ProRes 422, ProRes 4444; system / mic / mix / PCM).',
        'Sparkle appcast re-pointed at the public GitHub Release DMG. Auto-update path remains signed and notarized.',
        'URL-scheme automation (`clipwell://`) remains canonical; `bettercapture://` and `captureforge://` survive as compat bridges.'
      ],
      notes:
        'Not the delivery path for any future commercial offer. Commercial builds, when they exist, will be separate artifacts with separate SHA-256 checksums.'
    },
    {
      version: 'v1.0.1',
      tag: 'patch',
      date: '2025',
      headline: 'Patch release. Recording stability, audio routing fixes.',
      highlights: [
        'Recording continues past the one-hour mark without buffer starvation.',
        'System audio + microphone mix captured as separate tracks, mixed on stop.',
        'App Group content filter respects the same exclusion rules as Window capture.'
      ],
      notes: 'MIT-era baseline. Distribution still served from the public GitHub Release.'
    },
    {
      version: 'v1.0.0',
      tag: 'milestone',
      date: '2024',
      headline: 'Public release. Capture engine, codec picker, annotations.',
      highlights: [
        'ScreenCaptureKit capture pipeline over `SCStream` and `AVAssetWriter`.',
        'Four video codecs (H.264, HEVC, ProRes 422, ProRes 4444) and two containers (MOV, MP4).',
        'Picture-in-picture camera overlay, click highlights, keystroke overlays, drawing tools.',
        'Trim window and GIF export after the take lands on disk.'
      ],
      notes: 'The first public build. MIT-licensed from the start.'
    }
  ];

  const cadence = [
    { label: 'Major', meaning: 'Incompatible user-facing, update, or automation changes.' },
    { label: 'Minor', meaning: 'Compatible features. The 1.1.x line is MIT and free.' },
    { label: 'Patch', meaning: 'Compatible bug fixes. Backportable across the current minor.' },
    { label: 'Prerelease', meaning: 'Tagged `vX.Y.Z-beta.N`. Internal preview only; not promoted.' }
  ];
</script>

<section class="changelog" aria-labelledby="changelog-title">
  <div class="changelog__inner">
    <header class="changelog__head">
      <p class="mono-label">Changelog</p>
      <h2 id="changelog-title">Release history</h2>
      <p class="changelog__lede">
        Every public Clipwell build ships signed, notarized, and stapled. The full appcast lives at
        <code>github.com/lioneltchami/clipwell/releases/latest/download/appcast.xml</code>.
      </p>
    </header>

    <ol class="changelog__list" role="list">
      {#each releases as release}
        <li class="changelog__entry frame" data-tag={release.tag}>
          <header>
            <div>
              <span class="changelog__tag">{release.tag}</span>
              <h3>{release.version}</h3>
            </div>
            <time>{release.date}</time>
          </header>
          <p class="changelog__headline">{release.headline}</p>
          <ul>
            {#each release.highlights as line}
              <li>{line}</li>
            {/each}
          </ul>
          {#if release.notes}
            <p class="changelog__note">{release.notes}</p>
          {/if}
        </li>
      {/each}
    </ol>

    <section class="changelog__cadence frame" aria-labelledby="cadence-title">
      <h3 id="cadence-title">Versioning</h3>
      <p>Semantic version. The cadence below is reproduced from <code>docs/RELEASE.md</code>:</p>
      <dl>
        {#each cadence as row}
          <div>
            <dt>{row.label}</dt>
            <dd>{row.meaning}</dd>
          </div>
        {/each}
      </dl>
    </section>
  </div>
</section>

<style>
  .changelog {
    padding: var(--space-2xl) var(--page-gutter) var(--space-4xl);
  }

  .changelog__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .changelog__head {
    margin-bottom: var(--space-2xl);
  }

  .changelog__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .changelog__lede {
    max-width: 56ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .changelog__lede code {
    font-family: var(--font-mono);
    font-size: 0.85em;
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 6px;
    padding: 0.1rem 0.35rem;
  }

  .changelog__list {
    list-style: none;
    margin: 0 0 var(--space-3xl);
    padding: 0;
    display: grid;
    gap: var(--space-lg);
  }

  .changelog__entry {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-md);
  }

  .changelog__entry[data-tag='current'] {
    border-left: 3px solid var(--color-accent);
  }

  .changelog__entry header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    gap: var(--space-md);
  }

  .changelog__entry h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-4xl);
    letter-spacing: -0.04em;
    color: var(--color-ink);
    font-variant-numeric: tabular-nums;
  }

  .changelog__tag {
    display: inline-block;
    margin-right: var(--space-sm);
    padding: 0.15rem 0.5rem;
    border-radius: var(--radius-sm);
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
    vertical-align: middle;
  }

  .changelog__entry[data-tag='current'] .changelog__tag {
    color: var(--color-accent);
    border-color: var(--color-accent);
  }

  .changelog__entry time {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
    white-space: nowrap;
  }

  .changelog__headline {
    margin: 0;
    color: var(--color-ink);
    font-size: var(--text-lg);
    font-weight: 500;
    line-height: 1.4;
  }

  .changelog__entry ul {
    margin: 0;
    padding-left: 1.2rem;
    display: grid;
    gap: var(--space-2xs);
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  .changelog__note {
    margin: 0;
    padding-top: var(--space-sm);
    border-top: var(--rule-hair) solid var(--color-rule);
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    line-height: 1.55;
  }

  .changelog__cadence {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-md);
  }

  .changelog__cadence h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .changelog__cadence p {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  .changelog__cadence code {
    font-family: var(--font-mono);
    font-size: 0.85em;
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 6px;
    padding: 0.1rem 0.35rem;
  }

  .changelog__cadence dl {
    margin: 0;
    display: grid;
    gap: 0;
  }

  .changelog__cadence dl div {
    display: grid;
    grid-template-columns: minmax(0, 0.25fr) minmax(0, 1fr);
    gap: var(--space-md);
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .changelog__cadence dl div:last-child {
    border-bottom: 0;
  }

  .changelog__cadence dt {
    color: var(--color-accent);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .changelog__cadence dd {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
  }

  @media (max-width: 40rem) {
    .changelog__entry header {
      flex-direction: column;
      align-items: flex-start;
      gap: var(--space-xs);
    }
  }
</style>