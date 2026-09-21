<script lang="ts">
  let {
    eyebrow,
    title,
    lede
  }: { eyebrow?: string; title: string; lede: string } = $props();
</script>

<header class="page-header">
  {#if eyebrow}
    <p class="mono-label"><span class="tick" aria-hidden="true"></span> {eyebrow}</p>
  {/if}
  <h1>{title}</h1>
  <p class="lede">{lede}</p>
</header>

<style>
  .page-header {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: calc(var(--space-3xl) + 2.5rem) var(--page-gutter) var(--space-2xl);
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
    max-width: 18ch;
    margin: var(--space-md) 0 var(--space-lg);
    font-size: clamp(2.25rem, 5vw, 4rem);
    font-weight: 680;
    letter-spacing: -0.05em;
    line-height: 1.05;
  }

  .lede {
    max-width: 48ch;
    margin: 0;
    color: var(--color-ink-2);
    font-size: var(--text-xl);
  }
</style>