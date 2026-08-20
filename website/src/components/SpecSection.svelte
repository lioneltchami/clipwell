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
    color: oklch(94% 0.01 55);
    padding: var(--space-3xl) var(--page-gutter);
  }

  .spec__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .spec__head {
    margin-bottom: var(--space-xl);
  }

  .spec__head .mono-label {
    color: oklch(78% 0.04 45);
  }

  h2 {
    color: oklch(97% 0.01 55);
    font-size: var(--text-display-s);
    font-weight: 650;
    margin: var(--space-sm) 0 0;
  }

  .table {
    background: var(--color-band-2);
    border-color: oklch(42% 0.03 40);
    border-radius: var(--radius-md);
  }

  .row {
    display: grid;
    gap: var(--space-xs);
    padding: var(--space-md) var(--space-lg);
    border-bottom: var(--rule-hair) solid oklch(42% 0.03 40);
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
    color: oklch(78% 0.1 40);
  }

  .value {
    font-family: var(--font-display);
    font-weight: 600;
    color: oklch(97% 0.01 55);
  }

  .note {
    font-size: var(--text-sm);
    color: oklch(78% 0.02 50);
  }

  @media (min-width: 40rem) {
    .row {
      grid-template-columns: minmax(0, 0.7fr) minmax(0, 1.2fr) minmax(0, 1.1fr);
      align-items: baseline;
      gap: var(--space-md);
    }
  }
</style>
