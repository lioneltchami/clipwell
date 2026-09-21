<script lang="ts">
  /*
    Footer — design derived from Mobbin catalog anchors:

    - 2.1 Etsy account dropdown (header identity, icon+label rows, hairline separators,
          Activity / Commerce / System groups, Sign out last)
      https://mobbin.com/screens/0c6dce7f-4bea-44df-bccc-d516dc87221d
    - 2.4 Notion workspace switcher (dense utility dropdown, plan badge, Settings/Invite,
          Get Mac/iOS app links, then Help/Trash)
      https://mobbin.com/screens/a535975a-c988-47a1-89fd-a5bf46a0123a
    - 2.5 Laravel Cloud source-control overflow (Manage / Reauthorize / Disconnect;
          hazardous disconnect isolated at bottom)
      https://mobbin.com/screens/ec08f97b-89fa-4bfa-a6b1-100c4bb488ed
    - 2.6 Patreon collection overflow (safe actions first, then red Stop selling / Delete;
          separator + color discipline for destructive items)
      https://mobbin.com/screens/d990ccf7-6d4d-410a-bc7e-9924a65ff325
  */
  let { base = '/' }: { base?: string } = $props();
  const home = base.endsWith('/') ? base : `${base}/`;

  const groups = [
    {
      label: 'Product',
      primary: [
        { label: 'Features', href: `${home}features`, hint: 'Capture matrix, codec guide, shortcuts' },
        { label: 'Use cases', href: `${home}use-cases`, hint: 'Six common workflows' },
        { label: 'Install', href: `${home}install`, hint: 'DMG · Homebrew · URL scheme' }
      ],
      secondary: [{ label: 'Changelog', href: `${home}changelog`, hint: 'v1.1.0 · v1.0.1 · v1.0.0' }]
    },
    {
      label: 'Project',
      primary: [
        { label: 'Open source', href: `${home}open-source`, hint: 'MIT license, attribution' },
        { label: 'Source', href: 'https://github.com/lioneltchami/clipwell', hint: 'github.com/lioneltchami/clipwell' },
        { label: 'Release', href: 'https://github.com/lioneltchami/clipwell/releases/latest', hint: 'Latest signed DMG' }
      ],
      secondary: [
        { label: 'Issues', href: 'https://github.com/lioneltchami/clipwell/issues/new', hint: 'Bug report' },
        { label: 'Security', href: 'https://github.com/lioneltchami/clipwell/security/advisories/new', hint: 'Private advisory' }
      ]
    }
  ];
</script>

