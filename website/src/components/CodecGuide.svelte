<script lang="ts">
  /*
    Codec guide — design derived from Mobbin catalog anchors:

    - 3.1 Loom Recording Settings quality dropdown (Auto / 1080p / 720p + helper copy)
      https://mobbin.com/screens/7c1a1525-918c-458e-9c12-2f0ac2982cb7
    - 3.2 VEED Advanced export pane (framerate slider, Resolution, Quality, Compression)
      https://mobbin.com/screens/31a6f2f9-8ff9-4c2a-a5ab-da6a51d2b9ef
    - 3.3 Riverside Export Options (2160p selector, Video vs Audio tabs, processing toggles)
      https://mobbin.com/screens/ee0beb67-600e-4f0c-bb1b-3d925d08ba1a
    - 3.5 Descript dense toggle grid with nested settings popover (interval / paragraph / offset)
      https://mobbin.com/screens/d64d5b2c-0c8c-46c5-8be1-9fec14ecea75
  */

  type Codec = {
    id: string;
    name: string;
    kind: string;
    container: string;
    quality: string;
    size: string;
    speed: string;
    notes: string;
    framerates: number[];
    behavior: { hdr: boolean; alpha: boolean; pcm: boolean };
    tone: 'primary' | 'neutral' | 'accent';
  };

  const codecs: Codec[] = [
    {
      id: 'h264',
      name: 'H.264',
      kind: 'Compressed',
      container: 'MOV · MP4',
      quality: 'High',
      size: 'Smallest files',
      speed: 'Fastest export',
      notes: 'The default. Plays everywhere, uploads to every host, ships in every email.',
      framerates: [24, 30, 60],
      behavior: { hdr: false, alpha: false, pcm: true },
      tone: 'primary'
    },
    {
      id: 'hevc',
      name: 'HEVC (H.265)',
      kind: 'Compressed',
      container: 'MOV · MP4',
      quality: 'Higher',
      size: '~50% smaller than H.264 at matching quality',
      speed: 'Slower encode',
      notes: 'Reach for it when the take is long, the disk is small, or the upload quota is tight.',
      framerates: [24, 30, 60],
      behavior: { hdr: false, alpha: false, pcm: true },
      tone: 'neutral'
    },
    {
      id: 'prores-422',
      name: 'ProRes 422',
      kind: 'Mastering',
      container: 'MOV only',
      quality: 'Master-quality',
      size: '~10× H.264 at matching resolution',
      speed: 'Fast decode',
      notes: 'The format a video editor asks for. Keep HDR in 10-bit; preserves the color space.',
      framerates: [24, 30, 60],
      behavior: { hdr: true, alpha: false, pcm: true },
      tone: 'accent'
    },
    {
      id: 'prores-4444',
      name: 'ProRes 4444',
      kind: 'Mastering',
      container: 'MOV only',
      quality: 'Master + alpha',
      size: '~14× H.264',
      speed: 'Fast decode',
      notes: 'The only codec in the list that preserves the alpha channel. Compositing and overlays.',
      framerates: [24, 30, 60],
      behavior: { hdr: true, alpha: true, pcm: true },
      tone: 'neutral'
    }
  ];

  let selected = $state<Codec>(codecs[0]);
  let framerate = $state(60);

  const behaviorLabels: Record<keyof Codec['behavior'], string> = {
    hdr: 'HDR (10-bit)',
    alpha: 'Alpha channel',
    pcm: 'PCM audio'
  };
</script>

