<script lang="ts">
  const channels = [
    {
      channel: 'Bug reports',
      destination: 'github.com/lioneltchami/clipwell/issues/new',
      what: 'Repro steps, expected vs actual, macOS version, Clipwell version. Screenshots are appreciated; screen recordings are better.'
    },
    {
      channel: 'Pull requests',
      destination: 'github.com/lioneltchami/clipwell/pulls',
      what: 'Open a PR against main. Match the SwiftLint rules in the project. New tests for new behavior.'
    },
    {
      channel: 'Security disclosures',
      destination: 'Open a private security advisory on GitHub',
      what: 'For issues in the recording pipeline or the URL-scheme surface, do not file a public issue. Use GitHub Security Advisories.'
    },
    {
      channel: 'Documentation',
      destination: 'github.com/lioneltchami/clipwell/tree/main/docs',
      what: 'Clipwell ships docs/ alongside the source. Fixes to typos, smoke-test additions, and architecture diagrams are all welcome.'
    }
  ];
</script>

<section class="contrib" aria-labelledby="contrib-title">
  <div class="contrib__inner">
    <header class="contrib__head">
      <p class="mono-label">License · 2 of 3</p>
      <h2 id="contrib-title">How to contribute</h2>
      <p class="contrib__lede">
        The repository is the issue tracker, the design surface, and the build record. There is no private
        bug inbox.
      </p>
    </header>

    <div class="contrib__grid">
      {#each channels as item}
        <article class="contrib__card frame">
          <h3>{item.channel}</h3>
          <p class="contrib__where">{item.destination}</p>
          <p>{item.what}</p>
        </article>
      {/each}
    </div>
  </div>
</section>

<style>
  .contrib {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .contrib__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .contrib__head {
    margin-bottom: var(--space-2xl);
  }

  .contrib__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .contrib__lede {
    max-width: 52ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .contrib__grid {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .contrib__card {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-sm);
  }

  .contrib__card h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .contrib__where {
    margin: 0;
    color: var(--color-accent);
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    word-break: break-word;
  }

  .contrib__card p:last-child {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  @media (min-width: 60rem) {
    .contrib__grid {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }
</style>