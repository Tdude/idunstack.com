# Lucide Icons Implementation for Idunworks

## Core Icon Set

### Development & Technical
```jsx
// Code & Development
import { Code2, FileCode, Terminal, GitBranch, Layers, Database } from 'lucide-react';

// Performance & Speed  
import { Zap, Gauge, Rocket, TrendingUp } from 'lucide-react';

// Architecture & Systems
import { Layers, Boxes, Network, Settings, Cog } from 'lucide-react';
```

### Business & Team
```jsx
// Team & Collaboration
import { Users, UserCheck, Handshake, MessageSquare } from 'lucide-react';

// Communication & Contact
import { Mail, Phone, MapPin, Globe, ExternalLink } from 'lucide-react';

// Business & Growth
import { TrendingUp, Target, Award, Star, Briefcase } from 'lucide-react';
```

### Solarpunk & Sustainability
```jsx
// Nature & Environment
import { Leaf, TreePine, Flower2, Sprout, Sun } from 'lucide-react';

// Energy & Technology
import { Battery, Lightbulb, Recycle, Wheat, Wind } from 'lucide-react';

// Growth & Innovation
import { TrendingUp, Sparkles, Lightbulb, Zap } from 'lucide-react';
```

### User Experience
```jsx
// Design & UX
import { Palette, Eye, Layout, Smartphone, Monitor } from 'lucide-react';

// Navigation & Actions
import { ChevronRight, ArrowRight, Plus, Check, X } from 'lucide-react';

// Status & Feedback
import { CheckCircle, AlertCircle, Info, AlertTriangle } from 'lucide-react';
```

## Implementation Examples

### React Component (for Next.js)
```jsx
import { Code2, Users, Leaf, Zap } from 'lucide-react';

const FeatureCard = ({ icon: Icon, title, description }) => (
  <div className="feature-card">
    <div className="feature-icon">
      <Icon 
        size={32} 
        strokeWidth={1.5} 
        className="text-stone-gray hover:text-idun-gold transition-colors"
      />
    </div>
    <h3 className="feature-title">{title}</h3>
    <p className="feature-description">{description}</p>
  </div>
);

// Usage
<FeatureCard 
  icon={Code2}
  title="Clean Code"
  description="Human-crafted, AI-enhanced development"
/>
```

### Svelte Component (for Idun CMS)
```svelte
<script>
  import { Code2, Users, Leaf, Zap } from 'lucide-svelte';
  
  export let icon;
  export let size = 24;
  export let strokeWidth = 1.5;
  export let className = '';
</script>

<svelte:component 
  this={icon} 
  {size} 
  {strokeWidth} 
  class="text-stone-gray hover:text-idun-gold transition-colors {className}"
/>
```

### CSS Integration
```css
/* Icon container styles */
.icon-container {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: var(--stone-gray);
  transition: color var(--duration-normal) var(--ease-in-out);
}

.icon-container:hover {
  color: var(--idun-gold);
}

/* Size variants */
.icon-sm { width: 16px; height: 16px; }
.icon-base { width: 24px; height: 24px; }
.icon-lg { width: 32px; height: 32px; }
.icon-xl { width: 48px; height: 48px; }

/* Semantic colors */
.icon-success { color: var(--success); }
.icon-warning { color: var(--warning); }
.icon-error { color: var(--error); }
.icon-info { color: var(--info); }
```

## Navigation Icons
```jsx
// Main navigation
const navIcons = {
  home: Home,
  about: Users,
  services: Code2,
  portfolio: Layers,
  contact: Mail,
  blog: FileText
};

// Service pages
const serviceIcons = {
  'web-development': Code2,
  'cms-development': Database,
  'performance-optimization': Zap,
  'ai-integration': Sparkles,
  'consulting': MessageSquare
};
```

