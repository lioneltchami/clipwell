<script lang="ts">
  const rows = [
    { name: 'Codecs', value: 'ProRes 422/4444, HEVC, H.264', note: 'Alpha + HDR when the codec allows' },
    { name: 'Audio', value: 'System + microphone', note: 'Separate tracks on write' },
    { name: 'Camera', value: 'Built-in overlay layouts', note: 'Small / large / bar / hidden' },
    { name: 'Aids', value: 'Clicks, keys, annotations', note: 'Composited into the video' },
    { name: 'Export', value: 'Trim + GIF', note: 'After the take, still offline' },
    { name: 'Privacy', value: 'Local only', note: 'No analytics, no cloud account' }
  ];
</script>

<section id="spec" class="spec">
  <div class="spec__inner">
    <div class="spec__head reveal">
      <p class="mono-label">Spec</p>
      <h2>What ships in the menu bar</h2>
    </div>
    <div class="table frame reveal" role="table" aria-label="Clipwell capabilities">
      {#each rows as row}
        <div class="row" role="row">
          <div class="cell name" role="cell">{row.name}</div>
          <div class="cell value" role="cell">{row.value}</div>
          <div class="cell note" role="cell">{row.note}</div>
        </div>
      {/each}
    </div>
  </div>
</section>

<style>
  .spec {
    background: var(--color-band);
    padding: var(--space-3xl) var(--page-gutter);
    border-block: var(--rule-hair) solid var(--color-rule);
  }

  .spec__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .spec__head {
    margin-bottom: var(--space-xl);
  }

  h2 {
    color: var(--color-ink);
    font-size: var(--text-display-s);
    font-weight: 650;
    margin: var(--space-sm) 0 0;
  }

  .table {
    background: var(--color-band-2);
    border-color: var(--color-rule);
    border-radius: var(--radius-md);
  }

  .row {
    display: grid;
    gap: var(--space-xs);
    padding: var(--space-md) var(--space-lg);
    border-bottom: var(--rule-hair) solid var(--color-rule);
    min-width: 0;
  }

  .row:last-child {
    border-bottom: 0;
  }

  .name {
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    letter-spacing: 0.06em;
    text-transform: uppercase;
    color: var(--color-accent);
  }

  .value {
    font-family: var(--font-display);
    font-weight: 600;
    color: var(--color-ink);
  }

  .note {
    font-size: var(--text-sm);
    color: var(--color-ink-3);
  }

  @media (min-width: 40rem) {
    .row {
      grid-template-columns: minmax(0, 0.7fr) minmax(0, 1.2fr) minmax(0, 1.1fr);
      align-items: baseline;
      gap: var(--space-md);
    }
  }
</style>
