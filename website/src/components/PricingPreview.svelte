<section id="pricing" class="pricing" aria-labelledby="pricing-title">
  <div class="pricing__head reveal">
    <p class="mono-label">Open source</p>
    <h2 id="pricing-title">MIT licensed. No paid plan today.</h2>
    <p>
      Clipwell is distributed as an open-source core under the MIT license. The current public release is free to download, sign, and audit. Commercial plans are not offered today.
    </p>
  </div>

  <div class="pricing__grid">
    <article class="pricing__card pricing__card--solo frame reveal">
      <p class="mono-label">Current</p>
      <h3>Open-source core</h3>
      <p class="pricing__price">Free · MIT</p>
      <p>
        Build from source or download the public release. Keep the local-first recording workflow, Sparkle auto-updates, and the rights granted by the MIT license.
      </p>
      <ul>
        <li>Public macOS download</li>
        <li>Local files and no account</li>
        <li>Upstream MIT notices preserved</li>
      </ul>
      <div class="pricing__actions">
        <a class="btn-ghost" href="https://github.com/lioneltchami/clipwell/blob/main/LICENSE">Read the license →</a>
        <a class="btn-ghost" href="https://github.com/lioneltchami/clipwell/releases/latest">Inspect release →</a>
      </div>
    </article>
  </div>

  <p class="pricing__fine reveal">
    No paid plan, price, entitlement, or commercial support commitment is offered for the v1.1.0 release. See the repository for source, license, and release artifacts.
  </p>
</section>

<style>
  .pricing {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: var(--space-3xl) var(--page-gutter);
  }

  .pricing__head {
    display: grid;
    gap: var(--space-sm);
    max-width: 52rem;
    margin-bottom: var(--space-xl);
  }

  .pricing__head h2,
  .pricing__card h3 {
    margin: 0;
    font-size: var(--text-display-s);
    font-weight: 650;
  }

  .pricing__head > p:last-child {
    margin: 0;
    color: var(--color-ink-2);
  }

  .pricing__grid {
    display: grid;
    gap: var(--space-lg);
  }

  .pricing__card {
    display: grid;
    align-content: start;
    gap: var(--space-md);
    padding: var(--space-xl);
    background: var(--color-paper-2);
  }

  .pricing__card--solo {
    background:
      radial-gradient(110% 100% at 100% 0%, var(--color-grain-a), transparent 58%),
      var(--color-paper-2);
    border-color: color-mix(in oklch, var(--color-accent) 56%, var(--color-rule));
    max-width: 48rem;
  }

  .pricing__card p,
  .pricing__card h3 {
    margin: 0;
  }

  .pricing__card > p:not(.mono-label):not(.pricing__price) {
    color: var(--color-ink-2);
  }

  .pricing__price {
    color: var(--color-accent);
    font-family: var(--font-display);
    font-size: var(--text-4xl);
    font-weight: 650;
  }

  ul {
    display: grid;
    gap: var(--space-sm);
    margin: 0;
    padding: 0;
    list-style: none;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
  }

  li {
    display: grid;
    grid-template-columns: 1rem minmax(0, 1fr);
    gap: var(--space-sm);
  }

  li::before {
    content: '•';
    color: var(--color-accent);
  }

  .pricing__actions {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: var(--space-md);
    margin-top: auto;
  }

  .pricing__actions .btn-primary,
  .pricing__actions .btn-ghost {
    width: fit-content;
  }

  .pricing__fine {
    margin: var(--space-lg) 0 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    max-width: 72ch;
  }
</style>