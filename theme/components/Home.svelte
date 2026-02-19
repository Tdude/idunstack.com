<script lang="ts">
  import PageView from './PageView.svelte';
  import { underlayStore } from '$lib/stores/underlay';
  
  let { data }: { data: any } = $props();
</script>

<svelte:head>
  <title>Idun Works — Websites that are fast, honest, and yours</title>
  <meta name="description" content="We build blazingly fast websites with the Idun CMS. No bloat, no lock-in, no surprises." />
</svelte:head>

<div class="min-h-screen bg-gray-50 dark:bg-gray-900">
  {#if data.home}
    <!-- Render the homepage content from CMS -->
    <PageView page={data.home} />
    
    <!-- Additional IdunWorks-specific sections -->
    <section class="py-16 bg-white dark:bg-gray-800">
      <div class="container mx-auto px-6">
        <div class="text-center mb-12">
          <h2 class="text-3xl font-bold text-gray-900 dark:text-white mb-4">
            Built by developers who got tired of the alternatives
          </h2>
          <p class="text-xl text-gray-600 dark:text-gray-300 max-w-3xl mx-auto">
            25 years of web development experience, distilled into a CMS that actually works.
          </p>
        </div>
        
        <!-- Performance metrics -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-8 max-w-4xl mx-auto">
          <div class="metric">
            <span class="metric-value">50ms</span>
            <span class="metric-label">Time to First Byte</span>
          </div>
          <div class="metric">
            <span class="metric-value">150kb</span>
            <span class="metric-label">JavaScript Bundle</span>
          </div>
          <div class="metric">
            <span class="metric-value">2-5</span>
            <span class="metric-label">DB Queries/Page</span>
          </div>
          <div class="metric">
            <span class="metric-value">25+</span>
            <span class="metric-label">Years Experience</span>
          </div>
        </div>
      </div>
    </section>
    
    <!-- Tech stack showcase -->
    <section class="py-16 bg-gray-100 dark:bg-gray-900">
      <div class="container mx-auto px-6">
        <div class="text-center mb-12">
          <h2 class="text-3xl font-bold text-gray-900 dark:text-white mb-4">
            The Stack That Actually Works
          </h2>
          <p class="text-xl text-gray-600 dark:text-gray-300">
            No hype. No buzzwords. Just tools that deliver.
          </p>
        </div>
        
        <div class="grid md:grid-cols-3 gap-8 max-w-5xl mx-auto">
          <div class="tech-card">
            <div class="tech-icon">🐍</div>
            <h3>FastAPI</h3>
            <p class="text-gray-600">Modern Python backend. Async, typed, documented. Actually fast.</p>
          </div>
          
          <div class="tech-card">
            <div class="tech-icon">🟠</div>
            <h3>Svelte 5</h3>
            <p class="text-gray-600">No virtual DOM overhead. Tiny bundles. Server-side rendering.</p>
          </div>
          
          <div class="tech-card">
            <div class="tech-icon">🐘</div>
            <h3>PostgreSQL</h3>
            <p class="text-gray-600">25+ years of reliability. ACID compliance. Your data stays safe.</p>
          </div>
        </div>
      </div>
    </section>
    
  {:else}
    <!-- Fallback content if no CMS homepage -->
    <div class="hero-idunworks min-h-screen flex items-center justify-center text-white">
      <div class="container mx-auto px-6 text-center relative z-10">
        <h1 class="text-5xl md:text-6xl font-bold mb-6">
          Websites that are fast, honest, and yours
        </h1>
        <p class="text-xl md:text-2xl mb-8 opacity-90">
          No bloat. No lock-in. No surprises.
        </p>
        <div class="space-x-4">
          <a href="/contact" class="cta-button inline-block">
            Get Started
          </a>
          <a href="/idun" class="bg-white bg-opacity-20 text-white px-6 py-3 rounded-lg font-semibold hover:bg-opacity-30 transition-all inline-block">
            Learn More
          </a>
        </div>
      </div>
    </div>
    
    <div class="container mx-auto px-6 py-16">
      <div class="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-8 text-center">
        <h2 class="text-2xl font-semibold mb-4 text-gray-900 dark:text-white">
          Custom IdunWorks Theme Active
        </h2>
        <p class="text-gray-600 dark:text-gray-300 mb-6">
          This theme was built using build-time composition. No symlinks needed!
        </p>
        <div class="grid md:grid-cols-2 gap-6 mt-8">
          <div class="feature-highlight p-4 bg-gray-50 dark:bg-gray-700 rounded">
            <h3 class="font-semibold text-gray-900 dark:text-white">Professional Design</h3>
            <p class="text-gray-600 dark:text-gray-300">Clean, modern styling for tech companies</p>
          </div>
          <div class="feature-highlight p-4 bg-gray-50 dark:bg-gray-700 rounded">
            <h3 class="font-semibold text-gray-900 dark:text-white">Performance Focused</h3>
            <p class="text-gray-600 dark:text-gray-300">Optimized for speed and user experience</p>
          </div>
        </div>
      </div>
    </div>
  {/if}
</div>