## Feature Highlighting
```jsx
// Core features with appropriate icons
const features = [
  {
    icon: Code2,
    title: "Clean Code",
    description: "Human-crafted, AI-enhanced development",
    color: "text-forest-green"
  },
  {
    icon: Zap,
    title: "Lightning Fast",
    description: "Optimized for speed and performance",
    color: "text-solar-orange"  
  },
  {
    icon: Leaf,
    title: "Sustainable Tech",
    description: "Solarpunk principles in every project",
    color: "text-sage-green"
  },
  {
    icon: Users,
    title: "Human + AI",
    description: "The perfect partnership for modern web",
    color: "text-sky-blue"
  }
];
```

## Status & Feedback Icons
```jsx
// Form validation
const validationIcons = {
  valid: CheckCircle,
  invalid: AlertCircle,
  warning: AlertTriangle,
  info: Info
};

// Loading states
const loadingIcons = {
  spinner: Loader2, // with rotation animation
  progress: BarChart3,
  check: CheckCircle
};

// File types
const fileIcons = {
  code: FileCode,
  image: FileImage,
  document: FileText,
  archive: Archive,
  unknown: File
};
```

## Interactive Elements
```jsx
// Buttons with icons
const ButtonWithIcon = ({ children, icon: Icon, ...props }) => (
  <button className="btn-with-icon" {...props}>
    {Icon && <Icon size={20} strokeWidth={1.5} />}
    {children}
  </button>
);

// Usage examples
<ButtonWithIcon icon={ExternalLink}>View Project</ButtonWithIcon>
<ButtonWithIcon icon={Mail}>Get in Touch</ButtonWithIcon>
<ButtonWithIcon icon={Download}>Download PDF</ButtonWithIcon>
```

## Animation Examples
```css
/* Rotating animation for loading */
@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.icon-spin {
  animation: spin 1s linear infinite;
}

/* Pulse animation for notifications */
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.icon-pulse {
  animation: pulse 2s infinite;
}

/* Bounce animation for success */
@keyframes bounce {
  0%, 20%, 53%, 80%, 100% { transform: translateY(0); }
  40%, 43% { transform: translateY(-8px); }
  70% { transform: translateY(-4px); }
  90% { transform: translateY(-2px); }
}

.icon-bounce {
  animation: bounce 1s ease-in-out;
}
```

## Accessibility Implementation
```jsx
const AccessibleIcon = ({ 
  icon: Icon, 
  label, 
  decorative = false,
  size = 24,
  ...props 
}) => (
  <Icon
    size={size}
    aria-label={decorative ? undefined : label}
    aria-hidden={decorative}
    role={decorative ? 'presentation' : 'img'}
    {...props}
  />
);

// Usage
<AccessibleIcon 
  icon={Code2} 
  label="Development services" 
  decorative={false}
/>

<AccessibleIcon 
  icon={Star} 
  decorative={true} // Purely visual decoration
/>
```

## Icon Grid Layout
```jsx
// Services grid with icons
const ServicesGrid = () => (
  <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
    {services.map(({ icon: Icon, title, description }) => (
      <div key={title} className="service-item">
        <div className="service-icon">
          <Icon size={48} strokeWidth={1.5} />
        </div>
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    ))}
  </div>
);
```

## Custom Icon Creation Guidelines

### When to Create Custom Icons
- Brand-specific elements (golden apple, Norse references)
- Unique service offerings not covered by Lucide
- Complex concepts needing specific visualization
- Logo variations and brand marks

### Design Principles
- **Stroke consistency**: Match Lucide's 1.5px stroke width
- **Pixel alignment**: Snap to 24px grid for sharpness
- **Style coherence**: Match Lucide's geometric, minimal style
- **Scalability**: Work at 16px minimum size

### SVG Structure
```svg
<svg 
  width="24" 
  height="24" 
  viewBox="0 0 24 24" 
  fill="none" 
  stroke="currentColor" 
  stroke-width="1.5" 
  stroke-linecap="round" 
  stroke-linejoin="round"
>
  <!-- Icon paths here -->
</svg>
```

## Icon Documentation Template
For each icon used, document:
- **Purpose**: What it represents
- **Context**: Where it's used
- **Variations**: Different sizes/states
- **Accessibility**: Label requirements
- **Interactions**: Hover/active states

This comprehensive icon system ensures consistent, accessible, and meaningful visual communication across all Idunworks touchpoints.