# Idunworks Design System Implementation
*Code examples and component specifications*

## CSS Variables Setup

### Complete Color System
```css
:root {
  /* Primary Palette */
  --idun-gold: #D4AF37;
  --idun-gold-light: #E5C865;
  --idun-gold-dark: #B8941E;
  
  --forest-green: #2D5016;
  --forest-green-light: #3E6B2E;
  --forest-green-dark: #1C3609;
  
  --stone-gray: #8B8680;
  --stone-gray-light: #A8A39E;
  --stone-gray-dark: #6B655F;
  
  --clean-white: #FAFAFA;
  --clean-white-dark: #F5F5F5;
  
  /* Secondary Palette */
  --solar-orange: #FF8C42;
  --solar-orange-light: #FF9F66;
  --solar-orange-dark: #E6791E;
  
  --sky-blue: #4A90A4;
  --sky-blue-light: #6BA7BE;
  --sky-blue-dark: #3A7285;
  
  --deep-charcoal: #2C2C2C;
  --deep-charcoal-light: #404040;
  --deep-charcoal-dark: #1A1A1A;
  
  --sage-green: #9CAF88;
  --sage-green-light: #B0C19D;
  --sage-green-dark: #849572;
  
  /* Semantic Colors */
  --success: #16A085;
  --success-light: #48C9B0;
  --success-dark: #138D75;
  
  --warning: #F39C12;
  --warning-light: #F8C471;
  --warning-dark: #D68910;
  
  --error: #E74C3C;
  --error-light: #EC7063;
  --error-dark: #C0392B;
  
  --info: #3498DB;
  --info-light: #5DADE2;
  --info-dark: #2E86C1;
  
  /* Gradients */
  --gradient-primary: linear-gradient(135deg, var(--idun-gold), var(--solar-orange));
  --gradient-nature: linear-gradient(135deg, var(--forest-green), var(--sage-green));
  --gradient-tech: linear-gradient(135deg, var(--sky-blue), var(--deep-charcoal));
  --gradient-sunset: linear-gradient(135deg, var(--solar-orange), var(--idun-gold));
}

/* Dark mode variants */
@media (prefers-color-scheme: dark) {
  :root {
    --clean-white: #1A1A1A;
    --clean-white-dark: #2C2C2C;
    --stone-gray: #A8A39E;
    --deep-charcoal: #FAFAFA;
    --deep-charcoal-light: #F5F5F5;
  }
}
```

### Typography System
```css
:root {
  /* Font Families */
  --font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', 'SF Mono', 'Monaco', 'Consolas', monospace;
  --font-display: 'Playfair Display', 'Georgia', serif;
  
  /* Font Sizes */
  --text-xs: 0.75rem;    /* 12px */
  --text-sm: 0.875rem;   /* 14px */
  --text-base: 1rem;     /* 16px */
  --text-lg: 1.125rem;   /* 18px */
  --text-xl: 1.25rem;    /* 20px */
  --text-2xl: 1.5rem;    /* 24px */
  --text-3xl: 1.875rem;  /* 30px */
  --text-4xl: 2.25rem;   /* 36px */
  --text-5xl: 3rem;      /* 48px */
  --text-6xl: 3.75rem;   /* 60px */
  
  /* Font Weights */
  --font-weight-light: 300;
  --font-weight-regular: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
  
  /* Line Heights */
  --leading-tight: 1.25;
  --leading-snug: 1.375;
  --leading-normal: 1.5;
  --leading-relaxed: 1.625;
  --leading-loose: 2;
  
  /* Letter Spacing */
  --tracking-tight: -0.025em;
  --tracking-normal: 0;
  --tracking-wide: 0.025em;
  --tracking-wider: 0.05em;
}

/* Typography Classes */
.h1 {
  font-family: var(--font-display);
  font-size: var(--text-5xl);
  font-weight: var(--font-weight-bold);
  line-height: var(--leading-tight);
  letter-spacing: var(--tracking-tight);
  color: var(--deep-charcoal);
}

.h2 {
  font-family: var(--font-primary);
  font-size: var(--text-3xl);
  font-weight: var(--font-weight-semibold);
  line-height: var(--leading-tight);
  color: var(--deep-charcoal);
}

.body {
  font-family: var(--font-primary);
  font-size: var(--text-base);
  font-weight: var(--font-weight-regular);
  line-height: var(--leading-relaxed);
  color: var(--stone-gray-dark);
}

.code {
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  background: var(--clean-white-dark);
  padding: 0.125rem 0.375rem;
  border-radius: 0.25rem;
}
```

