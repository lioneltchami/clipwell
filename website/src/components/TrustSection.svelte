<section id="proof" class="proof" aria-labelledby="proof-title">
  <div class="proof__head reveal">
    <p class="mono-label">Built in public</p>
    <h2 id="proof-title">Proof you can inspect before you install.</h2>
    <p>
      Clipwell does not publish invented testimonials. Instead, the current release, source, update feed, and privacy model are available for you to verify directly.
    </p>
  </div>

  <div class="proof__grid">
    <article class="proof__card frame reveal">
      <p class="mono-label">Source</p>
      <h3>Open source</h3>
      <p>Review the native macOS source, build steps, license, and issue history before you run the app.</p>
      <a class="btn-ghost" href="https://github.com/lioneltchami/clipwell">Inspect source →</a>
    </article>

    <article class="proof__card frame reveal">
      <p class="mono-label">Release</p>
      <h3>Signed and notarized</h3>
      <p>The public DMG is packaged from the release workflow, signed with a Developer ID, notarized by Apple, and published with release notes.</p>
      <a class="btn-ghost" href="https://github.com/lioneltchami/clipwell/releases/latest">Inspect release →</a>
    </article>

    <article class="proof__card frame reveal">
      <p class="mono-label">Privacy</p>
      <h3>Local by design</h3>
      <p>Choose what to capture, save output to your own folder, and keep recordings off a cloud account or analytics service.</p>
      <a class="btn-ghost" href="/clipwell/privacy-policy">Read privacy policy →</a>
    </article>
  </div>

  <p class="proof__fine reveal">
    Have used Clipwell? Public feedback with your permission can be added here once it is attributable and reviewable.
  </p>
</section>

<style>
  .proof {
    max-width: var(--page-max);
    margin: 0 auto;
    padding: var(--space-3xl) var(--page-gutter);
  }

  .proof__head {
    display: grid;
    gap: var(--space-sm);
    max-width: 52rem;
    margin-bottom: var(--space-xl);
  }

  .proof__head h2,
  .proof__card h3 {
    margin: 0;
    font-size: var(--text-display-s);
    font-weight: 650;
  }

  .proof__head > p:last-child,
  .proof__card > p:not(.mono-label) {
    margin: 0;
    color: var(--color-ink-2);
  }

  .proof__grid {
    display: grid;
    gap: var(--space-md);
  }

  .proof__card {
    display: grid;
    align-content: start;
    gap: var(--space-md);
    min-height: 16rem;
    padding: var(--space-xl);
    background: var(--color-paper-2);
  }

  .proof__card:nth-child(2) {
    background:
      radial-gradient(100% 100% at 100% 0%, var(--color-grain-b), transparent 58%),
      var(--color-paper-2);
  }

  .proof__card .btn-ghost {
    width: fit-content;
    margin-top: auto;
  }

  .proof__fine {
    max-width: 64ch;
    margin: var(--space-lg) 0 0;
    color: var(--color-ink-3);
    font-size: var(--text-xs);
  }

  @media (min-width: 48rem) {
    .proof__grid {
      grid-template-columns: repeat(3, minmax(0, 1fr));
    }
  }
</style>
