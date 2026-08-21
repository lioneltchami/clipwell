<script lang="ts">
  const base = import.meta.env.BASE_URL;
  const asset = (path: string) =>
    `${base.endsWith('/') ? base : `${base}/`}${path.replace(/^\//, '')}`;

  type ImageStep = {
    kind: 'image';
    title: string;
    caption: string;
    img: string;
    alt: string;
    grain: string;
  };

  type AidsStep = {
    kind: 'aids';
    title: string;
    caption: string;
    grain: string;
  };

  // Hero owns screenshot-basic.png — never reuse it in this sequence.
  const steps: Array<ImageStep | AidsStep> = [
    {
      kind: 'image',
      title: 'Pick a display, window, or area',
      caption: 'System picker or area selection — Clipwell stays in the menu bar until you hit record.',
      img: asset('screenshot-content-filter-clipwell.png'),
      alt: 'Content filter controls in Clipwell',
      grain: 'a'
    },
    {
      kind: 'aids',
      title: 'Record with mic, clicks, and draw mode',
      caption: 'System audio + microphone, click highlighter, keystroke overlay, and live annotation strokes composited into the file.',
      grain: 'b'
    },
    {
      kind: 'image',
      title: 'Trim, export GIF, keep files local',
      caption: 'Post-record trim and GIF export. Output lands in your folder — no account, no upload.',
      img: asset('screenshot-frame-rate.png'),
      alt: 'Frame rate and encoding settings',
      grain: 'c'
    }
  ];
</script>

