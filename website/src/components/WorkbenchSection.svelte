<script lang="ts">
  const base = import.meta.env.BASE_URL;
  const asset = (path: string) =>
    `${base.endsWith('/') ? base : `${base}/`}${path.replace(/^\//, '')}`;

  // Hero owns screenshot-basic.png — never reuse it here.
  const steps = [
    {
      title: 'Pick a display, window, or area',
      caption: 'System picker or area selection — Clipwell stays in the menu bar until you hit record.',
      img: asset('screenshot-content-filter.png'),
      alt: 'Content filter controls in Clipwell',
      grain: 'a'
    },
    {
      title: 'Record with mic, clicks, and draw mode',
      caption: 'System audio + microphone, click highlighter, keystroke overlay, and live annotation strokes composited into the file.',
      img: asset('shot-menu-tall.png'),
      alt: 'Clipwell menu with recording options expanded',
      grain: 'b'
    },
    {
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
          <img src={step.img} alt={step.alt} width="732" height="800" loading="lazy" />
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
