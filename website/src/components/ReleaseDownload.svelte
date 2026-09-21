<script lang="ts">
  import { onMount } from 'svelte';

  type ReleaseAsset = {
    name: string;
    browser_download_url: string;
    size: number;
  };

  type GitHubRelease = {
    tag_name: string;
    html_url: string;
    published_at: string | null;
    assets: ReleaseAsset[];
  };

  const fallbackRelease: GitHubRelease = {
    tag_name: 'v1.1.0',
    html_url: 'https://github.com/lioneltchami/clipwell/releases/tag/v1.1.0',
    published_at: '2026-09-21T00:00:00Z',
    assets: [
      {
        name: 'Clipwell-1.1.0-arm64.dmg',
        browser_download_url:
          'https://github.com/lioneltchami/clipwell/releases/download/v1.1.0/Clipwell-1.1.0-arm64.dmg',
        size: 3_727_340
      }
    ]
  };

  let release = $state<GitHubRelease>(fallbackRelease);
  let status = $state<'checking' | 'current'>('checking');

  const dmg = $derived(release.assets.find((asset) => asset.name.endsWith('.dmg')));
  const releaseDate = $derived(
    release.published_at
      ? new Intl.DateTimeFormat('en', { month: 'short', day: 'numeric', year: 'numeric' }).format(
          new Date(release.published_at)
        )
      : null
  );
  const assetSize = $derived(
    dmg ? `${(dmg.size / 1_000_000).toFixed(1)} MB` : null
  );

  onMount(() => {
    let cancelled = false;

    fetch('https://api.github.com/repos/lioneltchami/clipwell/releases/latest', {
      headers: { Accept: 'application/vnd.github+json' }
    })
      .then((response) => (response.ok ? response.json() : Promise.reject()))
      .then((latest: GitHubRelease) => {
        if (!cancelled && latest.tag_name && latest.html_url) release = latest;
      })
      .catch(() => {
        // The build-time fallback remains accurate if GitHub's public API is unavailable.
      })
      .finally(() => {
        if (!cancelled) status = 'current';
      });

    return () => {
      cancelled = true;
    };
  });
</script>

<section id="download" class="download" aria-labelledby="download-title">
  <div class="download__copy reveal">
    <p class="mono-label">Current release</p>
    <h2 id="download-title">A download link that knows the release.</h2>
    <p>
      Clipwell checks the public GitHub release metadata in your browser. If that request is unavailable, this panel falls back to the verified release bundled with the site.
    </p>
  </div>

  <div class="download__card frame reveal">
    <div class="download__headline">
      <div>
        <p class="mono-label">Latest stable</p>
        <h3>{release.tag_name}</h3>
      </div>
      <span class="download__state" aria-live="polite">
        <i aria-hidden="true"></i>{status === 'checking' ? 'Checking GitHub' : 'Ready'}
      </span>
    </div>

    <dl>
      <div><dt>Platform</dt><dd>macOS 15.2+ · Apple silicon</dd></div>
      <div><dt>Package</dt><dd>{dmg?.name ?? 'DMG package'}{assetSize ? ` · ${assetSize}` : ''}</dd></div>
      <div><dt>Published</dt><dd>{releaseDate ?? 'See release notes'}</dd></div>
    </dl>

    <div class="download__actions">
      <a class="btn-primary" href={dmg?.browser_download_url ?? release.html_url}>Download DMG</a>
      <a class="btn-ghost" href={release.html_url}>Release notes →</a>
    </div>

    <p class="download__fine">
      Each public release is built, signed, notarized, and accompanied by a Sparkle update feed. Verify the release assets and notes on GitHub before installing.
    </p>
  </div>
</section>

<style>
  .download {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: var(--space-3xl) var(--page-gutter);
    display: grid;
    gap: var(--space-xl);
  }

  .download__copy {
    display: grid;
    gap: var(--space-sm);
    align-content: center;
  }

  .download__copy h2,
  .download__card h3 {
    margin: 0;
    font-size: var(--text-display-s);
    font-weight: 650;
  }

  .download__copy > p:last-child {
    margin: 0;
    max-width: 48ch;
    color: var(--color-ink-2);
  }

  .download__card {
    display: grid;
    gap: var(--space-lg);
    padding: var(--space-xl);
    background:
      radial-gradient(110% 100% at 100% 0%, var(--color-grain-b), transparent 60%),
      var(--color-paper-2);
  }

  .download__headline,
  .download__headline > div,
  .download__actions {
    display: flex;
    align-items: center;
  }

  .download__headline {
    justify-content: space-between;
    gap: var(--space-md);
  }

  .download__headline > div {
    align-items: baseline;
    gap: var(--space-sm);
  }

  .download__headline p,
  .download__headline h3 {
    margin: 0;
  }

  .download__card h3 {
    font-size: var(--text-4xl);
  }

  .download__state {
    display: inline-flex;
    align-items: center;
    gap: var(--space-xs);
    color: var(--color-ink-2);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    white-space: nowrap;
  }

  .download__state i {
    width: 0.5rem;
    aspect-ratio: 1;
    border-radius: 50%;
    background: var(--color-ok);
    box-shadow: 0 0 0 0.2rem var(--color-ok-soft);
  }

  dl {
    display: grid;
    gap: var(--space-sm);
    margin: 0;
  }

  dl div {
    display: grid;
    grid-template-columns: minmax(0, 0.7fr) minmax(0, 1.3fr);
    gap: var(--space-md);
    padding-block: var(--space-sm);
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  dt {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
  }

  dd {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
  }

  .download__actions {
    flex-wrap: wrap;
    gap: var(--space-md);
  }

  .download__fine {
    margin: 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    max-width: 68ch;
  }

  @media (min-width: 60rem) {
    .download {
      grid-template-columns: minmax(0, 0.75fr) minmax(0, 1.25fr);
      align-items: center;
    }
  }
</style>