<section class="codec" aria-labelledby="codec-title">
  <div class="codec__inner">
    <header class="codec__head">
      <p class="mono-label">Reference · 2 of 4</p>
      <h2 id="codec-title">Codec & container guide</h2>
      <p class="codec__lede">
        Pick the codec, the container follows. Quality and behavior toggles
        map to the codec you've chosen — invalid combinations are dimmed,
        not deleted.
      </p>
    </header>

    <div class="codec__layout">
      <div class="codec__list" role="tablist" aria-label="Codec picker">
        {#each codecs as codec, index}
          <button
            type="button"
            role="tab"
            aria-selected={selected.id === codec.id}
            class="codec__tab"
            class:is-active={selected.id === codec.id}
            data-tone={codec.tone}
            onclick={() => (selected = codec)}
          >
            <span class="codec__index" aria-hidden="true">0{index + 1}</span>
            <span class="codec__name">{codec.name}</span>
            <span class="codec__kind">{codec.kind}</span>
            <span class="codec__arrow" aria-hidden="true">→</span>
          </button>
        {/each}
      </div>

      <article class="codec__detail frame" data-tone={selected.tone} role="tabpanel">
        <header>
          <p class="mono-label">Selected codec</p>
          <h3>{selected.name}</h3>
        </header>

        <dl class="codec__grid">
          <div>
            <dt>Container</dt>
            <dd>{selected.container}</dd>
          </div>
          <div>
            <dt>Quality</dt>
            <dd>{selected.quality}</dd>
          </div>
          <div>
            <dt>File size</dt>
            <dd>{selected.size}</dd>
          </div>
          <div>
            <dt>Speed</dt>
            <dd>{selected.speed}</dd>
          </div>
        </dl>

        <p class="codec__notes">{selected.notes}</p>

        <div class="codec__settings">
          <div class="codec__setting">
            <h4>Frame rate</h4>
            <div class="codec__chips" role="radiogroup" aria-label="Frame rate">
              {#each selected.framerates as rate}
                <button
                  type="button"
                  class="codec__chip"
                  class:is-active={framerate === rate}
                  aria-pressed={framerate === rate}
                  onclick={() => (framerate = rate)}
                >
                  {rate} fps
                </button>
              {/each}
            </div>
          </div>

          <div class="codec__setting">
            <h4>Behavior</h4>
            <div class="codec__chips">
              {#each Object.entries(behaviorLabels) as [key, label]}
                <span
                  class="codec__chip"
                  class:is-on={selected.behavior[key as keyof Codec['behavior']]}
                  class:is-off={!selected.behavior[key as keyof Codec['behavior']]}
                  aria-hidden="true"
                >
                  <span class="codec__chip-dot"></span>
                  {label}
                </span>
              {/each}
            </div>
            <p class="codec__setting-note">
              Toggles dim when the codec cannot honor them.
              ProRes is the only MOV codec that carries HDR; ProRes 4444 is the only one that carries alpha.
            </p>
          </div>
        </div>
      </article>
    </div>

    <details class="codec__reference">
      <summary>Why these four codecs</summary>
      <p>
        Clipwell ships four video codecs and two containers. The picker enforces
        valid combinations: alpha is MOV-only; HDR is ProRes-only in MOV; MP4 caps
        out at H.264/HEVC + AAC. The framerate selector above applies to the
        current codec — 60 fps is available on every codec but only meaningful for
        motion-heavy captures.
      </p>
    </details>
  </div>
</section>

<style>
  .codec {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .codec__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .codec__head {
    margin-bottom: var(--space-2xl);
  }

  .codec__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .codec__lede {
    max-width: 52ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .codec__layout {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  /* Mobbin 3.1 Loom — tab-list + selected detail */
  .codec__list {
    display: grid;
    gap: var(--space-xs);
    list-style: none;
    margin: 0;
    padding: 0;
  }

  .codec__tab {
    display: grid;
    grid-template-columns: auto minmax(0, 1fr) auto auto;
    gap: var(--space-md);
    align-items: baseline;
    padding: var(--space-md) var(--space-lg);
    background: var(--color-paper-2);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 12px;
    color: var(--color-ink);
    font: inherit;
    text-align: left;
    cursor: pointer;
    transition: background var(--dur-fast) var(--ease-out);
  }

  .codec__tab:hover {
    background: var(--color-paper-3);
  }

  .codec__tab.is-active {
    background: var(--color-paper-3);
  }

  .codec__tab[data-tone='primary'].is-active {
    border-left: 3px solid var(--color-accent);
  }

  .codec__index {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    font-variant-numeric: tabular-nums;
  }

  .codec__name {
    font-family: var(--font-display);
    font-size: var(--text-base);
    letter-spacing: -0.02em;
  }

  .codec__kind {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .codec__arrow {
    color: var(--color-ink-3);
    font-family: var(--font-display);
  }

  .codec__tab.is-active .codec__arrow {
    color: var(--color-accent);
  }

  /* Mobbin 3.2 VEED + 3.3 Riverside — advanced pane stacking */
  .codec__detail {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-lg);
  }

  .codec__detail[data-tone='primary'] {
    border-left: 3px solid var(--color-accent);
  }

  .codec__detail header h3 {
    margin: var(--space-xs) 0 0;
    font-family: var(--font-display);
    font-size: var(--text-4xl);
    letter-spacing: -0.04em;
    color: var(--color-ink);
  }

  .codec__grid {
    display: grid;
    gap: 0;
    margin: 0;
    padding-top: var(--space-md);
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  .codec__grid div {
    display: grid;
    grid-template-columns: minmax(0, 0.4fr) minmax(0, 1fr);
    gap: var(--space-md);
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .codec__grid div:last-child {
    border-bottom: 0;
  }

  dt {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  dd {
    margin: 0;
    color: var(--color-ink);
    font-size: var(--text-sm);
  }

  .codec__notes {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.6;
  }

  /* Mobbin 3.2 VEED — framerate slider rendered as chips, 3.3 — segmented quality */
  .codec__settings {
    display: grid;
    gap: var(--space-md);
    padding-top: var(--space-md);
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  .codec__setting h4 {
    margin: 0 0 var(--space-sm);
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .codec__chips {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-xs);
  }

  .codec__chip {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    padding: 0.4rem 0.7rem;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-sm);
    background: var(--color-paper-3);
    color: var(--color-ink-2);
    font: inherit;
    font-size: var(--text-xs);
    font-weight: 500;
    cursor: pointer;
    transition: background var(--dur-fast) var(--ease-out);
  }

  button.codec__chip.is-active {
    background: var(--color-accent);
    border-color: var(--color-accent);
    color: var(--color-accent-ink);
  }

  .codec__chip.is-on {
    color: var(--color-ink);
  }

  .codec__chip.is-off {
    color: var(--color-ink-3);
    border-style: dashed;
  }

  .codec__chip-dot {
    width: 0.4rem;
    height: 0.4rem;
    border-radius: 50%;
    background: var(--color-ink-3);
  }

  .codec__chip.is-on .codec__chip-dot {
    background: var(--color-ok);
  }

  .codec__setting-note {
    margin: var(--space-xs) 0 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    line-height: 1.55;
  }

  .codec__reference {
    margin-top: var(--space-2xl);
    padding: var(--space-md) var(--space-lg);
    background: var(--color-paper-2);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 12px;
  }

  .codec__reference summary {
    cursor: pointer;
    color: var(--color-ink-2);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .codec__reference p {
    margin: var(--space-md) 0 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.6;
    max-width: 60ch;
  }

  @media (min-width: 60rem) {
    .codec__layout {
      grid-template-columns: minmax(0, 0.45fr) minmax(0, 1fr);
      align-items: start;
    }
  }
</style>