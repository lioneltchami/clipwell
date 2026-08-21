<section id="pricing" class="pricing" aria-labelledby="pricing-title">
  <div class="pricing__head reveal">
    <p class="mono-label">Commercial readiness</p>
    <h2 id="pricing-title">Keep the core open. Price the value you add.</h2>
    <p>
      The current Clipwell release remains available under the MIT license. Commercial plans are being drafted for customers who need procurement, support, and additional services beyond the open-source core.
    </p>
  </div>

  <div class="pricing__grid">
    <article class="pricing__card frame reveal">
      <p class="mono-label">Current</p>
      <h3>Open source</h3>
      <p class="pricing__price">MIT</p>
      <p>Build from source or download the public release. Keep the local-first recording workflow and the rights granted by the MIT license.</p>
      <ul>
        <li>Public macOS release</li>
        <li>Local files and no account</li>
        <li>Upstream MIT notices preserved</li>
      </ul>
      <a class="btn-ghost" href="https://github.com/lioneltchami/clipwell/blob/main/LICENSE">Read the license →</a>
    </article>

    <article class="pricing__card pricing__card--featured frame reveal">
      <p class="mono-label">Planned</p>
      <h3>Commercial support</h3>
      <p class="pricing__price">To be announced</p>
      <p>For teams that need a commercial agreement, response commitments, and managed deployment or support terms.</p>
      <ul>
        <li>Commercial agreement draft</li>
        <li>Support and procurement options</li>
        <li>Clear coexistence with MIT components</li>
      </ul>
      <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/blob/main/docs/COMMERCIALIZATION.md">Review the draft</a>
    </article>
  </div>

  <p class="pricing__fine reveal">
    No paid plan, price, entitlement, refund policy, or commercial support commitment is live yet. Those details must be set before any purchase CTA replaces this draft.
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

  .pricing__card--featured {
    background:
      radial-gradient(110% 100% at 100% 0%, var(--color-grain-a), transparent 58%),
      var(--color-paper-2);
    border-color: color-mix(in oklch, var(--color-accent) 56%, var(--color-rule));
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

  .pricing__card .btn-primary,
  .pricing__card .btn-ghost {
    width: fit-content;
    margin-top: auto;
  }

  .pricing__fine {
    margin: var(--space-lg) 0 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    max-width: 72ch;
  }

  @media (min-width: 48rem) {
    .pricing__grid {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }
</style>
