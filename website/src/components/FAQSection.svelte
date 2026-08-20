<script lang="ts">
  const faqs = [
    {
      q: 'Is Clipwell free?',
      a: 'Yes. MIT licensed. No subscription, no watermark, no trial clock.'
    },
    {
      q: 'Does it record system audio?',
      a: 'Yes — system audio and microphone can be captured together via ScreenCaptureKit.'
    },
    {
      q: 'Where do recordings go?',
      a: 'Straight to a folder you choose on your Mac. Nothing uploads unless you move the file yourself.'
    },
    {
      q: 'What macOS version is required?',
      a: 'macOS 15.2 Sequoia or later.'
    },
    {
      q: 'Is this the same as Clipwell?',
      a: 'Clipwell is a fork focused on camera layouts, pause, annotations, trim, and GIF export. App rename is in progress.'
    }
  ];

  let openIndex = $state(0);
</script>

<section id="faq" class="faq">
  <div class="faq__inner">
    <div class="faq__head reveal">
      <p class="mono-label">FAQ</p>
      <h2>Short answers</h2>
    </div>
    <div class="list">
      {#each faqs as item, i}
        <div class="item frame reveal">
          <button
            type="button"
            class="q"
            aria-expanded={openIndex === i}
            onclick={() => (openIndex = openIndex === i ? -1 : i)}
          >
            <span>{item.q}</span>
            <span class="chev" aria-hidden="true">{openIndex === i ? '−' : '+'}</span>
          </button>
          {#if openIndex === i}
            <p class="a">{item.a}</p>
          {/if}
        </div>
      {/each}
    </div>
  </div>
</section>

<style>
  .faq {
    padding: var(--space-3xl) var(--page-gutter);
    max-width: var(--page-max);
    margin: 0 auto;
  }

  .faq__head {
    margin-bottom: var(--space-xl);
  }

  h2 {
    font-size: var(--text-display-s);
    font-weight: 600;
    margin: var(--space-sm) 0 0;
  }

  .list {
    display: grid;
    gap: var(--space-sm);
  }

  .item {
    background: var(--color-paper-2);
  }

  .q {
    width: 100%;
    display: flex;
    justify-content: space-between;
    gap: var(--space-md);
    align-items: center;
    text-align: left;
    padding: var(--space-md) var(--space-lg);
    border: 0;
    background: transparent;
    font-family: var(--font-display);
    font-size: var(--text-lg);
    font-weight: 500;
    color: var(--color-ink);
    cursor: pointer;
  }

  .chev {
    font-family: var(--font-mono);
    color: var(--color-ink-3);
  }

  .a {
    margin: 0;
    padding: 0 var(--space-lg) var(--space-md);
    max-width: 60ch;
    color: var(--color-ink-2);
  }
</style>