### Spacing and Layout
```css
:root {
  /* Spacing Scale */
  --space-0: 0;
  --space-1: 0.25rem;   /* 4px */
  --space-2: 0.5rem;    /* 8px */
  --space-3: 0.75rem;   /* 12px */
  --space-4: 1rem;      /* 16px */
  --space-5: 1.25rem;   /* 20px */
  --space-6: 1.5rem;    /* 24px */
  --space-8: 2rem;      /* 32px */
  --space-10: 2.5rem;   /* 40px */
  --space-12: 3rem;     /* 48px */
  --space-16: 4rem;     /* 64px */
  --space-20: 5rem;     /* 80px */
  --space-24: 6rem;     /* 96px */
  --space-32: 8rem;     /* 128px */
  
  /* Border Radius */
  --radius-sm: 0.25rem; /* 4px */
  --radius-md: 0.5rem;  /* 8px */
  --radius-lg: 1rem;    /* 16px */
  --radius-full: 9999px;
  
  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
  --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
  
  /* Transitions */
  --duration-fast: 150ms;
  --duration-normal: 300ms;
  --duration-slow: 500ms;
  
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-in: cubic-bezier(0.4, 0, 1, 1);
}
```

## Component Library

### Button Components
```css
.btn {
  display: inline-flex;
  align-items: center;
  gap: var(--space-2);
  padding: var(--space-3) var(--space-6);
  font-family: var(--font-primary);
  font-size: var(--text-base);
  font-weight: var(--font-weight-medium);
  border: none;
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: all var(--duration-normal) var(--ease-in-out);
  text-decoration: none;
}

.btn-primary {
  background: var(--idun-gold);
  color: var(--deep-charcoal);
}

.btn-primary:hover {
  background: var(--idun-gold-dark);
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.btn-secondary {
  background: transparent;
  color: var(--forest-green);
  border: 2px solid var(--forest-green);
}

.btn-secondary:hover {
  background: var(--forest-green);
  color: var(--clean-white);
}

.btn-ghost {
  background: transparent;
  color: var(--stone-gray);
}

.btn-ghost:hover {
  background: var(--clean-white-dark);
  color: var(--deep-charcoal);
}
```

### Card Components
```css
.card {
  background: var(--clean-white);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  transition: all var(--duration-normal) var(--ease-in-out);
}

.card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-4px);
}

.card-header {
  padding: var(--space-6);
  border-bottom: 1px solid var(--clean-white-dark);
}

.card-body {
  padding: var(--space-6);
}

.card-footer {
  padding: var(--space-6);
  border-top: 1px solid var(--clean-white-dark);
  background: var(--clean-white-dark);
}

/* Feature Card Variant */
.feature-card {
  text-align: center;
  padding: var(--space-8);
}

.feature-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 64px;
  height: 64px;
  margin: 0 auto var(--space-4);
  background: var(--gradient-primary);
  border-radius: var(--radius-full);
  color: var(--clean-white);
}

.feature-title {
  font-size: var(--text-xl);
  font-weight: var(--font-weight-semibold);
  margin-bottom: var(--space-2);
  color: var(--deep-charcoal);
}

.feature-description {
  color: var(--stone-gray);
  line-height: var(--leading-relaxed);
}
```

