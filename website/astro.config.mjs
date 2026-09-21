// @ts-check
import { defineConfig } from "astro/config";

import tailwindcss from "@tailwindcss/vite";
import sitemap from "@astrojs/sitemap";
import svelte from "@astrojs/svelte";

// https://astro.build/config
export default defineConfig({
  site: "https://sweet-sawine-67c174.netlify.app",
  // Netlify serves the site at the root. Custom-domain mapping is out of
  // scope for this deploy. If a custom domain is later attached, change
  // `site` to that URL and keep `base` at "/".
  base: "/",
  integrations: [
    svelte(),
    sitemap({
      changefreq: "weekly",
      priority: 0.7,
      lastmod: new Date(),
    }),
  ],
  vite: {
    plugins: [tailwindcss()],
  },
});
