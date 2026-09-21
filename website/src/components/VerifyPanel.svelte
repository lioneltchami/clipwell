<script lang="ts">
  const steps = [
    {
      step: '01',
      title: 'Compare the SHA-256',
      detail:
        'Each release body records the DMG SHA-256. Compute the checksum yourself with shasum -a 256 Clipwell-*.dmg and compare.'
    },
    {
      step: '02',
      title: 'Confirm Apple notarization',
      detail:
        'Open the DMG, copy the app to /Applications, and run spctl --assess --verbose /Applications/Clipwell.app. The verdict should read "accepted".'
    },
    {
      step: '03',
      title: 'Inspect the Sparkle signature',
      detail:
        'Sparkle publishes the EdDSA signature alongside the enclosure in the appcast. Clipwell verifies it before any auto-update is offered.'
    }
  ];
</script>

<section class="verify" aria-labelledby="verify-title">
  <div class="verify__inner">
    <header class="verify__head">
      <p class="mono-label">Install · 3 of 3</p>
      <h2 id="verify-title">Verify the artifact</h2>
      <p class="verify__lede">Free software does not mean unsigned software. Three checks before you trust the binary.</p>
    </header>

    <ol class="verify__steps" role="list">
      {#each steps as entry}
        <li class="verify__step frame">
          <span class="verify__index" aria-hidden="true">{entry.step}</span>
          <h3>{entry.title}</h3>
          <p>{entry.detail}</p>
        </li>
      {/each}
    </ol>
  </div>
</section>

<style>
  .verify {
    padding: var(--space-2xl) var(--page-gutter) var(--space-4xl);
  }

  .verify__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .verify__head {
    margin-bottom: var(--space-2xl);
  }

  .verify__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .verify__lede {
    max-width: 52ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .verify__steps {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .verify__step {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-sm);
  }

  .verify__index {
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    color: var(--color-accent);
    font-variant-numeric: tabular-nums;
    letter-spacing: 0.04em;
  }

  .verify__step h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .verify__step p {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.6;
  }

  .verify__step p :global(code) {
    font-family: var(--font-mono);
    font-size: 0.85em;
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 6px;
    padding: 0.1rem 0.35rem;
  }

  @media (min-width: 60rem) {
    .verify__steps {
      grid-template-columns: repeat(3, minmax(0, 1fr));
    }
  }
</style>