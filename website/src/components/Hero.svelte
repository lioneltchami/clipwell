<script lang="ts">
  /*
    Hero — design derived from Mobbin catalog anchors:

    - 1.1 Loom pre-record floating panel (source / camera / mic toggles, dual pill bar)
      https://mobbin.com/screens/96664708-cd8b-43bd-86c9-27efe0f69202
    - 1.2 Loom capture launcher (On/Off device states, dark floating session toolbar)
      https://mobbin.com/screens/40bb7031-536d-44a5-9d71-fdd4f22d8642
    - 4.1 Linear marketing hero (dark rhythm, single primary CTA, product UI as primary visual)
      https://mobbin.com/screens/b7c17da1-eac4-4a8d-b7e9-2b8d6ef30f66
    - 4.7 Supabase hero (dark split, primary + ghost CTA, nav-level CTA duplication)
      https://mobbin.com/sites/sections/6d6921ce-b43a-4232-9ebd-966b1338c349
  */
  let { base = '/' }: { base?: string } = $props();
  let copied = $state(false);

  const home = base.endsWith('/') ? base : `${base}/`;

  const sources = [
    { label: 'Display', detail: 'Full screen', on: true },
    { label: 'Window', detail: 'Single window', on: true },
    { label: 'Area', detail: 'Custom rectangle', on: true }
  ];

  const inputs = [
    { label: 'System audio', detail: 'ScreenCaptureKit loopback', on: true },
    { label: 'Microphone', detail: 'Any AVCaptureDevice input', on: true },
    { label: 'Camera overlay', detail: 'Picture-in-picture', on: false },
    { label: 'Click highlights', detail: 'Pulse rings on mouse-down', on: true },
    { label: 'Keystroke overlay', detail: 'Visible key chords', on: true }
  ];

  async function copyBrew() {
    try {
      await navigator.clipboard.writeText(
        'brew tap lioneltchami/clipwell && brew install --cask clipwell'
      );
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
        <a class="btn-ghost" href={`${home}features`}>See the capture flow →</a>
      </div>
      <div class="brew frame">
        <code>brew install lioneltchami/clipwell/clipwell</code>
        <button type="button" class="copy" onclick={copyBrew} aria-label="Copy Homebrew command">
          {copied ? 'Copied' : 'Copy'}
        </button>
      </div>
      <p class="fine">Current public release · local files · MIT license</p>
    </div>

    <aside class="picker frame reveal" aria-label="Clipwell capture pre-record picker">
      <header class="picker__head">
        <p class="mono-label">Pre-record picker</p>
        <span class="picker__state">
          <span class="picker__dot" aria-hidden="true"></span>
          Ready
        </span>
      </header>

      <div class="picker__group">
        <h3>Source</h3>
        <ul role="list">
          {#each sources as item}
            <li class="picker__row">
              <span class="picker__row-label">{item.label}</span>
              <span class="picker__row-detail">{item.detail}</span>
              <span class="picker__toggle" class:is-on={item.on} aria-hidden="true">
                <span class="picker__toggle-knob"></span>
              </span>
            </li>
          {/each}
        </ul>
      </div>

      <div class="picker__group">
        <h3>Capture inputs</h3>
        <ul role="list">
          {#each inputs as item}
            <li class="picker__row">
              <span class="picker__row-label">{item.label}</span>
              <span class="picker__row-detail">{item.detail}</span>
              <span class="picker__toggle" class:is-on={item.on} aria-hidden="true">
                <span class="picker__toggle-knob"></span>
              </span>
            </li>
          {/each}
        </ul>
      </div>

      <a class="picker__cta" href={`${home}install`}>
        <span class="picker__rec-dot" aria-hidden="true"></span>
        Start recording
      </a>
      <p class="picker__foot">All toggles default on except Camera overlay. The capture ends with a file in the folder you choose.</p>
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

  .tick {
    display: inline-block;
    width: 0.5rem;
    height: 0.5rem;
    border-radius: 50%;
    background: var(--color-accent);
    vertical-align: 1px;
    margin-right: 0.4rem;
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

  /* Pre-record picker — Mobbin 1.1 Loom pre-record floating panel. */
  .picker {
    display: grid;
    gap: var(--space-lg);
    padding: var(--space-xl);
    background:
      radial-gradient(100% 120% at 100% 0%, var(--color-grain-a), transparent 58%),
      var(--color-paper-2);
  }

  .picker__head {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    padding-bottom: var(--space-md);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .picker__state {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    color: var(--color-ink);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .picker__dot {
    width: 0.5rem;
    height: 0.5rem;
    border-radius: 50%;
    background: var(--color-ok);
    box-shadow: 0 0 0 3px var(--color-ok-soft);
  }

  .picker__group h3 {
    margin: 0 0 var(--space-sm);
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  .picker__group ul {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
  }

  .picker__row {
    display: grid;
    grid-template-columns: minmax(0, 0.9fr) minmax(0, 1.4fr) auto;
    gap: var(--space-md);
    align-items: center;
    padding-block: var(--space-sm);
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .picker__row:last-child {
    border-bottom: 0;
  }

  .picker__row-label {
    color: var(--color-ink);
    font-size: var(--text-sm);
  }

  .picker__row-detail {
    color: var(--color-ink-3);
    font-size: var(--text-xs);
  }

  .picker__toggle {
    width: 1.75rem;
    height: 1rem;
    border-radius: var(--radius-sm);
    background: var(--color-paper-3);
    border: var(--rule-hair) solid var(--color-rule);
    position: relative;
    transition: background var(--dur-fast) var(--ease-out);
  }

  .picker__toggle.is-on {
    background: var(--color-accent);
    border-color: var(--color-accent);
  }

  .picker__toggle-knob {
    position: absolute;
    top: 50%;
    left: 0.15rem;
    width: 0.7rem;
    height: 0.7rem;
    border-radius: 50%;
    background: var(--color-paper);
    transform: translateY(-50%);
    transition: left var(--dur-fast) var(--ease-out);
  }

  .picker__toggle.is-on .picker__toggle-knob {
    left: calc(100% - 0.85rem);
    background: var(--color-paper-3);
  }

  .picker__cta {
    display: inline-flex;
    align-items: center;
    gap: var(--space-xs);
    justify-content: center;
    border: 0;
    border-radius: var(--radius-sm);
    background: var(--color-accent);
    color: var(--color-accent-ink);
    font: inherit;
    font-size: var(--text-base);
    font-weight: 600;
    padding: 0.7rem 1rem;
    cursor: pointer;
  }

  .picker__rec-dot {
    width: 0.5rem;
    height: 0.5rem;
    border-radius: 50%;
    background: var(--color-accent-ink);
  }

  .picker__foot {
    margin: 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
    line-height: 1.55;
  }

  @media (min-width: 60rem) {
    .hero__grid {
      grid-template-columns: minmax(0, 1.25fr) minmax(20rem, 0.75fr);
      gap: var(--space-4xl);
    }
  }
</style>