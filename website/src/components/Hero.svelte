<script lang="ts">
  let copied = $state(false);
  const base = import.meta.env.BASE_URL;
  const home = base.endsWith('/') ? base : `${base}/`;
  const shot = `${home}screenshot-basic.png`;

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
        Native menu-bar recorder with system audio, mic, annotations, camera overlay, trim, and GIF export — no cloud account, no watermark.
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

    <aside class="product reveal" aria-label="Clipwell app preview">
      <div class="product__window frame">
        <div class="product__chrome">
          <span class="traffic" aria-hidden="true"><i></i><i></i><i></i></span>
          <span class="product__title">Clipwell</span>
          <span class="rec" aria-hidden="true"><b></b> Recording</span>
        </div>
        <div class="product__body">
          <img src={shot} alt="Clipwell recording controls on macOS" width="1280" height="800" />
          <div class="product__panel" aria-hidden="true">
            <div class="meter">
              <span>Display</span>
              <strong>Built-in Retina</strong>
            </div>
            <div class="meter">
              <span>Mic</span>
              <strong>On</strong>
            </div>
            <div class="meter">
              <span>Duration</span>
              <strong class="timer">00:42</strong>
            </div>
          </div>
        </div>
      </div>
    </aside>
  </div>
</section>

<style>
  .hero {
    padding: calc(var(--space-3xl) + 2.5rem) var(--page-gutter) var(--space-3xl);
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
    border-radius: 999px;
    background: var(--color-accent);
    vertical-align: 0.05em;
  }

  h1 {
    font-size: var(--text-display);
    font-weight: 650;
    letter-spacing: -0.035em;
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
    padding: 0.65rem 0.85rem;
    max-width: 28rem;
    border-radius: var(--radius-md);
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
    background: var(--color-paper-3);
    color: var(--color-ink-2);
    font-size: var(--text-xs);
    font-weight: 600;
    padding: 0.35rem 0.7rem;
    cursor: pointer;
  }

  .fine {
    margin: var(--space-sm) 0 0;
    font-size: var(--text-xs);
    color: var(--color-ink-3);
  }

  .product {
    min-width: 0;
  }

  .product__window {
    background: var(--color-paper-2);
    border-radius: var(--radius-md);
    box-shadow: 0 24px 50px -30px oklch(0% 0 0 / 0.75);
    overflow: hidden;
  }

  .product__chrome {
    display: flex;
    align-items: center;
    gap: var(--space-sm);
    padding: 0.7rem 0.9rem;
    border-bottom: var(--rule-hair) solid var(--color-rule);
    background: var(--color-paper-3);
  }

  .traffic {
    display: flex;
    gap: 0.35rem;
  }

  .traffic i {
    width: 0.55rem;
    height: 0.55rem;
    border-radius: 999px;
    background: oklch(40% 0.02 50);
  }

  .traffic i:nth-child(1) {
    background: oklch(62% 0.14 25);
  }
  .traffic i:nth-child(2) {
    background: oklch(68% 0.12 85);
  }
  .traffic i:nth-child(3) {
    background: oklch(62% 0.1 150);
  }

  .product__title {
    font-size: var(--text-sm);
    font-weight: 600;
    color: var(--color-ink);
  }

  .rec {
    margin-inline-start: auto;
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    font-family: var(--font-mono);
    font-size: 0.65rem;
    letter-spacing: 0.04em;
    text-transform: uppercase;
    color: var(--color-accent);
  }

  .rec b {
    width: 0.4rem;
    height: 0.4rem;
    border-radius: 999px;
    background: var(--color-accent);
    display: inline-block;
  }

  .product__body {
    display: grid;
    gap: 0;
  }

  .product__body img {
    display: block;
    width: 100%;
    height: auto;
    background: var(--color-paper);
  }

  .product__panel {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: var(--space-sm);
    padding: var(--space-md);
    border-top: var(--rule-hair) solid var(--color-rule);
    background: var(--color-paper-2);
  }

  .meter {
    min-width: 0;
    display: grid;
    gap: 0.15rem;
  }

  .meter span {
    font-family: var(--font-mono);
    font-size: 0.65rem;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    color: var(--color-ink-3);
  }

  .meter strong {
    font-size: var(--text-sm);
    font-weight: 600;
    color: var(--color-ink);
  }

  .timer {
    font-variant-numeric: tabular-nums;
    color: var(--color-accent);
  }

  @media (min-width: 60rem) {
    .hero__grid {
      grid-template-columns: minmax(0, 1fr) minmax(0, 1.05fr);
      gap: var(--space-3xl);
    }
  }
</style>