<section id="workbench" class="workbench">
  <div class="workbench__head reveal">
    <p class="mono-label">Workbench</p>
    <h2>Three moves. File on disk.</h2>
  </div>

  <ol class="steps">
    {#each steps as step, i}
      <li class="step reveal" data-grain={step.grain}>
        <figure class="shot">
          {#if step.kind === 'aids'}
            <div class="aids-card" aria-label="Recording aids enabled">
              <div class="aids-card__header">
                <span class="aids-card__signal" aria-hidden="true"></span>
                <span>Recording aids</span>
                <span class="aids-card__recording">Live</span>
              </div>
              <div class="aids-card__preview" aria-hidden="true">
                <span class="aids-card__click"></span>
                <span class="aids-card__stroke"></span>
                <span class="aids-card__keystroke">⌘</span>
              </div>
              <ul class="aids-card__list">
                <li><span>System audio</span><span class="aids-card__on">On</span></li>
                <li><span>Microphone</span><span class="aids-card__on">On</span></li>
                <li><span>Clicks · keys · draw</span><span class="aids-card__on">On</span></li>
              </ul>
            </div>
          {:else}
            <img src={step.img} alt={step.alt} width="732" height="800" loading="lazy" />
          {/if}
        </figure>
        <div class="step__copy">
          <p class="mono-label">0{i + 1}</p>
          <h3>{step.title}</h3>
          <p>{step.caption}</p>
        </div>
      </li>
    {/each}
  </ol>
</section>

<style>
  .workbench {
    padding: var(--space-3xl) var(--page-gutter);
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .workbench__head {
    margin-bottom: var(--space-2xl);
    max-width: 28rem;
  }

  h2 {
    font-size: var(--text-display-s);
    font-weight: 650;
    margin: var(--space-sm) 0 0;
    color: var(--color-ink);
  }

  .steps {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: var(--space-2xl);
  }

  .step {
    display: grid;
    gap: var(--space-lg);
    align-items: stretch;
    min-width: 0;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-md);
    overflow: hidden;
    background: var(--color-paper-2);
  }

  .shot {
    margin: 0;
    min-width: 0;
    display: grid;
    place-items: center;
    padding: var(--space-xl);
    background:
      radial-gradient(120% 90% at 20% 10%, var(--color-grain-a), transparent 55%),
      radial-gradient(100% 80% at 90% 80%, var(--color-grain-b), transparent 50%),
      radial-gradient(80% 70% at 50% 100%, var(--color-grain-c), transparent 45%),
      var(--color-paper-3);
  }

  .step[data-grain='b'] .shot {
    background:
      radial-gradient(120% 90% at 80% 0%, var(--color-grain-b), transparent 55%),
      radial-gradient(100% 80% at 10% 90%, var(--color-grain-c), transparent 50%),
      var(--color-paper-3);
  }

  .step[data-grain='c'] .shot {
    background:
      radial-gradient(110% 90% at 40% 0%, var(--color-grain-c), transparent 55%),
      radial-gradient(100% 80% at 100% 100%, var(--color-grain-a), transparent 50%),
      var(--color-paper-3);
  }

  img {
    display: block;
    width: min(100%, 22rem);
    height: auto;
    border-radius: 12px;
    box-shadow: 0 18px 40px -24px oklch(0% 0 0 / 0.65);
    background: var(--color-paper);
  }

  .aids-card {
    width: min(100%, 22rem);
    overflow: hidden;
    border: 1px solid oklch(76% 0.04 25 / 0.24);
    border-radius: 12px;
    background: oklch(12% 0.015 25 / 0.96);
    box-shadow: 0 18px 40px -24px oklch(0% 0 0 / 0.65);
    color: var(--color-ink);
  }

  .aids-card__header,
  .aids-card__list li {
    display: flex;
    align-items: center;
  }

  .aids-card__header {
    gap: var(--space-xs);
    padding: var(--space-sm) var(--space-md);
    border-bottom: var(--rule-hair) solid oklch(100% 0 0 / 0.12);
    font-size: var(--text-sm);
    font-weight: 650;
  }

  .aids-card__signal {
    width: 0.6rem;
    aspect-ratio: 1;
    border-radius: 50%;
    background: oklch(78% 0.17 150);
    box-shadow: 0 0 0 0.22rem oklch(78% 0.17 150 / 0.18);
  }

  .aids-card__recording,
  .aids-card__on {
    margin-left: auto;
    color: oklch(81% 0.16 150);
    font-size: var(--text-xs);
  }

  .aids-card__preview {
    position: relative;
    height: 11rem;
    overflow: hidden;
    background:
      radial-gradient(circle at 30% 34%, oklch(68% 0.2 310 / 0.8) 0 5%, transparent 5.5%),
      radial-gradient(circle at 70% 70%, oklch(72% 0.18 30 / 0.72) 0 4%, transparent 4.5%),
      linear-gradient(135deg, oklch(26% 0.1 290), oklch(18% 0.07 320) 50%, oklch(25% 0.12 25));
  }

  .aids-card__click,
  .aids-card__keystroke {
    position: absolute;
    display: grid;
    place-items: center;
    border: 1px solid oklch(100% 0 0 / 0.4);
    background: oklch(8% 0.01 25 / 0.58);
    box-shadow: 0 0 0 0.45rem oklch(100% 0 0 / 0.08);
  }

  .aids-card__click {
    top: 32%;
    left: 24%;
    width: 1.5rem;
    aspect-ratio: 1;
    border-radius: 50%;
  }

  .aids-card__stroke {
    position: absolute;
    top: 57%;
    left: 35%;
    width: 45%;
    height: 18%;
    border-top: 3px solid oklch(86% 0.16 78);
    border-radius: 50%;
    rotate: -13deg;
  }

  .aids-card__keystroke {
    right: 20%;
    bottom: 22%;
    width: 2rem;
    aspect-ratio: 1;
    border-radius: 0.45rem;
    font-size: var(--text-base);
  }

  .aids-card__list {
    display: grid;
    gap: var(--space-xs);
    margin: 0;
    padding: var(--space-sm) var(--space-md) var(--space-md);
    list-style: none;
    font-size: var(--text-sm);
  }

  .aids-card__list li {
    gap: var(--space-sm);
  }

  .step__copy {
    padding: var(--space-lg) var(--space-xl) var(--space-xl);
  }

  h3 {
    font-size: var(--text-4xl);
    font-weight: 650;
    margin: var(--space-xs) 0 var(--space-sm);
    color: var(--color-ink);
  }

  .step__copy p:last-child {
    margin: 0;
    max-width: 42ch;
    color: var(--color-ink-2);
  }

  @media (min-width: 60rem) {
    .step {
      grid-template-columns: minmax(0, 1.15fr) minmax(0, 0.85fr);
    }

    .step:nth-child(even) {
      grid-template-columns: minmax(0, 0.85fr) minmax(0, 1.15fr);
    }

    .step:nth-child(even) .shot {
      order: 2;
    }

    .step__copy {
      display: grid;
      align-content: center;
    }
  }
</style>