<footer class="foot">
  <div class="foot__inner">
    <div class="foot__columns">
      <section class="foot__brand frame" aria-labelledby="foot-brand">
        <p id="foot-brand" class="foot__wordmark">Clipwell</p>
        <p class="foot__tag">
          Menu-bar screen recorder for macOS. Local files only.
        </p>
        <p class="foot__meta">
          <span>v1.1.0</span>
          <span aria-hidden="true">·</span>
          <span>MIT</span>
          <span aria-hidden="true">·</span>
          <span>arm64</span>
        </p>
        <a class="foot__cta" href={`${home}install`}>
          Download for macOS
          <span aria-hidden="true">→</span>
        </a>
      </section>

      {#each groups as group}
        <section class="foot__group frame" aria-label={`Footer navigation · ${group.label}`}>
          <header class="foot__group-head">
            <h3>{group.label}</h3>
            <span class="foot__group-tag">{group.primary.length + group.secondary.length}</span>
          </header>

          <ul class="foot__list" role="list">
            {#each group.primary as link}
              <li>
                <a class="foot__row" href={link.href}>
                  <span class="foot__row-label">{link.label}</span>
                  <span class="foot__row-hint">{link.hint}</span>
                </a>
              </li>
            {/each}
          </ul>

          <div class="foot__divider" role="separator" aria-hidden="true"></div>

          <ul class="foot__list foot__list--secondary" role="list">
            {#each group.secondary as link}
              <li>
                <a class="foot__row foot__row--muted" href={link.href}>
                  <span class="foot__row-label">{link.label}</span>
                  <span class="foot__row-hint">{link.hint}</span>
                </a>
              </li>
            {/each}
          </ul>
        </section>
      {/each}

      <section class="foot__legal frame" aria-label="Footer navigation · Legal">
        <header class="foot__group-head">
          <h3>Legal</h3>
          <span class="foot__group-tag">2</span>
        </header>

        <ul class="foot__list" role="list">
          <li>
            <a class="foot__row" href={`${home}privacy-policy`}>
              <span class="foot__row-label">Privacy policy</span>
              <span class="foot__row-hint">No tracking, no telemetry</span>
            </a>
          </li>
        </ul>

        <div class="foot__divider" role="separator" aria-hidden="true"></div>

        <ul class="foot__list foot__list--destructive" role="list">
          <li>
            <a
              class="foot__row foot__row--destructive"
              href="https://github.com/lioneltchami/clipwell/security/advisories/new"
              rel="noopener"
            >
              <span class="foot__row-label">Report a security issue</span>
              <span class="foot__row-hint">Private disclosure only</span>
            </a>
          </li>
        </ul>
      </section>
    </div>

    <div class="foot__base">
      <span class="foot__base-left">© 2026 Lionel Tchami · MIT licensed</span>
      <span class="foot__base-right">
        Built with Astro, Svelte 5, and Tailwind 4 · Designed against Mobbin
      </span>
    </div>
  </div>
</footer>

<style>
  .foot {
    padding: var(--space-2xl) var(--page-gutter) var(--space-xl);
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  .foot__inner {
    max-width: var(--page-max);
    margin: 0 auto;
  }

  /* Mobbin 2.1 Etsy — column cards instead of inline nav. */
  .foot__columns {
    display: grid;
    gap: var(--space-md);
    grid-template-columns: 1fr;
  }

  .foot__brand,
  .foot__group,
  .foot__legal {
    padding: var(--space-xl);
    background: var(--color-paper-2);
    display: grid;
    gap: var(--space-md);
  }

  .foot__wordmark {
    margin: 0;
    color: var(--color-ink);
    font-family: var(--font-display);
    font-size: var(--text-xl);
    font-weight: 700;
    letter-spacing: -0.04em;
  }

  .foot__tag {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
    line-height: 1.55;
  }

  .foot__meta {
    display: flex;
    gap: var(--space-2xs);
    align-items: center;
    margin: 0;
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .foot__cta {
    display: inline-flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.6rem 0.85rem;
    background: var(--color-accent);
    color: var(--color-accent-ink);
    border-radius: var(--radius-sm);
    font-weight: 600;
    font-size: var(--text-sm);
    text-decoration: none;
    margin-top: var(--space-2xs);
  }

  .foot__cta:hover {
    background: var(--color-accent-hover);
  }

  /* Mobbin 2.4 Notion — labeled group with badge + secondary list */
  .foot__group-head {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    padding-bottom: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .foot__group-head h3 {
    margin: 0;
    color: var(--color-ink);
    font-family: var(--font-display);
    font-size: var(--text-base);
    letter-spacing: -0.02em;
  }

  .foot__group-tag {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    font-variant-numeric: tabular-nums;
  }

  .foot__list {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: 0;
  }

  .foot__row {
    display: grid;
    grid-template-columns: minmax(0, 0.7fr) minmax(0, 1fr);
    gap: var(--space-md);
    align-items: baseline;
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
    text-decoration: none;
  }

  .foot__list li:last-child .foot__row {
    border-bottom: 0;
  }

  .foot__row-label {
    color: var(--color-ink);
    font-size: var(--text-sm);
  }

  .foot__row-hint {
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    line-height: 1.45;
  }

  .foot__row--muted .foot__row-label {
    color: var(--color-ink-2);
  }

  .foot__divider {
    height: 1px;
    background: var(--color-rule);
    margin: var(--space-xs) 0;
  }

  /* Mobbin 2.5 Laravel Cloud + 2.6 Patreon — destructive isolation */
  .foot__list--destructive .foot__row--destructive .foot__row-label {
    color: #d8604a;
  }

  .foot__list--destructive .foot__row--destructive:hover .foot__row-label {
    color: #ef6e54;
  }

  .foot__base {
    display: grid;
    grid-template-columns: 1fr;
    gap: var(--space-xs);
    margin-top: var(--space-xl);
    padding-top: var(--space-lg);
    border-top: var(--rule-hair) solid var(--color-rule);
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
  }

  .foot__base-right {
    color: var(--color-ink-3);
  }

  @media (min-width: 48rem) {
    .foot__columns {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }

  @media (min-width: 75rem) {
    .foot__columns {
      grid-template-columns: minmax(0, 1.2fr) repeat(3, minmax(0, 1fr));
    }

    .foot__base {
      grid-template-columns: 1fr auto;
      align-items: baseline;
    }
  }
</style>