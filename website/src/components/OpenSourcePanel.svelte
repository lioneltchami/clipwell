<script lang="ts">
  const grants = [
    'Use the software for any purpose, including commercial work.',
    'Modify the source, fork it, redistribute your changes.',
    'Bundle it with your own application, sublicense it, sell it.',
    'Inspect the build pipeline — every release is reproducible from the public repo.'
  ];

  const conditions = [
    'The MIT permission notice and copyright line must ship with any redistribution.',
    'The notice survives renaming, repackaging, and bundling — including commercial bundles.'
  ];

  const attribution = {
    derived: 'Clipwell',
    predecessor: 'BetterCapture',
    author: 'Joshua Sattler',
    copyright: 'Copyright (c) 2026 Joshua Sattler',
    license: 'MIT',
    repo: 'https://github.com/lioneltchami/clipwell',
    notice: 'NOTICE.md',
    licenseFile: 'LICENSE'
  };
</script>

<section class="oss" aria-labelledby="oss-title">
  <div class="oss__inner">
    <header class="oss__head">
      <p class="mono-label">License · 1 of 3</p>
      <h2 id="oss-title">MIT. Free. With the rights spelled out.</h2>
      <p class="oss__lede">
        Clipwell is MIT-licensed source code. The license grants broad rights to anyone who receives a copy.
        Three lists — what you may do, what you must preserve, and where the work came from.
      </p>
    </header>

    <div class="oss__columns">
      <article class="oss__panel frame">
        <h3>Granted</h3>
        <ul class="oss__list">
          {#each grants as line}
            <li>{line}</li>
          {/each}
        </ul>
      </article>

      <article class="oss__panel frame">
        <h3>Required</h3>
        <ul class="oss__list">
          {#each conditions as line}
            <li>{line}</li>
          {/each}
        </ul>
      </article>
    </div>

    <article class="oss__panel frame oss__attribution" aria-labelledby="attr-title">
      <h3 id="attr-title">Attribution</h3>
      <dl>
        <div>
          <dt>Derived work</dt>
          <dd>{attribution.derived}</dd>
        </div>
        <div>
          <dt>Predecessor</dt>
          <dd>{attribution.predecessor}</dd>
        </div>
        <div>
          <dt>Original author</dt>
          <dd>{attribution.author}</dd>
        </div>
        <div>
          <dt>Copyright</dt>
          <dd>{attribution.copyright}</dd>
        </div>
        <div>
          <dt>License</dt>
          <dd>{attribution.license}</dd>
        </div>
        <div>
          <dt>Repository</dt>
          <dd>
            <a href={attribution.repo}>{attribution.repo}</a>
          </dd>
        </div>
        <div>
          <dt>Notice & license</dt>
          <dd>
            <a href={`${attribution.repo}/blob/main/${attribution.notice}`}>{attribution.notice}</a> ·
            <a href={`${attribution.repo}/blob/main/${attribution.licenseFile}`}>{attribution.licenseFile}</a>
          </dd>
        </div>
      </dl>
      <p class="oss__note">
        The notice provides attribution context only and does not change the terms of the MIT License.
      </p>
    </article>
  </div>
</section>

<style>
  .oss {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .oss__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .oss__head {
    margin-bottom: var(--space-2xl);
  }

  .oss__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .oss__lede {
    max-width: 56ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .oss__columns {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
    margin-bottom: var(--space-lg);
  }

  .oss__panel {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-md);
  }

  .oss__panel h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .oss__list {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: var(--space-sm);
  }

  .oss__list li {
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
    padding-left: 1.4rem;
    position: relative;
  }

  .oss__list li::before {
    content: '—';
    position: absolute;
    left: 0;
    color: var(--color-accent);
    font-family: var(--font-mono);
  }

  .oss__attribution dl {
    margin: 0;
    display: grid;
    gap: 0;
  }

  .oss__attribution dl div {
    display: grid;
    grid-template-columns: minmax(0, 0.4fr) minmax(0, 1fr);
    gap: var(--space-md);
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .oss__attribution dl div:last-child {
    border-bottom: 0;
  }

  .oss__attribution dt {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .oss__attribution dd {
    margin: 0;
    color: var(--color-ink);
    font-size: var(--text-sm);
  }

  .oss__attribution dd a {
    color: var(--color-accent);
    text-decoration: underline;
    text-underline-offset: 2px;
  }

  .oss__note {
    margin: 0;
    padding-top: var(--space-sm);
    border-top: var(--rule-hair) solid var(--color-rule);
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    line-height: 1.55;
  }

  @media (min-width: 60rem) {
    .oss__columns {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }

    .oss__attribution dl {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }

    .oss__attribution dl div {
      grid-template-columns: minmax(0, 0.4fr) minmax(0, 1fr);
    }
  }
</style>