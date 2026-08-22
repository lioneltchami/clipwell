<script lang="ts">
  let copied = $state(false);

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

<section class="hero" aria-labelledby="hero-title">
  <div class="hero__grid">
    <div class="hero__copy reveal">
      <p class="mono-label"><span class="tick" aria-hidden="true"></span> Native for macOS 15.2+</p>
      <h1 id="hero-title">Capture the proof. Keep the file.</h1>
      <p class="lede">
        Clipwell records your screen, system audio, microphone, and on-screen explanation without routing the take through a cloud account.
      </p>
      <div class="hero__cta">
        <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/releases/latest">Download Clipwell</a>
        <a class="btn-ghost" href="#demo">See the capture flow →</a>
      </div>
      <div class="brew frame">
        <code>brew install --cask clipwell</code>
        <button type="button" class="copy" onclick={copyBrew} aria-label="Copy Homebrew command">
          {copied ? 'Copied' : 'Copy'}
        </button>
      </div>
      <p class="fine">Current public release · local files · MIT license</p>
    </div>

    <aside class="signal frame reveal" aria-label="Clipwell capture capabilities">
      <p class="mono-label">Capture contract</p>
      <div class="signal__status">
        <span class="signal__dot" aria-hidden="true"></span>
        <strong>Recording locally</strong>
        <time datetime="PT42S">00:42</time>
      </div>
      <dl class="signal__rows">
        <div>
          <dt>Source</dt>
          <dd>Display, window, or area</dd>
        </div>
        <div>
          <dt>Audio</dt>
          <dd>System sound + microphone</dd>
        </div>
        <div>
          <dt>Evidence</dt>
          <dd>Clicks, keys, drawing, camera</dd>
        </div>
        <div>
          <dt>Output</dt>
          <dd>MOV now · trim or GIF after</dd>
        </div>
      </dl>
      <p class="signal__note">Permissions stay on your Mac. The completed take goes to the folder you choose.</p>
    </aside>
  </div>
</section>

<style>
  .hero {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: calc(var(--space-3xl) + 3.5rem) var(--page-gutter) var(--space-4xl);
  }

  .hero__grid {
    display: grid;
    gap: var(--space-2xl);
    align-items: end;
  }

  .tick,
  .signal__dot {
    display: inline-block;
    width: 0.5rem;
    height: 0.5rem;
    border-radius: 50%;
    background: var(--color-accent);
  }

  h1 {
    max-width: 11ch;
    margin: var(--space-md) 0 var(--space-lg);
    font-size: clamp(3rem, 7vw, 6.75rem);
    font-weight: 680;
    letter-spacing: -0.06em;
  }

  .lede {
    max-width: 40ch;
    margin: 0 0 var(--space-xl);
    color: var(--color-ink-2);
    font-size: var(--text-xl);
  }

  .hero__cta {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-md);
    margin-bottom: var(--space-lg);
  }

  .brew {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: var(--space-sm);
    max-width: 28rem;
    padding: 0.65rem 0.85rem;
    background: var(--color-paper-2);
  }

  .brew code {
    min-width: 0;
    overflow: hidden;
    color: var(--color-ink);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .copy {
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

  .fine {
    margin: var(--space-sm) 0 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
  }

  .signal {
    display: grid;
    gap: var(--space-lg);
    padding: var(--space-xl);
    background:
      radial-gradient(100% 120% at 100% 0%, var(--color-grain-a), transparent 58%),
      var(--color-paper-2);
  }

  .signal__status {
    display: grid;
    grid-template-columns: auto 1fr auto;
    gap: var(--space-sm);
    align-items: center;
    padding-block: var(--space-md);
    border-block: var(--rule-hair) solid var(--color-rule);
  }

  .signal__status strong {
    color: var(--color-ink);
    font-size: var(--text-lg);
  }

  time {
    color: var(--color-accent);
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    font-variant-numeric: tabular-nums;
  }

  .signal__rows {
    display: grid;
    gap: 0;
    margin: 0;
  }

  .signal__rows div {
    display: grid;
    grid-template-columns: minmax(0, 0.7fr) minmax(0, 1.3fr);
    gap: var(--space-md);
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  dt {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    letter-spacing: 0.05em;
    text-transform: uppercase;
  }

  dd {
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-sm);
  }

  .signal__note {
    margin: 0;
    color: var(--color-ink-3);
    font-size: var(--text-sm);
  }

  @media (min-width: 60rem) {
    .hero__grid {
      grid-template-columns: minmax(0, 1.25fr) minmax(20rem, 0.75fr);
      gap: var(--space-4xl);
    }
  }
</style>
