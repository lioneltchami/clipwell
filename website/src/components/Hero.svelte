<script lang="ts">
  let typed = $state('');
  const full = 'clipwell record --mic --annotate';
  let copied = $state(false);

  $effect(() => {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      typed = full;
      return;
    }
    let i = 0;
    const id = setInterval(() => {
      i += 1;
      typed = full.slice(0, i);
      if (i >= full.length) clearInterval(id);
    }, 42);
    return () => clearInterval(id);
  });

  async function copyBrew() {
    try {
      await navigator.clipboard.writeText('brew install --cask clipwell');
      copied = true;
      setTimeout(() => (copied = false), 1800);
    } catch {
      copied = false;
    }
  }
</script>

<section class="hero">
  <div class="hero__grid">
    <div class="hero__copy reveal">
      <p class="mono-label"><span class="tick" aria-hidden="true"></span> macOS 15.2+</p>
      <h1>Screen capture that stays on your Mac.</h1>
      <p class="lede">
        Clipwell is a native menu-bar recorder: system audio, mic, annotations, camera overlay, trim, and GIF export — no cloud account, no watermark.
      </p>
      <div class="hero__cta">
        <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/releases/latest">Download for macOS</a>
        <a class="btn-ghost" href="https://github.com/lioneltchami/clipwell">View source →</a>
      </div>
      <div class="brew frame">
        <code>brew install --cask clipwell</code>
        <button type="button" class="copy" onclick={copyBrew} aria-label="Copy Homebrew command">
          {copied ? 'Copied' : 'Copy'}
        </button>
      </div>
      <p class="fine">Requires macOS 15.2 Sequoia or later · MIT license</p>
    </div>

    <aside class="demo frame reveal" aria-label="Clipwell terminal preview">
      <div class="demo__bar">
        <span class="dots" aria-hidden="true"><i></i><i></i><i></i></span>
        <span class="mono-label">session.sh</span>
        <span class="status">READY</span>
      </div>
      <pre class="demo__body"><span class="prompt">$</span> {typed}<span class="caret" aria-hidden="true"></span>
<span class="muted"># menu bar · ScreenCaptureKit · local files only</span>
<span class="ok">ok</span>  display + mic mixed
<span class="ok">ok</span>  annotations composited
<span class="ok">ok</span>  wrote ~/Movies/Clipwell/clip.mov</pre>
    </aside>
  </div>
</section>

<style>
  .hero {
    padding: calc(var(--space-3xl) + 0.5rem) var(--page-gutter) var(--space-3xl);
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .hero__grid {
    display: grid;
    gap: var(--space-2xl);
    align-items: center;
  }

  .tick {
    display: inline-block;
    width: 0.45rem;
    height: 0.45rem;
    margin-right: 0.45rem;
    border-radius: 1px;
    background: var(--color-accent);
    vertical-align: 0.05em;
  }

  h1 {
    font-size: var(--text-display);
    font-weight: 600;
    margin: var(--space-md) 0 var(--space-lg);
    max-width: 14ch;
  }

  .lede {
    max-width: 42ch;
    margin: 0 0 var(--space-xl);
    color: var(--color-ink-2);
    font-size: var(--text-lg);
  }

  .hero__cta {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: var(--space-md);
    margin-bottom: var(--space-lg);
  }

  .brew {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: var(--space-sm);
    padding: 0.65rem 0.75rem;
    max-width: 28rem;
    background: var(--color-paper-2);
  }

  .brew code {
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    color: var(--color-ink);
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    min-width: 0;
  }

  .copy {
    flex-shrink: 0;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-sm);
    background: var(--color-paper);
    color: var(--color-ink-2);
    font-size: var(--text-xs);
    font-weight: 600;
    padding: 0.35rem 0.55rem;
    cursor: pointer;
  }

  .fine {
    margin: var(--space-sm) 0 0;
    font-size: var(--text-xs);
    color: var(--color-ink-3);
  }

  .demo {
    background: var(--color-graphite);
    color: oklch(92% 0.01 250);
    box-shadow: 0 1px 2px oklch(0% 0 0 / 0.08);
    min-width: 0;
  }

  .demo__bar {
    display: flex;
    align-items: center;
    gap: var(--space-sm);
    padding: 0.65rem 0.85rem;
    border-bottom: var(--rule-hair) solid oklch(35% 0.02 260);
  }

  .demo__bar .mono-label {
    color: oklch(70% 0.02 250);
  }

  .dots {
    display: flex;
    gap: 0.3rem;
  }

  .dots i {
    width: 0.45rem;
    height: 0.45rem;
    border-radius: 999px;
    background: oklch(45% 0.02 260);
  }

  .status {
    margin-inline-start: auto;
    font-family: var(--font-mono);
    font-size: 0.65rem;
    letter-spacing: 0.06em;
    color: var(--color-ok);
  }

  .demo__body {
    margin: 0;
    padding: var(--space-lg);
    font-family: var(--font-mono);
    font-size: clamp(0.72rem, 1.8vw, 0.85rem);
    line-height: 1.65;
    white-space: pre-wrap;
    overflow-wrap: anywhere;
  }

  .prompt {
    color: var(--color-accent);
  }

  .muted {
    color: oklch(65% 0.02 250);
  }

  .ok {
    color: var(--color-ok);
  }

  .caret {
    display: inline-block;
    width: 0.45em;
    height: 1em;
    margin-left: 1px;
    background: var(--color-accent);
    vertical-align: -0.15em;
    animation: blink 1s step-end infinite;
  }

  @keyframes blink {
    50% {
      opacity: 0;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .caret {
      animation: none;
      opacity: 0;
    }
  }

  @media (min-width: 60rem) {
    .hero__grid {
      grid-template-columns: minmax(0, 1.05fr) minmax(0, 0.95fr);
      gap: var(--space-3xl);
    }
  }
</style>
