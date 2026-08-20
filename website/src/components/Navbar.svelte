<script lang="ts">
  let open = $state(false);
  let query = $state('');
  let active = $state(0);
  let inputEl: HTMLInputElement | undefined = $state();

  const commands = [
    { id: 'download', label: 'Download for macOS', href: 'https://github.com/lioneltchami/clipwell/releases/latest', hint: 'GitHub' },
    { id: 'features', label: 'Jump to features', href: '#workbench', hint: 'Page' },
    { id: 'faq', label: 'Jump to FAQ', href: '#faq', hint: 'Page' },
    { id: 'source', label: 'View source', href: 'https://github.com/lioneltchami/clipwell', hint: 'GitHub' },
    { id: 'privacy', label: 'Privacy policy', href: '/privacy-policy', hint: 'Page' }
  ];

  let filtered = $derived(
    commands.filter((c) => c.label.toLowerCase().includes(query.trim().toLowerCase()))
  );

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

  function onKey(e: KeyboardEvent) {
    const meta = e.metaKey || e.ctrlKey;
    if (meta && e.key.toLowerCase() === 'k') {
      e.preventDefault();
      open ? closePalette() : openPalette();
      return;
    }
    if (!open) return;
    if (e.key === 'Escape') {
      e.preventDefault();
      closePalette();
    } else if (e.key === 'ArrowDown') {
      e.preventDefault();
      active = Math.min(active + 1, Math.max(filtered.length - 1, 0));
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      active = Math.max(active - 1, 0);
    } else if (e.key === 'Enter') {
      e.preventDefault();
      run();
    }
  }

  $effect(() => {
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  });
</script>

<header class="nav">
  <div class="nav__inner">
    <a class="wordmark" href="/">Clipwell</a>
    <nav class="nav__links" aria-label="Primary">
      <a href="#workbench">Workbench</a>
      <a href="#spec">Spec</a>
      <a href="#faq">FAQ</a>
    </nav>
    <div class="nav__actions">
      <button type="button" class="cmdk" onclick={openPalette} aria-label="Open command palette">
        <span>Search</span>
        <kbd>⌘K</kbd>
      </button>
      <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/releases/latest">Download</a>
    </div>
  </div>
</header>

{#if open}
  <div class="palette" role="presentation" onclick={closePalette}>
    <div
      class="palette__panel"
      role="dialog"
      aria-modal="true"
      aria-label="Command palette"
      onclick={(e) => e.stopPropagation()}
    >
      <input
        bind:this={inputEl}
        class="palette__input"
        type="search"
        placeholder="Jump or download…"
        bind:value={query}
        oninput={() => (active = 0)}
      />
      <ul class="palette__list" role="listbox">
        {#each filtered as item, i}
          <li>
            <button
              type="button"
              class="palette__item"
              class:is-active={i === active}
              role="option"
              aria-selected={i === active}
              onclick={() => run(i)}
              onmouseenter={() => (active = i)}
            >
              <span>{item.label}</span>
              <span class="hint">{item.hint}</span>
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
    background: color-mix(in oklch, var(--color-paper) 88%, transparent);
    backdrop-filter: blur(12px) saturate(120%);
  }

  .nav__inner {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: 0.75rem var(--page-gutter);
    display: flex;
    align-items: center;
    gap: var(--space-md);
    min-width: 0;
  }

  .wordmark {
    font-family: var(--font-display);
    font-weight: 600;
    font-size: 1.05rem;
    letter-spacing: -0.03em;
    color: var(--color-ink);
    flex-shrink: 0;
  }

  .nav__links {
    display: none;
    gap: var(--space-lg);
    margin-inline-start: var(--space-sm);
  }

  .nav__links a {
    font-size: var(--text-sm);
    color: var(--color-ink-2);
  }

  .nav__links a:hover {
    color: var(--color-accent);
  }

  .nav__actions {
    margin-inline-start: auto;
    display: flex;
    align-items: center;
    gap: var(--space-sm);
    min-width: 0;
  }

  .cmdk {
    display: none;
    align-items: center;
    gap: var(--space-md);
    padding: 0.4rem 0.65rem;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-sm);
    background: var(--color-paper);
    color: var(--color-ink-3);
    font-size: var(--text-sm);
    cursor: pointer;
  }

  .cmdk kbd {
    font-family: var(--font-mono);
    font-size: 0.7rem;
    padding: 0.1rem 0.35rem;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 4px;
  }

  .palette {
    position: fixed;
    inset: 0;
    z-index: 50;
    background: oklch(20% 0.02 258 / 0.35);
    display: grid;
    place-items: start center;
    padding: 12vh var(--page-gutter) var(--space-xl);
  }

  .palette__panel {
    width: min(100%, 32rem);
    background: var(--color-paper);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-md);
    overflow: hidden;
    box-shadow: 0 1px 2px oklch(0% 0 0 / 0.06);
  }

  .palette__input {
    width: 100%;
    border: 0;
    border-bottom: var(--rule-hair) solid var(--color-rule);
    padding: 0.9rem 1rem;
    font: inherit;
    background: transparent;
    color: var(--color-ink);
  }

  .palette__list {
    list-style: none;
    margin: 0;
    padding: var(--space-xs);
    max-height: 16rem;
    overflow: auto;
  }

  .palette__item {
    width: 100%;
    display: flex;
    justify-content: space-between;
    gap: var(--space-md);
    text-align: left;
    padding: 0.65rem 0.75rem;
    border: 0;
    border-radius: var(--radius-sm);
    background: transparent;
    color: var(--color-ink);
    font: inherit;
    cursor: pointer;
  }

  .palette__item.is-active,
  .palette__item:hover {
    background: var(--color-paper-2);
  }

  .hint,
  .palette__empty {
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    color: var(--color-ink-3);
  }

  .palette__empty {
    padding: var(--space-md);
  }

  @media (min-width: 40rem) {
    .nav__links {
      display: flex;
    }
    .cmdk {
      display: inline-flex;
    }
  }
</style>
