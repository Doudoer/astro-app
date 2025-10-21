import { defineConfig } from 'astro/config';
import react from '@astrojs/react';

export default defineConfig({
  site: 'http://localhost:3000',
  integrations: [react()],
});
