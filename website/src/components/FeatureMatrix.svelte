<script lang="ts">
  const rows = [
    {
      surface: 'Capture sources',
      entries: [
        ['Full display', 'Built-in or external. Multi-monitor safe.'],
        ['Single window', 'Tracks the window frame even if it moves.'],
        ['Application group', 'Every window owned by an app at once.'],
        ['Custom area', 'Drag-to-select rectangle, 24 pt minimum.']
      ]
    },
    {
      surface: 'Audio routing',
      entries: [
        ['System audio', 'ScreenCaptureKit loopback. No driver needed.'],
        ['Microphone', 'Any AVCaptureDevice input, with level meter.'],
        ['System + mic mix', 'Captured as separate tracks, mixed on stop.'],
        ['PCM / AAC', 'Uncompressed audio in MOV; AAC when targeting MP4.']
      ]
    },
    {
      surface: 'Annotations',
      entries: [
        ['Click highlights', 'Pulse rings around every mouse-down.'],
        ['Keystroke overlays', 'Visible key chords, with shortcuts expanded.'],
        ['Drawing tools', 'Pen, highlighter, rectangle, arrow.'],
        ['Camera overlay', 'Picture-in-picture layouts: corner, side, inset.']
      ]
    },
    {
      surface: 'Post-record',
      entries: [
        ['Trim window', 'Scrub the head and tail to the frame.'],
        ['GIF export', 'Convert a clip to an animated GIF in one step.'],
        ['MOV / MP4', 'Choose the container; the codec follows the rules.'],
        ['Save location', 'Pick a folder once; it stays the default.']
      ]
    }
  ];
</script>

<section class="matrix" aria-labelledby="matrix-title">
  <div class="matrix__inner">
    <header class="matrix__head">
      <p class="mono-label">Reference · 1 of 4</p>
      <h2 id="matrix-title">Capture matrix</h2>
      <p class="matrix__lede">Every input the menu bar can carry, every output the trim window can save.</p>
    </header>

    <div class="matrix__grid">
      {#each rows as group}
        <article class="matrix__card frame">
          <h3>{group.surface}</h3>
          <dl>
            {#each group.entries as [term, definition]}
              <div>
                <dt>{term}</dt>
                <dd>{definition}</dd>
              </div>
            {/each}
          </dl>
        </article>
      {/each}
    </div>
  </div>
</section>

<style>
  .matrix {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .matrix__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .matrix__head {
    margin-bottom: var(--space-2xl);
  }

  .matrix__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .matrix__lede {
    max-width: 48ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .matrix__grid {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .matrix__card {
    padding: var(--space-xl);
    background: var(--color-paper-2);
  }

  .matrix__card h3 {
    margin: 0 0 var(--space-md);
    font-family: var(--font-display);
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .matrix__card dl {
    margin: 0;
    display: grid;
    gap: 0;
  }

  .matrix__card dl div {
    display: grid;
    grid-template-columns: minmax(0, 0.45fr) minmax(0, 1fr);
    gap: var(--space-md);
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .matrix__card dl div:last-child {
    border-bottom: 0;
  }

  dt {
    color: var(--color-ink);
    font-weight: 500;
    font-size: var(--text-sm);
  }

  dd {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
  }

  @media (min-width: 48rem) {
    .matrix__grid {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }
</style>