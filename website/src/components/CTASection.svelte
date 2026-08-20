<section class="cta reveal">
  <div class="cta__inner frame">
    <div>
      <p class="mono-label">Install</p>
      <h2>Get Clipwell on your menu bar</h2>
      <p>Download the latest build, grant Screen Recording once, then record.</p>
    </div>
    <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/releases/latest">Download for macOS</a>
  </div>
</section>

<style>
  .cta {
    padding: 0 var(--page-gutter) var(--space-3xl);
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .cta__inner {
    display: grid;
    gap: var(--space-lg);
    padding: var(--space-xl);
    background: var(--color-paper-2);
    align-items: start;
  }

  h2 {
    font-size: var(--text-4xl);
    font-weight: 600;
    margin: var(--space-xs) 0 var(--space-sm);
  }

  p {
    margin: 0;
    max-width: 40ch;
    color: var(--color-ink-2);
  }

  @media (min-width: 40rem) {
    .cta__inner {
      grid-template-columns: minmax(0, 1fr) auto;
      align-items: center;
    }
  }
</style>
