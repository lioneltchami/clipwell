<script lang="ts">
  let { base = '/' }: { base?: string } = $props();
  let open = $state(false);
  let query = $state('');
  let active = $state(0);
  let inputEl: HTMLInputElement | undefined = $state();

  const home = base.endsWith('/') ? base : `${base}/`;
  const commands = $derived([
    { id: 'download', label: 'Download for macOS', href: 'https://github.com/lioneltchami/clipwell/releases/latest', hint: 'GitHub' },
    { id: 'demo', label: 'Inspect the product controls', href: '#demo', hint: 'Page' },
    { id: 'workflow', label: 'View the capture sequence', href: '#workflow', hint: 'Page' },
    { id: 'release', label: 'View the signed release', href: '#download', hint: 'Page' },
    { id: 'pricing', label: 'View commercial readiness', href: '#pricing', hint: 'Page' },
    { id: 'source', label: 'Inspect the source', href: 'https://github.com/lioneltchami/clipwell', hint: 'GitHub' },
    { id: 'privacy', label: 'Read the privacy policy', href: `${home}privacy-policy`, hint: 'Page' }
  ]);

  let filtered = $derived(commands.filter((command) => command.label.toLowerCase().includes(query.trim().toLowerCase())));

  function openPalette() {
    open = true;
    query = '';
    active = 0;
    queueMicrotask(() => inputEl?.focus());
  }

  function closePalette() {
    open = false;
  }

  function run(index = active) {
    const item = filtered[index];
    if (!item) return;
    closePalette();
    if (item.href.startsWith('#')) {
      document.querySelector(item.href)?.scrollIntoView({ behavior: 'smooth' });
    } else {
      window.location.href = item.href;
    }
  }

  function onKey(event: KeyboardEvent) {
    const command = event.metaKey || event.ctrlKey;
    if (command && event.key.toLowerCase() === 'k') {
      event.preventDefault();
      open ? closePalette() : openPalette();
      return;
    }
    if (!open) return;
    if (event.key === 'Escape') {
      event.preventDefault();
      closePalette();
    } else if (event.key === 'ArrowDown') {
      event.preventDefault();
      active = Math.min(active + 1, Math.max(filtered.length - 1, 0));
    } else if (event.key === 'ArrowUp') {
      event.preventDefault();
      active = Math.max(active - 1, 0);
    } else if (event.key === 'Enter') {
      event.preventDefault();
      run();
    }
  }

  $effect(() => {
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  });
</script>

<header class="nav" aria-label="Primary">
  <div class="nav__inner">
    <a class="nav__brand" href={home}>Clipwell</a>
    <nav class="nav__center" aria-label="Main navigation">
      <a href="#demo">Controls</a>
      <a href="#workflow">Workflow</a>
      <a href="#pricing">Commercial</a>
    </nav>
    <div class="nav__actions">
      <button type="button" class="nav__search" onclick={openPalette} aria-label="Search the Clipwell site">
        <span>Jump</span><kbd>⌘K</kbd>
      </button>
      <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/releases/latest">Download</a>
    </div>
  </div>
</header>

{#if open}
  <div class="palette" role="presentation" onclick={closePalette}>
    <div class="palette__panel" role="dialog" aria-modal="true" aria-label="Command palette" onclick={(event) => event.stopPropagation()}>
      <input
        bind:this={inputEl}
        class="palette__input"
        type="search"
        placeholder="Jump or download…"
        bind:value={query}
        oninput={() => (active = 0)}
      />
      <ul class="palette__list" role="listbox">
        {#each filtered as item, index}
          <li>
            <button
              type="button"
              class="palette__item"
              class:is-active={index === active}
              role="option"
              aria-selected={index === active}
              onclick={() => run(index)}
              onmouseenter={() => (active = index)}
            >
              <span>{item.label}</span><span class="hint">{item.hint}</span>
            </button>
          </li>
        {:else}
          <li class="palette__empty">No matches</li>
        {/each}
      </ul>
    </div>
  </div>
{/if}

<style>
  .nav {
    position: sticky;
    top: 0;
    z-index: 40;
    border-bottom: var(--rule-hair) solid var(--color-rule);
    background: var(--color-nav);
    backdrop-filter: blur(14px) saturate(120%);
  }

  .nav__inner {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: var(--space-md);
    align-items: center;
    max-width: var(--page-max);
    min-height: 4rem;
    margin: 0 auto;
    padding-inline: var(--page-gutter);
  }

  .nav__brand {
    color: var(--color-ink);
    font-family: var(--font-display);
    font-size: 1rem;
    font-weight: 700;
    letter-spacing: -0.04em;
  }

  .nav__center {
    display: none;
    gap: var(--space-lg);
  }

  .nav__center a {
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    white-space: nowrap;
  }

  .nav__center a:hover {
    color: var(--color-accent);
  }

  .nav__actions {
    display: flex;
    justify-self: end;
    gap: var(--space-xs);
    align-items: center;
    min-width: 0;
  }

  .nav__search {
    display: none;
    gap: var(--space-xs);
    align-items: center;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-sm);
    background: transparent;
    color: var(--color-ink-3);
    font: inherit;
    font-size: var(--text-xs);
    padding: 0.45rem 0.6rem;
    cursor: pointer;
  }

  .nav__search kbd {
    color: var(--color-ink-2);
    font-family: var(--font-mono);
    font-size: 0.65rem;
  }

  .palette {
    position: fixed;
    inset: 0;
    z-index: 50;
    display: grid;
    place-items: start center;
    padding: 12vh var(--page-gutter) var(--space-xl);
    background: var(--color-scrim);
  }

  .palette__panel {
    width: min(100%, 32rem);
    overflow: hidden;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-md);
    background: var(--color-paper-2);
    box-shadow: 0 18px 40px -24px var(--color-shadow);
  }

  .palette__input {
    width: 100%;
    border: 0;
    border-bottom: var(--rule-hair) solid var(--color-rule);
    padding: 0.9rem 1rem;
    background: transparent;
    color: var(--color-ink);
    font: inherit;
  }

  .palette__list {
    max-height: 16rem;
    margin: 0;
    padding: var(--space-xs);
    overflow: auto;
    list-style: none;
  }

  .palette__item {
    display: flex;
    width: 100%;
    justify-content: space-between;
    gap: var(--space-md);
    border: 0;
    border-radius: 12px;
    padding: 0.65rem 0.75rem;
    background: transparent;
    color: var(--color-ink);
    font: inherit;
    text-align: left;
    cursor: pointer;
  }

  .palette__item.is-active,
  .palette__item:hover {
    background: var(--color-paper-3);
  }

  .hint,
  .palette__empty {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
  }

  .palette__empty {
    padding: var(--space-md);
  }

  @media (min-width: 48rem) {
    .nav__inner {
      grid-template-columns: 1fr auto 1fr;
    }

    .nav__center,
    .nav__search {
      display: flex;
    }
  }
</style>
