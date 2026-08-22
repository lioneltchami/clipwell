<script lang="ts">
  let { base = '/' }: { base?: string } = $props();
  const home = base.endsWith('/') ? base : `${base}/`;
</script>

<footer class="foot">
  <div class="foot__line">
    <span class="foot__brand">Clipwell</span>
    <nav aria-label="Footer navigation">
      <a href="https://github.com/lioneltchami/clipwell">Source</a>
      <a href={`${home}privacy-policy`}>Privacy</a>
      <a href="https://github.com/lioneltchami/clipwell/releases/latest">Release</a>
    </nav>
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
    gap: var(--space-md);
  }

  nav a {
    white-space: nowrap;
  }

  nav a:hover {
    color: var(--color-accent);
  }

  .foot__meta {
    margin-inline-start: auto;
  }

  @media (max-width: 34rem) {
    .foot__meta {
      width: 100%;
      margin-inline-start: 0;
    }
  }
</style>