### Navigation Components
```css
.nav {
  display: flex;
  align-items: center;
  gap: var(--space-8);
  padding: var(--space-4) 0;
}

.nav-link {
  font-family: var(--font-primary);
  font-size: var(--text-base);
  font-weight: var(--font-weight-medium);
  color: var(--stone-gray);
  text-decoration: none;
  position: relative;
  transition: color var(--duration-normal) var(--ease-in-out);
}

.nav-link:hover,
.nav-link.active {
  color: var(--idun-gold);
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--idun-gold);
  transition: width var(--duration-normal) var(--ease-in-out);
}

.nav-link:hover::after,
.nav-link.active::after {
  width: 100%;
}

/* Mobile Navigation */
.nav-mobile {
  display: none;
  flex-direction: column;
  position: fixed;
  top: 0;
  right: 0;
  width: 100%;
  height: 100vh;
  background: var(--clean-white);
  padding: var(--space-8);
  transform: translateX(100%);
  transition: transform var(--duration-normal) var(--ease-in-out);
}

.nav-mobile.open {
  transform: translateX(0);
}

@media (max-width: 768px) {
  .nav {
    display: none;
  }
  
  .nav-mobile {
    display: flex;
  }
}
```

### Hero Section Component
```css
.hero {
  position: relative;
  min-height: 80vh;
  display: flex;
  align-items: center;
  background: var(--gradient-sunset);
  overflow: hidden;
}

.hero::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('/hero-pattern.svg') repeat;
  opacity: 0.1;
  z-index: 1;
}

.hero-content {
  position: relative;
  z-index: 2;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--space-6);
  text-align: center;
  color: var(--clean-white);
}

.hero-title {
  font-family: var(--font-display);
  font-size: var(--text-6xl);
  font-weight: var(--font-weight-bold);
  line-height: var(--leading-tight);
  margin-bottom: var(--space-6);
  text-shadow: 0 2px 4px rgb(0 0 0 / 0.3);
}

.hero-subtitle {
  font-size: var(--text-xl);
  font-weight: var(--font-weight-regular);
  line-height: var(--leading-relaxed);
  margin-bottom: var(--space-8);
  opacity: 0.9;
}

.hero-actions {
  display: flex;
  gap: var(--space-4);
  justify-content: center;
  flex-wrap: wrap;
}

@media (max-width: 768px) {
  .hero-title {
    font-size: var(--text-4xl);
  }
  
  .hero-subtitle {
    font-size: var(--text-lg);
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
}
```

## React/Svelte Components

### React Feature Card Component
```jsx
import React from 'react';
import { Code2, Zap, Leaf, Users } from 'lucide-react';

const FeatureCard = ({ 
  icon: Icon = Code2, 
  title, 
  description, 
  color = 'var(--idun-gold)' 
}) => {
  return (
    <div className="feature-card">
      <div className="feature-icon" style={{ background: color }}>
        <Icon size={32} strokeWidth={1.5} />
      </div>
      <h3 className="feature-title">{title}</h3>
      <p className="feature-description">{description}</p>
    </div>
  );
};

// Usage
const FeaturesGrid = () => {
  const features = [
    {
      icon: Code2,
      title: "Clean Code",
      description: "Human-crafted, AI-enhanced development",
      color: 'var(--forest-green)'
    },
    {
      icon: Zap,
      title: "Lightning Fast",
      description: "Optimized for speed and performance",
      color: 'var(--solar-orange)'
    },
    {
      icon: Leaf,
      title: "Sustainable Tech",
      description: "Solarpunk principles in every project", 
      color: 'var(--sage-green)'
    },
    {
      icon: Users,
      title: "Human + AI",
      description: "The perfect partnership for modern web",
      color: 'var(--sky-blue)'
    }
  ];

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      {features.map((feature, index) => (
        <FeatureCard key={index} {...feature} />
      ))}
    </div>
  );
};
```

