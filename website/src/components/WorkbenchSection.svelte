<script lang="ts">
  const stages = [
    {
      number: '01',
      label: 'Scope',
      title: 'Decide what proves the point.',
      body: 'Choose one display, one window, or one area. Keep only the desktop context that helps someone understand the issue or walkthrough.',
      details: ['Display · window · area', 'Content filters before record']
    },
    {
      number: '02',
      label: 'Capture',
      title: 'Add the context that a silent clip misses.',
      body: 'Bring in system sound, microphone, clicks, keystrokes, drawing, or camera only when they help explain the take.',
      details: ['System audio + microphone', 'Aids are opt-in']
    },
    {
      number: '03',
      label: 'Finish',
      title: 'Hand over a file, not an account.',
      body: 'Save the recording locally, trim the moment that matters, or export a GIF when the handoff should stay small.',
      details: ['Local MOV output', 'Trim and GIF after capture']
    }
  ];
</script>

<section id="workflow" class="workflow" aria-labelledby="workflow-title">
  <header class="workflow__head reveal">
    <p class="mono-label">Capture sequence</p>
    <h2 id="workflow-title">Three decisions. One local file.</h2>
    <p>Clipwell is designed around the path from a reproducible moment to a file you can send without changing where it lives.</p>
  </header>

  <ol class="workflow__stages">
    {#each stages as stage}
      <li class="workflow__stage reveal">
        <p class="workflow__number" aria-hidden="true">{stage.number}</p>
        <div class="workflow__marker" aria-hidden="true"><span></span></div>
        <div class="workflow__copy">
          <p class="mono-label">{stage.label}</p>
          <h3>{stage.title}</h3>
          <p>{stage.body}</p>
          <ul>
            {#each stage.details as detail}
              <li>{detail}</li>
            {/each}
          </ul>
        </div>
      </li>
    {/each}
  </ol>

  <a class="workflow__cta btn-ghost reveal" href="#download">Start with the current release →</a>
</section>

<style>
  .workflow {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: var(--space-4xl) var(--page-gutter);
  }

  .workflow__head {
    display: grid;
    gap: var(--space-sm);
    max-width: 44rem;
    margin-bottom: var(--space-3xl);
  }

  .workflow__head h2,
  .workflow__copy h3 {
    margin: 0;
    color: var(--color-ink);
    font-weight: 650;
  }

  .workflow__head h2 {
    font-size: var(--text-display-s);
  }

  .workflow__head > p:last-child,
  .workflow__copy > p:not(.mono-label) {
    margin: 0;
    color: var(--color-ink-2);
    max-width: 54ch;
  }

  .workflow__stages {
    display: grid;
    gap: 0;
    margin: 0;
    padding: 0;
    list-style: none;
    border-top: var(--rule-hair) solid var(--color-rule);
  }

  .workflow__stage {
    display: grid;
    grid-template-columns: 3.25rem 1rem minmax(0, 1fr);
    gap: var(--space-md);
    padding: var(--space-xl) 0;
    border-bottom: var(--rule-hair) solid var(--color-rule);
  }

  .workflow__number {
    margin: 0;
    color: var(--color-accent);
    font-family: var(--font-mono);
    font-size: var(--text-sm);
    font-variant-numeric: tabular-nums;
  }

  .workflow__marker {
    position: relative;
    display: flex;
    justify-content: center;
  }

  .workflow__marker::after {
    position: absolute;
    top: 1rem;
    bottom: -2.25rem;
    width: var(--rule-hair);
    background: var(--color-rule);
    content: '';
  }

  .workflow__stage:last-child .workflow__marker::after {
    display: none;
  }

  .workflow__marker span {
    z-index: 1;
    width: 0.7rem;
    height: 0.7rem;
    margin-top: 0.2rem;
    border: var(--rule-hair) solid var(--color-accent);
    border-radius: 50%;
    background: var(--color-paper);
  }

  .workflow__copy {
    display: grid;
    gap: var(--space-sm);
  }

  .workflow__copy h3 {
    font-size: var(--text-4xl);
  }

  .workflow__copy ul {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-xs);
    margin: var(--space-xs) 0 0;
    padding: 0;
    list-style: none;
  }

  .workflow__copy li {
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-sm);
    padding: 0.25rem 0.55rem;
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
  }

  .workflow__cta {
    margin-top: var(--space-xl);
  }

  @media (min-width: 48rem) {
    .workflow__stage {
      grid-template-columns: 5rem 1.5rem minmax(0, 1fr);
      gap: var(--space-xl);
      padding: var(--space-2xl) 0;
    }
  }
</style>
