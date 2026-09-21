<script lang="ts">
  const actions = [
    {
      action: 'toggle',
      canonical: 'clipwell://toggle',
      legacy: ['bettercapture://toggle', 'captureforge://toggle'],
      description: 'Start recording if idle, stop and finalize if running.'
    },
    {
      action: 'toggle-copy',
      canonical: 'clipwell://toggle-copy',
      legacy: ['bettercapture://toggle-copy', 'captureforge://toggle-copy'],
      description: 'Toggle as above, and on stop place the saved file URL on the clipboard.'
    },
    {
      action: 'open-recordings',
      canonical: 'clipwell://open-recordings',
      legacy: ['bettercapture://open-recordings', 'captureforge://open-recordings'],
      description: 'Open the configured save folder in Finder.'
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

<section class="scheme" aria-labelledby="scheme-title">
  <div class="scheme__inner">
    <header class="scheme__head">
      <p class="mono-label">Reference · 4 of 4</p>
      <h2 id="scheme-title">URL-scheme automation</h2>
      <p class="scheme__lede">
        Three actions, three schemes. <code>clipwell://</code> is canonical; <code>bettercapture://</code> and
        <code>captureforge://</code> are kept alive for existing automations and remain valid for the same actions.
      </p>
    </header>

    <div class="scheme__grid">
      {#each actions as entry}
        <article class="scheme__card frame">
          <header>
            <span class="scheme__action">{entry.action}</span>
            <button
              type="button"
              class="scheme__copy"
              onclick={() => copy(entry.canonical)}
              aria-label={`Copy ${entry.canonical}`}
            >
              {copied === entry.canonical ? 'Copied' : 'Copy'}
            </button>
          </header>
          <code class="scheme__canonical">{entry.canonical}</code>
          <p>{entry.description}</p>
          <details>
            <summary>Compatibility bridges</summary>
            <ul>
              {#each entry.legacy as legacy}
                <li><code>{legacy}</code></li>
              {/each}
            </ul>
          </details>
        </article>
      {/each}
    </div>

    <p class="scheme__foot">
      Wire one of these into a launcher, a CI runner, or a personal automation. The schema follows the project
      history recorded in <a href="https://github.com/lioneltchami/clipwell/blob/main/docs/MIGRATION_TO_CLIPWELL.md">MIGRATION_TO_CLIPWELL.md</a>.
    </p>
  </div>
</section>

<style>
  .scheme {
    padding: var(--space-2xl) var(--page-gutter) var(--space-4xl);
  }

  .scheme__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .scheme__head {
    margin-bottom: var(--space-2xl);
  }

  .scheme__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .scheme__lede {
    max-width: 52ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .scheme__lede code {
    font-family: var(--font-mono);
    font-size: 0.85em;
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 6px;
    padding: 0.1rem 0.35rem;
  }

  .scheme__grid {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .scheme__card {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-sm);
  }

  .scheme__card header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: var(--space-md);
  }

  .scheme__action {
    color: var(--color-accent);
    font-family: var(--font-mono);
    font-size: var(--text-sm);
  }

  .scheme__copy {
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

  .scheme__canonical {
    display: block;
    margin: 0;
    padding: var(--space-sm) var(--space-md);
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: 10px;
    color: var(--color-ink);
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    word-break: break-all;
  }

  .scheme__card p {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  .scheme__card details {
    border-top: var(--rule-hair) solid var(--color-rule);
    padding-top: var(--space-sm);
  }

  .scheme__card details summary {
    cursor: pointer;
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .scheme__card details ul {
    list-style: none;
    margin: var(--space-sm) 0 0;
    padding: 0;
    display: grid;
    gap: var(--space-2xs);
  }

  .scheme__card details code {
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    color: var(--color-ink-2);
  }

  .scheme__foot {
    margin-top: var(--space-2xl);
    color: var(--color-ink-3);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  .scheme__foot a {
    color: var(--color-accent);
    text-decoration: underline;
    text-underline-offset: 2px;
  }

  @media (min-width: 60rem) {
    .scheme__grid {
      grid-template-columns: repeat(3, minmax(0, 1fr));
    }
  }
</style>