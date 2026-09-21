<script lang="ts">
  const points = [
    {
      title: 'MIT stays the default.',
      body: 'v1.0.0, v1.0.1, and v1.1.0 are MIT-era baselines. They are free, public, and signed from the public GitHub Release.'
    },
    {
      title: 'Commercial offers are separate artifacts.',
      body: 'If a commercial offer ships later, it is a separate build, a separate SHA-256, and a separate distribution channel. It does not revoke or replace MIT rights already granted.'
    },
    {
      title: 'Recording Presets live in the MIT branch.',
      body: 'The Recording Presets feature remains MIT-covered source code, distributed alongside every free build. Commercial exclusives, when any exist, are not MIT-covered material.'
    },
    {
      title: 'Counsel before commerce.',
      body: 'Terms of sale, seller disclosures, consumer rights, and tax treatment are not settled in code. Qualified counsel must approve before any commercial offer goes live.'
    }
  ];
</script>

<section class="comm" aria-labelledby="comm-title">
  <div class="comm__inner">
    <header class="comm__head">
      <p class="mono-label">License · 3 of 3</p>
      <h2 id="comm-title">Commercial framework (future work, not yet operative)</h2>
      <p class="comm__lede">
        Draft terms for future original commercial materials and services. Not a current offering.
      </p>
    </header>

    <div class="comm__grid">
      {#each points as point}
        <article class="comm__card frame">
          <h3>{point.title}</h3>
          <p>{point.body}</p>
        </article>
      {/each}
    </div>

    <p class="comm__foot">
      The non-operative commercial framework is preserved in
      <a href="https://github.com/lioneltchami/clipwell/blob/main/COMMERCIAL_LICENSE.md">COMMERCIAL_LICENSE.md</a>.
      The Stripe checkout readiness checklist lives at
      <a href="https://github.com/lioneltchami/clipwell/blob/main/docs/STRIPE_CHECKOUT.md">docs/STRIPE_CHECKOUT.md</a>.
      Neither is the v1.1.0 delivery path.
    </p>
  </div>
</section>

<style>
  .comm {
    padding: var(--space-2xl) var(--page-gutter) var(--space-4xl);
  }

  .comm__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .comm__head {
    margin-bottom: var(--space-2xl);
  }

  .comm__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
    max-width: 24ch;
  }

  .comm__lede {
    max-width: 56ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .comm__grid {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .comm__card {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-sm);
  }

  .comm__card h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .comm__card p {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.6;
  }

  .comm__foot {
    margin-top: var(--space-2xl);
    color: var(--color-ink-3);
    font-size: var(--text-sm);
    line-height: 1.6;
  }

  .comm__foot a {
    color: var(--color-accent);
    text-decoration: underline;
    text-underline-offset: 2px;
  }

  @media (min-width: 60rem) {
    .comm__grid {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }
</style>