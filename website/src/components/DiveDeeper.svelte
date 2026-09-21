<script lang="ts">
  let { base = '/' }: { base?: string } = $props();
  const home = base.endsWith('/') ? base : `${base}/`;

  const cards = [
    {
      label: 'Reference',
      title: 'Features',
      summary: 'Every capture source, every codec, every shortcut.',
      href: `${home}features`
    },
    {
      label: 'Install',
      title: 'Install',
      summary: 'DMG, Homebrew, URL scheme. Plus permissions and verification.',
      href: `${home}install`
    },
    {
      label: 'Use cases',
      title: 'Use cases',
      summary: 'Six common workflows, each with a recommended codec.',
      href: `${home}use-cases`
    },
    {
      label: 'Open source',
      title: 'Open source',
      summary: 'MIT license, attribution history, contribution channels.',
      href: `${home}open-source`
    },
    {
      label: 'Releases',
      title: 'Changelog',
      summary: 'What shipped, what changed, what is next.',
      href: `${home}changelog`
    }
  ];
</script>

<section class="deep" aria-labelledby="deep-title">
  <div class="deep__inner">
    <header class="deep__head">
      <p class="mono-label">Dive deeper</p>
      <h2 id="deep-title">The rest of the site.</h2>
      <p class="deep__lede">Five pages. Each one a focused reference, not a feature blurb.</p>
    </header>

    <ul class="deep__grid" role="list">
      {#each cards as card}
        <li>
          <a class="deep__card frame" href={card.href}>
            <span class="deep__label">{card.label}</span>
            <h3>{card.title}</h3>
            <p>{card.summary}</p>
            <span class="deep__arrow" aria-hidden="true">→</span>
          </a>
        </li>
      {/each}
    </ul>
  </div>
</section>

<style>
  .deep {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .deep__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .deep__head {
    margin-bottom: var(--space-2xl);
  }

  .deep__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .deep__lede {
    max-width: 48ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .deep__grid {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: var(--space-md);
    grid-template-columns: 1fr;
  }

  .deep__card {
    display: grid;
    gap: var(--space-2xs);
    padding: var(--space-xl);
    background: var(--color-paper-2);
    text-decoration: none;
    color: inherit;
    transition: background var(--dur-fast) var(--ease-out);
    position: relative;
  }

  .deep__card:hover {
    background: var(--color-paper-3);
  }

  .deep__card:hover .deep__arrow {
    color: var(--color-accent);
    transform: translateX(0.15rem);
  }

  .deep__label {
    color: var(--color-accent);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .deep__card h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-xl);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .deep__card p {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  .deep__arrow {
    position: absolute;
    top: var(--space-xl);
    right: var(--space-xl);
    color: var(--color-ink-3);
    font-family: var(--font-display);
    font-size: var(--text-lg);
    transition: color var(--dur-fast) var(--ease-out), transform var(--dur-fast) var(--ease-out);
  }

  @media (min-width: 48rem) {
    .deep__grid {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }

  @media (min-width: 75rem) {
    .deep__grid {
      grid-template-columns: repeat(5, minmax(0, 1fr));
    }

    .deep__card {
      padding: var(--space-lg);
    }

    .deep__arrow {
      position: static;
      justify-self: end;
    }
  }
</style>