<script lang="ts">
  const base = import.meta.env.BASE_URL;
  const asset = (path: string) =>
    `${base.endsWith('/') ? base : `${base}/`}${path.replace(/^\//, '')}`;

  type DemoTask = {
    id: 'walkthrough' | 'bug-report' | 'quick-clip';
    label: string;
    title: string;
    caption: string;
    media: 'image' | 'video';
    source: string;
    poster?: string;
    alt: string;
    steps: string[];
  };

  const tasks: DemoTask[] = [
    {
      id: 'walkthrough',
      label: 'Record a walkthrough',
      title: 'Start from the menu bar. Keep the take local.',
      caption:
        'Use the recorder controls to choose your display and capture system audio or your microphone before you press record.',
      media: 'image',
      source: asset('clipwell-walkthrough-rectangular.webp'),
      alt: 'Clipwell recording controls with built-in Retina display and microphone enabled',
      steps: ['Choose a display or area', 'Enable system audio or microphone', 'Record directly to your folder']
    },
    {
      id: 'bug-report',
      label: 'Report a bug',
      title: 'Exclude what should not be in the capture.',
      caption:
        'Keep your menu bar, dock, cursor, wallpaper, and Clipwell itself under control before recording a reproducible bug report.',
      media: 'video',
      source: asset('clipwell-content-filter-rectangular.mp4'),
      poster: asset('clipwell-demo-keyframe.webp'),
      alt: 'Clipwell Content Filter controls showing capture options as a rectangular product panel',
      steps: ['Keep or hide desktop context', 'Control cursor and window shadows', 'Capture only the proof you need']
    },
    {
      id: 'quick-clip',
      label: 'Make a quick clip',
      title: 'Choose a format that fits the handoff.',
      caption:
        'Set frame rate and encoding for a lightweight clip, then trim or export a GIF after the take without sending your file to a service.',
      media: 'image',
      source: asset('clipwell-frame-rate-rectangular.webp'),
      alt: 'Clipwell frame-rate and encoding settings',
      steps: ['Set frame rate and codec', 'Trim the completed take', 'Export a GIF when a clip is enough']
    }
  ];

  let activeId = $state<DemoTask['id']>('walkthrough');
  let activeTask = $derived(tasks.find((task) => task.id === activeId) ?? tasks[0]);
</script>

<section id="demo" class="demo" aria-labelledby="demo-title">
  <div class="demo__head reveal">
    <p class="mono-label">Interactive tour</p>
    <h2 id="demo-title">Pick the job. See the real control surface.</h2>
    <p>
      Each state is pulled from the native app. Choose a task to inspect the controls that make that workflow possible.
    </p>
  </div>

  <div class="demo__picker reveal" aria-label="Choose a recording task">
    {#each tasks as task}
      <button
        type="button"
        class="demo__task"
        class:is-active={task.id === activeId}
        aria-pressed={task.id === activeId}
        onclick={() => (activeId = task.id)}
      >
        {task.label}
      </button>
    {/each}
  </div>

  <div class="demo__stage frame reveal" aria-live="polite">
    <figure class="demo__image">
      {#key activeTask.id}
        {#if activeTask.media === 'video'}
          <video
            controls
            muted
            loop
            playsinline
            poster={activeTask.poster}
            aria-label={activeTask.alt}
          >
            <source src={activeTask.source} type="video/mp4" />
            Your browser does not support the Clipwell product demo video.
          </video>
        {:else}
          <img src={activeTask.source} alt={activeTask.alt} width="1280" height="800" />
        {/if}
      {/key}
      <figcaption>{activeTask.media === 'video' ? 'Clipwell product demo' : 'Authentic Clipwell product state'} · {activeTask.label}</figcaption>
    </figure>

    <div class="demo__copy">
      <p class="mono-label">{activeTask.label}</p>
      <h3>{activeTask.title}</h3>
      <p>{activeTask.caption}</p>
      <ol>
        {#each activeTask.steps as step, index}
          <li><span>{String(index + 1).padStart(2, '0')}</span>{step}</li>
        {/each}
      </ol>
      <a class="btn-primary" href="https://github.com/lioneltchami/clipwell/releases/latest">
        Download Clipwell
      </a>
    </div>
  </div>
</section>

<style>
  .demo {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: var(--space-3xl) var(--page-gutter);
  }

  .demo__head {
    display: grid;
    gap: var(--space-sm);
    max-width: 46rem;
  }

  .demo__head h2,
  .demo__copy h3 {
    margin: 0;
    font-size: var(--text-display-s);
    font-weight: 650;
  }

  .demo__head > p:last-child,
  .demo__copy > p:not(.mono-label) {
    margin: 0;
    color: var(--color-ink-2);
    max-width: 60ch;
  }

  .demo__picker {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: var(--space-sm);
    margin-block: var(--space-xl);
  }

  .demo__task {
    min-width: 0;
    border: var(--rule-hair) solid var(--color-rule);
    border-radius: var(--radius-sm);
    padding: var(--space-sm) var(--space-md);
    background: var(--color-paper-2);
    color: var(--color-ink-2);
    font: inherit;
    font-size: var(--text-sm);
    cursor: pointer;
    white-space: nowrap;
    transition: background var(--dur-fast) var(--ease-out), color var(--dur-fast) var(--ease-out), border-color var(--dur-fast) var(--ease-out);
  }

  .demo__task:hover,
  .demo__task.is-active {
    border-color: var(--color-accent);
    background: var(--color-paper-3);
    color: var(--color-ink);
  }

  .demo__stage {
    display: grid;
    border-radius: 0;
    background: var(--color-paper-2);
  }

  .demo__image {
    margin: 0;
    display: grid;
    align-content: start;
    gap: var(--space-sm);
    padding: var(--space-lg);
    background: var(--color-paper-3);
  }

  .demo__image img,
  .demo__image video {
    display: block;
    width: 100%;
    height: auto;
    border-radius: 0;
    clip-path: none;
    object-fit: contain;
    box-shadow: 0 20px 40px -28px var(--color-shadow-strong);
  }

  figcaption {
    color: var(--color-ink-3);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
  }

  .demo__copy {
    display: grid;
    align-content: center;
    gap: var(--space-md);
    padding: var(--space-xl);
  }

  .demo__copy h3 {
    font-size: var(--text-4xl);
  }

  .demo__copy ol {
    display: grid;
    gap: var(--space-sm);
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .demo__copy li {
    display: grid;
    grid-template-columns: 2rem minmax(0, 1fr);
    gap: var(--space-sm);
    align-items: baseline;
    color: var(--color-ink-2);
  }

  .demo__copy li span {
    color: var(--color-accent);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
  }

  .demo__copy .btn-primary {
    width: fit-content;
  }

  @media (max-width: 48rem) {
    .demo__picker {
      grid-template-columns: 1fr;
    }
  }

  @media (min-width: 60rem) {
    .demo__stage {
      grid-template-columns: minmax(0, 1.25fr) minmax(0, 0.75fr);
    }
  }
</style>
