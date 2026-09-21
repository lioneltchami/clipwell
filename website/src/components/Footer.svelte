<script lang="ts">
  let { base = '/' }: { base?: string } = $props();
  const home = base.endsWith('/') ? base : `${base}/`;

  const groups = [
    {
      label: 'Product',
      links: [
        { label: 'Features', href: `${home}features` },
        { label: 'Use cases', href: `${home}use-cases` },
        { label: 'Install', href: `${home}install` },
        { label: 'Changelog', href: `${home}changelog` }
      ]
    },
    {
      label: 'Project',
      links: [
        { label: 'Open source', href: `${home}open-source` },
        { label: 'Privacy', href: `${home}privacy-policy` },
        { label: 'Source', href: 'https://github.com/lioneltchami/clipwell' },
        { label: 'Release', href: 'https://github.com/lioneltchami/clipwell/releases/latest' }
      ]
    }
  ];
</script>

<footer class="foot">
  <div class="foot__line">
    <span class="foot__brand">Clipwell</span>
    {#each groups as group}
      <nav aria-label={`Footer navigation · ${group.label}`}>
        <span class="foot__group-label">{group.label}</span>
        {#each group.links as link}
          <a href={link.href}>{link.label}</a>
        {/each}
      </nav>
    {/each}
    <span class="foot__meta">© 2026 · MIT licensed</span>
  </div>
</footer>

<style>
  .foot {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: var(--space-xl) var(--page-gutter);
  }

  .foot__line {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-sm) var(--space-lg);
    align-items: center;
    padding-top: var(--space-lg);
    border-top: var(--rule-hair) solid var(--color-rule);
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
  }

  .foot__brand {
    color: var(--color-ink);
    font-family: var(--font-display);
    font-size: var(--text-sm);
    font-weight: 700;
  }

  nav {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: var(--space-md);
  }

  nav a {
    white-space: nowrap;
  }

  nav a:hover {
    color: var(--color-accent);
  }

  .foot__group-label {
    color: var(--color-ink-3);
    margin-right: var(--space-2xs);
  }

  .foot__meta {
    margin-inline-start: auto;
  }

  @media (max-width: 60rem) {
    .foot__meta {
      width: 100%;
      margin-inline-start: 0;
    }
  }
</style>