### Svelte Hero Component
```svelte
<script>
  import { Code2, ArrowRight } from 'lucide-svelte';
  
  export let title = "Building Tomorrow's Web";
  export let subtitle = "Swedish web studio. Two devs — one human, one AI. We build the sites and the CMS that runs them.";
  export let primaryAction = { text: "View Our Work", href: "/portfolio" };
  export let secondaryAction = { text: "Get in Touch", href: "/contact" };
</script>

<section class="hero">
  <div class="hero-content">
    <h1 class="hero-title">{title}</h1>
    <p class="hero-subtitle">{subtitle}</p>
    <div class="hero-actions">
      <a href={primaryAction.href} class="btn btn-primary">
        <Code2 size={20} strokeWidth={1.5} />
        {primaryAction.text}
      </a>
      <a href={secondaryAction.href} class="btn btn-secondary">
        {secondaryAction.text}
        <ArrowRight size={20} strokeWidth={1.5} />
      </a>
    </div>
  </div>
</section>

<style>
  /* Component-specific styles */
  .hero {
    background: linear-gradient(135deg, var(--idun-gold), var(--solar-orange)),
                url('/hero-texture.jpg');
    background-size: cover;
    background-position: center;
    background-blend-mode: overlay;
  }
</style>
```

### Image Component with Optimization
```jsx
import React, { useState } from 'react';

const OptimizedImage = ({
  src,
  alt,
  width,
  height,
  className = '',
  loading = 'lazy',
  quality = 85
}) => {
  const [imageLoaded, setImageLoaded] = useState(false);
  const [imageError, setImageError] = useState(false);
  
  // Generate WebP and JPEG sources
  const webpSrc = src.replace(/\.(jpg|jpeg|png)$/i, '.webp');
  const fallbackSrc = src;
  
  return (
    <div className={`image-container ${className}`}>
      {!imageLoaded && !imageError && (
        <div className="image-placeholder" style={{ width, height }}>
          <div className="placeholder-shimmer" />
        </div>
      )}
      
      <picture>
        <source srcSet={webpSrc} type="image/webp" />
        <img
          src={fallbackSrc}
          alt={alt}
          width={width}
          height={height}
          loading={loading}
          className={imageLoaded ? 'loaded' : 'loading'}
          onLoad={() => setImageLoaded(true)}
          onError={() => setImageError(true)}
        />
      </picture>
      
      {imageError && (
        <div className="image-error" style={{ width, height }}>
          <span>Failed to load image</span>
        </div>
      )}
    </div>
  );
};

// Accompanying CSS
const imageStyles = `
.image-container {
  position: relative;
  overflow: hidden;
  border-radius: var(--radius-md);
}

.image-placeholder {
  background: var(--clean-white-dark);
  display: flex;
  align-items: center;
  justify-content: center;
}

.placeholder-shimmer {
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, 
    var(--clean-white-dark) 25%, 
    var(--stone-gray) 50%, 
    var(--clean-white-dark) 75%);
  background-size: 200% 100%;
  animation: shimmer 2s infinite;
}

@keyframes shimmer {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}

.image-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: opacity var(--duration-normal) var(--ease-in-out);
}

.image-container img.loading {
  opacity: 0;
}

.image-container img.loaded {
  opacity: 1;
}

.image-error {
  background: var(--clean-white-dark);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--stone-gray);
  font-size: var(--text-sm);
}
`;
```

## Animation Library
```css
/* Entrance Animations */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

/* Utility Classes */
.animate-fade-in {
  animation: fadeIn var(--duration-slow) var(--ease-out);
}

.animate-slide-up {
  animation: slideInUp var(--duration-slow) var(--ease-out);
}

.animate-slide-left {
  animation: slideInLeft var(--duration-slow) var(--ease-out);
}

/* Staggered animations */
.animate-stagger > * {
  animation: slideInUp var(--duration-slow) var(--ease-out);
}

.animate-stagger > *:nth-child(1) { animation-delay: 0ms; }
.animate-stagger > *:nth-child(2) { animation-delay: 100ms; }
.animate-stagger > *:nth-child(3) { animation-delay: 200ms; }
.animate-stagger > *:nth-child(4) { animation-delay: 300ms; }

/* Intersection Observer trigger */
.animate-on-scroll {
  opacity: 0;
  transform: translateY(30px);
  transition: all var(--duration-slow) var(--ease-out);
}

.animate-on-scroll.in-view {
  opacity: 1;
  transform: translateY(0);
}
```

This comprehensive design system implementation provides the foundation for consistent, accessible, and performant visual elements across all Idunworks touchpoints.