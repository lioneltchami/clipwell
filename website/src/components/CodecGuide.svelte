<script lang="ts">
  const codecs = [
    {
      name: 'H.264',
      kind: 'Compressed',
      container: 'MOV · MP4',
      quality: 'High',
      size: 'Smallest files',
      speed: 'Fastest export',
      notes: 'The default. Plays everywhere, uploads to every host, ships in every email.',
      tone: 'primary'
    },
    {
      name: 'HEVC (H.265)',
      kind: 'Compressed',
      container: 'MOV · MP4',
      quality: 'Higher',
      size: '~50% smaller than H.264 at matching quality',
      speed: 'Slower encode',
      notes: 'Reach for it when the take is long, the disk is small, or the upload quota is tight.',
      tone: 'neutral'
    },
    {
      name: 'ProRes 422',
      kind: 'Mastering',
      container: 'MOV only',
      quality: 'Master-quality',
      size: '~10× H.264 at matching resolution',
      speed: 'Fast decode',
      notes: 'The format a video editor asks for. Keep HDR in 10-bit; preserves the color space.',
      tone: 'accent'
    },
    {
      name: 'ProRes 4444',
      kind: 'Mastering',
      container: 'MOV only',
      quality: 'Master + alpha',
      size: '~14× H.264',
      speed: 'Fast decode',
      notes: 'The only codec in the list that preserves the alpha channel. Compositing and overlays.',
      tone: 'neutral'
    }
  ];
</script>

<section class="codec" aria-labelledby="codec-title">
  <div class="codec__inner">
    <header class="codec__head">
      <p class="mono-label">Reference · 2 of 4</p>
      <h2 id="codec-title">Codec & container guide</h2>
      <p class="codec__lede">
        Clipwell ships four video codecs and two containers. The picker enforces valid combinations:
        alpha is MOV-only; HDR is ProRes-only in MOV; MP4 caps out at H.264/HEVC + AAC.
      </p>
    </header>

    <ol class="codec__list" role="list">
      {#each codecs as codec, index}
        <li class="codec__row frame" data-tone={codec.tone}>
          <div class="codec__index" aria-hidden="true">0{index + 1}</div>
          <div class="codec__name">
            <h3>{codec.name}</h3>
            <p class="codec__kind">{codec.kind}</p>
          </div>
          <dl class="codec__grid">
            <div>
              <dt>Container</dt>
              <dd>{codec.container}</dd>
            </div>
            <div>
              <dt>Quality</dt>
              <dd>{codec.quality}</dd>
            </div>
            <div>
              <dt>File size</dt>
              <dd>{codec.size}</dd>
            </div>
            <div>
              <dt>Speed</dt>
              <dd>{codec.speed}</dd>
            </div>
          </dl>
          <p class="codec__notes">{codec.notes}</p>
        </li>
      {/each}
    </ol>
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

  .codec__list {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: var(--space-md);
  }

  .codec__row {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: var(--space-md) var(--space-lg);
    padding: var(--space-xl);
    background: var(--color-paper-2);
    align-items: start;
  }

  .codec__row[data-tone='primary'] {
    border-left: 3px solid var(--color-accent);
  }

  .codec__index {
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    color: var(--color-ink-3);
    font-variant-numeric: tabular-nums;
    padding-top: 0.3rem;
  }

  .codec__name h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-xl);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .codec__kind {
    margin: 0.2rem 0 0;
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .codec__grid {
    grid-column: 1 / -1;
    display: grid;
    gap: 0;
    margin: var(--space-md) 0 0;
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
    grid-column: 2 / -1;
    margin: 0;
    padding-top: var(--space-md);
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  @media (min-width: 60rem) {
    .codec__grid {
      grid-column: 2 / -1;
      grid-template-columns: repeat(4, minmax(0, 1fr));
      margin-top: var(--space-md);
    }

    .codec__grid div {
      grid-template-columns: 1fr;
      gap: var(--space-2xs);
    }

    .codec__notes {
      grid-column: 2 / -1;
    }
  }
</style>