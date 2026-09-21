<script lang="ts">
  const useCases = [
    {
      kind: 'developer-tutorial',
      title: 'Developer walk-throughs',
      summary:
        'Capture the editor, the terminal, the running app — and the keystrokes that explain what the cursor is doing.',
      detail:
        'Use the keystone overlay to show the shortcut, the click pulse to point at the line, and the trim window to cut to the moment the build completes.',
      output: 'H.264 / MOV · 1080p · 60 fps'
    },
    {
      kind: 'product-demo',
      title: 'Product demos and Loom-style tours',
      summary:
        'Pick a window, layer the camera bubble, record the system audio for the app, and ship a single MOV that drops into a doc.',
      detail:
        'Picture-in-picture overlay, system + mic mix, and a clean MP4 export ready for a marketing page or a Sora post.',
      output: 'H.264 / MP4 · 1440p · 30 fps'
    },
    {
      kind: 'bug-repro',
      title: 'Bug reproductions',
      summary:
        'Custom area, system audio, no microphone — a focused recording of the failing surface, sized for the issue tracker.',
      detail:
        'Trim to the moment the bug fires; export as GIF if the tracker accepts inline playback; otherwise drop the MOV.',
      output: 'HEVC / MOV or GIF'
    },
    {
      kind: 'internal-docs',
      title: 'Internal docs and walkthroughs',
      summary:
        'Long-running screen records of admin tools, dashboards, and SQL queries — keep on the file system, share via Finder.',
      detail:
        'Pick a folder once; the recordings live alongside the rest of the documentation. Filenames are timestamped; no upload step, no sync, no quota.',
      output: 'ProRes 422 / MOV for the master'
    },
    {
      kind: 'education',
      title: 'Lectures and how-tos',
      summary:
        'Record a presentation, draw on top of slides, export a MOV the school can host without a subscription.',
      detail:
        'Drawing tools, click highlights, and camera overlay keep the recording close to a real lecture. Trim the silence at the head and the tail.',
      output: 'H.264 / MP4 · 1080p · 30 fps'
    },
    {
      kind: 'support',
      title: 'Customer-support responses',
      summary:
        'Short clips showing the customer exactly which button to press, attached to the ticket as a MOV.',
      detail:
        'Use the area-capture mode for the affected panel only — the customer sees what they need, not your whole desktop.',
      output: 'HEVC / MOV · small file'
    }
  ];
</script>

<section class="uc" aria-labelledby="uc-title">
  <div class="uc__inner">
    <header class="uc__head">
      <p class="mono-label">Use cases</p>
      <h2 id="uc-title">Six shapes a take usually has.</h2>
      <p class="uc__lede">
        Each pick below names the codec, the output container, and the controls that earn their keep. The point
        of having a Capture matrix is that you stop thinking about it.
      </p>
    </header>

    <div class="uc__grid">
      {#each useCases as item}
        <article class="uc__card frame" data-kind={item.kind}>
          <header>
            <span class="uc__kind">{item.kind}</span>
            <h3>{item.title}</h3>
          </header>
          <p class="uc__summary">{item.summary}</p>
          <p class="uc__detail">{item.detail}</p>
          <p class="uc__output">
            <span>Recommended output</span>
            <code>{item.output}</code>
          </p>
        </article>
      {/each}
    </div>
  </div>
</section>

<style>
  .uc {
    padding: var(--space-2xl) var(--page-gutter) var(--space-4xl);
  }

  .uc__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .uc__head {
    margin-bottom: var(--space-2xl);
  }

  .uc__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .uc__lede {
    max-width: 56ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .uc__grid {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .uc__card {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-md);
  }

  .uc__card header {
    display: grid;
    gap: var(--space-2xs);
  }

  .uc__kind {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .uc__card h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-xl);
    letter-spacing: -0.02em;
    color: var(--color-ink);
    line-height: 1.25;
  }

  .uc__summary {
    margin: 0;
    color: var(--color-ink);
    font-size: var(--text-base);
    line-height: 1.55;
  }

  .uc__detail {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.6;
  }

  .uc__output {
    margin: var(--space-2xs) 0 0;
    padding-top: var(--space-sm);
    border-top: var(--rule-hair) solid var(--color-rule);
    display: grid;
    gap: var(--space-2xs);
  }

  .uc__output span {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .uc__output code {
    color: var(--color-ink);
    font-family: var(--font-mono);
    font-size: var(--text-sm);
  }

  @media (min-width: 48rem) {
    .uc__grid {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }

  @media (min-width: 75rem) {
    .uc__grid {
      grid-template-columns: repeat(3, minmax(0, 1fr));
    }
  }
</style>