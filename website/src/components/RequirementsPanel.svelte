<script lang="ts">
  const requirements = [
    {
      label: 'macOS',
      value: '15.2 Sequoia or later'
    },
    {
      label: 'Architecture',
      value: 'Apple silicon (arm64)'
    },
    {
      label: 'Disk',
      value: '~3.6 MB DMG · recordings live wherever you point them'
    },
    {
      label: 'Network',
      value: 'Not required. Clipwell does not phone home.'
    }
  ];

  const permissions = [
    {
      name: 'Screen Recording',
      why: 'ScreenCaptureKit requires it. macOS prompts the first time you start a record.'
    },
    {
      name: 'Microphone',
      why: 'Needed only if you route mic audio. The picker respects the macOS system toggle.'
    },
    {
      name: 'Camera',
      why: 'Needed only if you turn on the picture-in-picture overlay.'
    }
  ];
</script>

<section class="req" aria-labelledby="req-title">
  <div class="req__inner">
    <header class="req__head">
      <p class="mono-label">Install · 2 of 3</p>
      <h2 id="req-title">Requirements & permissions</h2>
      <p class="req__lede">The minimum macOS version ScreenCaptureKit needs to honor the full surface.</p>
    </header>

    <div class="req__columns">
      <article class="req__panel frame">
        <h3>System requirements</h3>
        <dl>
          {#each requirements as row}
            <div>
              <dt>{row.label}</dt>
              <dd>{row.value}</dd>
            </div>
          {/each}
        </dl>
      </article>

      <article class="req__panel frame">
        <h3>macOS permissions</h3>
        <ul>
          {#each permissions as perm}
            <li>
              <strong>{perm.name}</strong>
              <span>{perm.why}</span>
            </li>
          {/each}
        </ul>
        <p class="req__hint">
          Permissions are managed by macOS, not by Clipwell. Revoke or re-grant them at any time under
          <em>System Settings → Privacy & Security</em>.
        </p>
      </article>
    </div>
  </div>
</section>

<style>
  .req {
    padding: var(--space-2xl) var(--page-gutter) var(--space-3xl);
  }

  .req__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .req__head {
    margin-bottom: var(--space-2xl);
  }

  .req__head h2 {
    margin: var(--space-sm) 0 var(--space-md);
    font-size: var(--text-display-s);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .req__lede {
    max-width: 48ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .req__columns {
    display: grid;
    gap: var(--space-lg);
    grid-template-columns: 1fr;
  }

  .req__panel {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-md);
  }

  .req__panel h3 {
    margin: 0;
    font-family: var(--font-display);
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    color: var(--color-ink);
  }

  .req__panel dl {
    margin: 0;
    display: grid;
    gap: 0;
  }

  .req__panel dl div {
    display: grid;
    grid-template-columns: minmax(0, 0.45fr) minmax(0, 1fr);
    gap: var(--space-md);
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .req__panel dl div:last-child {
    border-bottom: 0;
  }

  dt {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  dd {
    margin: 0;
    color: var(--color-ink);
    font-size: var(--text-sm);
  }

  .req__panel ul {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: var(--space-md);
  }

  .req__panel li {
    display: grid;
    gap: var(--space-2xs);
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .req__panel li:last-child {
    border-bottom: 0;
  }

  .req__panel li strong {
    color: var(--color-ink);
    font-size: var(--text-sm);
    font-weight: 600;
  }

  .req__panel li span {
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.5;
  }

  .req__hint {
    margin: 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    line-height: 1.55;
    padding-top: var(--space-sm);
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  @media (min-width: 60rem) {
    .req__columns {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }
</style>