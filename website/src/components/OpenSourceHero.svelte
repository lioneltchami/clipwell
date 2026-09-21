<script lang="ts">
  /*
    Open-source page header — design derived from Mobbin catalog anchors:

    - 5.1 Supabase hero ("Open Source" as first words of H1; Star us on GitHub in nav)
      https://mobbin.com/sites/sections/0eb5722a-4576-49bd-9d04-b2d9556690fc
    - 5.4 Greptile (explicit [ OPEN SOURCE ] badge rhythm, MIT/Apache/GPL copy,
      Apply for OSS CTA beside startup discount card)
      https://mobbin.com/sites/sections/3acb1f30-cc02-4b04-9dbe-b6425a2b55ed
    - 5.8 Lightdash ("only open source X" + Start for free / Try live demo dual CTAs)
      https://mobbin.com/sites/sections/29e133de-34ee-4255-a796-b185d60e359d
    - 5.9 Lightdash origin story (first GitHub commit timeline, narrative framing)
      https://mobbin.com/sites/sections/4a6efa26-8500-4346-a229-ba23004bce0f
  */
  let { base = '/' }: { base?: string } = $props();
  const home = base.endsWith('/') ? base : `${base}/`;
</script>

<header class="oss-hero" aria-labelledby="oss-hero-title">
  <div class="oss-hero__inner">
    <p class="oss-hero__badge"><span aria-hidden="true">[</span> OPEN SOURCE <span aria-hidden="true">]</span></p>

    <h1 id="oss-hero-title">
      Open source. <span>MIT.</span> Free.
    </h1>

    <p class="oss-hero__lede">
      Clipwell ships under the MIT license. The source, the builds, the docs, and
      the URL-scheme automation are all on the public repository. There is no
      paid tier today and no plan to introduce one in v1.1.x.
    </p>

    <div class="oss-hero__cta">
      <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/releases/latest">
        Download for macOS
        <span aria-hidden="true">→</span>
      </a>
      <a class="btn-ghost" href="https://github.com/lioneltchami/clipwell">
        View on GitHub
        <span aria-hidden="true">↗</span>
      </a>
    </div>

    <ul class="oss-hero__chips" role="list">
      <li><span class="oss-hero__chip-dot" aria-hidden="true"></span> MIT licensed</li>
      <li><span class="oss-hero__chip-dot" aria-hidden="true"></span> No account required</li>
      <li><span class="oss-hero__chip-dot" aria-hidden="true"></span> No telemetry</li>
      <li><span class="oss-hero__chip-dot" aria-hidden="true"></span> No cloud uploads</li>
    </ul>
  </div>
</header>

<style>
  /* Mobbin 5.4 Greptile [OPEN SOURCE] badge rhythm */
  .oss-hero__badge {
    display: inline-flex;
    gap: 0.3rem;
    margin: 0 0 var(--space-md);
    padding: 0.35rem 0.65rem;
    background: var(--color-accent);
    color: var(--color-accent-ink);
    border-radius: var(--radius-sm);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    font-weight: 600;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    width: max-content;
  }

  /* Mobbin 5.1 Supabase — "Open Source" as first words of H1 */
  .oss-hero {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: calc(var(--space-3xl) + 2.5rem) var(--page-gutter) var(--space-2xl);
  }

  h1 {
    max-width: 18ch;
    margin: 0 0 var(--space-lg);
    font-size: clamp(2.5rem, 6vw, 4.5rem);
    font-weight: 680;
    letter-spacing: -0.05em;
    line-height: 1.05;
  }

  h1 span {
    color: var(--color-accent);
  }

  .oss-hero__lede {
    max-width: 56ch;
    margin: 0 0 var(--space-2xl);
    color: var(--color-ink-2);
    font-size: var(--text-xl);
    line-height: 1.55;
  }

  /* Mobbin 5.8 Lightdash — Start for free / Try live demo dual CTAs */
  .oss-hero__cta {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-md);
    margin-bottom: var(--space-2xl);
  }

  .btn-primary,
  .btn-ghost {
    display: inline-flex;
    align-items: center;
    gap: var(--space-xs);
  }

  /* Mobbin 5.4 Greptile — license chip row */
  .oss-hero__chips {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-md);
    color: var(--color-ink-2);
    font-size: var(--text-sm);
  }

  .oss-hero__chips li {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
  }

  .oss-hero__chip-dot {
    width: 0.4rem;
    height: 0.4rem;
    border-radius: 50%;
    background: var(--color-ok);
  }
</style>