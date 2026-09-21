<script lang="ts">
  const shortcuts = [
    ['Toggle record / stop', '⌃⌥⌘ R', 'Recording'],
    ['Toggle record (then copy link)', '⌃⌥⌘ ⇧ R', 'Recording'],
    ['Open the recordings folder', '⌃⌥⌘ O', 'Library'],
    ['Open the trim window', '⌃⌥⌘ T', 'Trim'],
    ['Reveal menu bar icon', '⌃⌥⌘ M', 'Window'],
    ['Pause / resume', 'Space (recording window)', 'Recording']
  ];
</script>

<section class="shortcuts" aria-labelledby="shortcuts-title">
  <div class="shortcuts__inner">
    <header class="shortcuts__head">
      <p class="mono-label">Reference · 3 of 4</p>
      <h2 id="shortcuts-title">Keyboard shortcuts</h2>
      <p class="shortcuts__lede">Mod chords are chosen so they do not collide with system capture, screen lock, or Spotlight.</p>
    </header>

    <div class="shortcuts__grid">
      {#each shortcuts as [label, combo, surface]}
        <div class="shortcuts__row">
          <span class="shortcuts__surface">{surface}</span>
          <span class="shortcuts__label">{label}</span>
          <kbd class="shortcuts__combo">{combo}</kbd>
        </div>
      {/each}
    </div>
  </div>
</section>

<style>
  .shortcuts {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .shortcuts__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .shortcuts__head {
    margin-bottom: var(--space-2xl);
  }

  .shortcuts__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .shortcuts__lede {
    max-width: 48ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .shortcuts__grid {
    display: grid;
    gap: 0;
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  .shortcuts__row {
    display: grid;
    grid-template-columns: minmax(0, 0.7fr) minmax(0, 1.5fr) auto;
    align-items: center;
    gap: var(--space-md);
    padding-block: var(--space-md);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .shortcuts__surface {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .shortcuts__label {
    color: var(--color-ink);
    font-size: var(--text-base);
  }

  .shortcuts__combo {
    color: var(--color-ink);
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 8px;
    padding: 0.35rem 0.6rem;
    white-space: nowrap;
  }

  @media (max-width: 40rem) {
    .shortcuts__row {
      grid-template-columns: 1fr;
      gap: var(--space-xs);
    }

    .shortcuts__combo {
      justify-self: start;
    }
  }
</style>