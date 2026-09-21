<script lang="ts">
  const methods = [
    {
      id: 'dmg',
      title: 'Direct DMG',
      subtitle: 'Download the signed, notarized DMG from the GitHub Release.',
      command: 'open https://github.com/lioneltchami/clipwell/releases/latest',
      note: 'Drag Clipwell.app to /Applications. The DMG is Sparkle-signed; Clipwell prompts for an update the next time it runs.'
    },
    {
      id: 'brew',
      title: 'Homebrew cask',
      subtitle: 'Pin the tap once and brew install every future release.',
      command: 'brew tap lioneltchami/clipwell && brew install --cask clipwell',
      note: 'Same artifact, same SHA-256, same Sparkle signature — just a tap to manage the upgrade.'
    },
    {
      id: 'scheme',
      title: 'URL-scheme launch',
      subtitle: 'Drive the app from any launcher, terminal, or automation host.',
      command: 'open clipwell://toggle',
      note: 'The scheme is registered on first run. If the app is not installed, the request is a no-op and the launch host logs the miss.'
    }
  ];

  let copied: string | null = $state(null);

  async function copy(text: string) {
    try {
      await navigator.clipboard.writeText(text);
      copied = text;
      setTimeout(() => {
        if (copied === text) copied = null;
      }, 1500);
    } catch {
      copied = null;
    }
  }
</script>

<section class="install" aria-labelledby="install-title">
  <div class="install__inner">
    <header class="install__head">
      <p class="mono-label">Install · 1 of 3</p>
      <h2 id="install-title">Three ways to land Clipwell on the Mac.</h2>
      <p class="install__lede">Every method installs the same signed, notarized DMG. Pick the one that fits how you manage software.</p>
    </header>

    <div class="install__grid">
      {#each methods as method}
        <article class="install__card frame" id={method.id}>
          <header>
            <h3>{method.title}</h3>
            <button
              type="button"
              class="install__copy"
              onclick={() => copy(method.command)}
              aria-label={`Copy ${method.title} command`}
            >
              {copied === method.command ? 'Copied' : 'Copy'}
            </button>
          </header>
          <p class="install__subtitle">{method.subtitle}</p>
          <pre><code>{method.command}</code></pre>
          <p class="install__note">{method.note}</p>
        </article>
      {/each}
    </div>
  </div>
</section>

<style>
  .install {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .install__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .install__head {
    margin-bottom: var(--space-2xl);
  }

  .install__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .install__lede {
    max-width: 52ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .install__grid {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .install__card {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-md);
  }

  .install__card header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: var(--space-md);
  }

  .install__card h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-xl);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .install__copy {
    flex-shrink: 0;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-sm);
    background: var(--color-paper-3);
    color: var(--color-ink-2);
    font: inherit;
    font-size: var(--text-xs);
    font-weight: 600;
    padding: 0.35rem 0.7rem;
    cursor: pointer;
  }

  .install__subtitle {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.5;
  }

  .install__card pre {
    margin: 0;
    padding: var(--space-md);
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 10px;
    overflow-x: auto;
  }

  .install__card pre code {
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    color: var(--color-ink);
    white-space: pre;
  }

  .install__note {
    margin: 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    line-height: 1.55;
  }

  @media (min-width: 60rem) {
    .install__grid {
      grid-template-columns: repeat(3, minmax(0, 1fr));
    }
  }
</style>