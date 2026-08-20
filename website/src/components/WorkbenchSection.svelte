<script lang="ts">
  const base = import.meta.env.BASE_URL;
  const asset = (path: string) =>
    `${base.endsWith('/') ? base : `${base}/`}${path.replace(/^\//, '')}`;

  const steps = [
    {
      title: 'Pick a display, window, or area',
      caption: 'System picker or area selection — Clipwell stays in the menu bar until you hit record.',
      img: asset('screenshot-content-filter.png'),
      alt: 'Clipwell content filter controls'
    },
    {
      title: 'Record with mic, clicks, and draw mode',
      caption: 'System audio + microphone, click highlighter, keystroke overlay, and live annotation strokes composited into the file.',
      img: asset('screenshot-basic.png'),
      alt: 'Clipwell recording controls'
    },
    {
      title: 'Trim, export GIF, keep files local',
      caption: 'Post-record trim and GIF export. Output lands in your folder — no account, no upload.',
      img: asset('screenshot-frame-rate.png'),
      alt: 'Clipwell encoding and frame rate settings'
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
      <li class="step reveal">
        <figure class="frame">
          <img src={step.img} alt={step.alt} width="1280" height="800" loading="lazy" />
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
    font-weight: 600;
    margin: var(--space-sm) 0 0;
  }

  .steps {
    list-style: none;
    margin: 0;
    padding: 0;
    display: grid;
    gap: var(--space-3xl);
  }

  .step {
    display: grid;
    gap: var(--space-lg);
    align-items: start;
    min-width: 0;
  }

  figure {
    margin: 0;
    min-width: 0;
  }

  img {
    display: block;
    width: 100%;
    height: auto;
    background: var(--color-paper-2);
  }

  h3 {
    font-size: var(--text-4xl);
    font-weight: 600;
    margin: var(--space-xs) 0 var(--space-sm);
  }

  .step__copy p:last-child {
    margin: 0;
    max-width: 42ch;
    color: var(--color-ink-2);
  }

  @media (min-width: 60rem) {
    .step {
      grid-template-columns: minmax(0, 1.4fr) minmax(0, 0.8fr);
      gap: var(--space-2xl);
      align-items: center;
    }

    .step:nth-child(even) {
      grid-template-columns: minmax(0, 0.8fr) minmax(0, 1.4fr);
    }

    .step:nth-child(even) figure {
      order: 2;
    }
  }
</style>
