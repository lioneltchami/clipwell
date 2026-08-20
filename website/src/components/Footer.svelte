<script lang="ts">
  let { base = '/' }: { base?: string } = $props();
  const home = base.endsWith('/') ? base : `${base}/`;
</script>

<footer class="foot">
  <p class="line">Record locally. Ship the clip. Keep the rest private.</p>
  <div class="meta">
    <span class="wordmark">Clipwell</span>
    <nav aria-label="Footer">
      <a href="https://github.com/lioneltchami/clipwell">GitHub</a>
      <a href={`${home}privacy-policy`}>Privacy</a>
      <a href="https://github.com/lioneltchami/clipwell/releases/latest">Download</a>
    </nav>
    <span class="copy">© 2026 · MIT</span>
  </div>
</footer>

<style>
  .foot {
    padding: var(--space-3xl) var(--page-gutter) var(--space-xl);
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .line {
    font-family: var(--font-display);
    font-size: clamp(1.75rem, 4.5vw, 3rem);
    font-weight: 600;
    letter-spacing: -0.03em;
    line-height: 1.05;
    color: var(--color-ink);
    max-width: 18ch;
    margin: 0 0 var(--space-xl);
  }

  .meta {
    display: grid;
    gap: var(--space-md);
    padding-top: var(--space-lg);
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  .wordmark {
    font-family: var(--font-display);
    font-weight: 600;
    color: var(--color-ink);
  }

  nav {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-md);
  }

  nav a {
    font-size: var(--text-sm);
    color: var(--color-ink-2);
  }

  nav a:hover {
    color: var(--color-accent);
  }

  .copy {
    font-size: var(--text-xs);
    color: var(--color-ink-3);
  }

  @media (min-width: 40rem) {
    .meta {
      grid-template-columns: auto 1fr auto;
      align-items: baseline;
    }

    nav {
      justify-content: center;
    }
  }
</style>
