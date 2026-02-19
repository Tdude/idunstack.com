# Idunworks Asset Specifications
*Technical requirements for all visual assets*

## Color Specifications

### Hex Values
```css
/* Primary Palette */
--idun-gold: #D4AF37;
--forest-green: #2D5016;
--stone-gray: #8B8680;
--clean-white: #FAFAFA;

/* Secondary Palette */
--solar-orange: #FF8C42;
--sky-blue: #4A90A4;
--deep-charcoal: #2C2C2C;
--sage-green: #9CAF88;

/* Semantic Colors */
--success: #16A085;
--warning: #F39C12;
--error: #E74C3C;
--info: #3498DB;
```

### RGB Values
```css
/* Primary Palette */
--idun-gold: rgb(212, 175, 55);
--forest-green: rgb(45, 80, 22);
--stone-gray: rgb(139, 134, 128);
--clean-white: rgb(250, 250, 250);

/* Secondary Palette */
--solar-orange: rgb(255, 140, 66);
--sky-blue: rgb(74, 144, 164);
--deep-charcoal: rgb(44, 44, 44);
--sage-green: rgb(156, 175, 136);
```

### HSL Values
```css
/* Primary Palette */
--idun-gold: hsl(45, 69%, 52%);
--forest-green: hsl(96, 57%, 20%);
--stone-gray: hsl(33, 8%, 52%);
--clean-white: hsl(0, 0%, 98%);

/* Secondary Palette */
--solar-orange: hsl(20, 100%, 63%);
--sky-blue: hsl(193, 38%, 47%);
--deep-charcoal: hsl(0, 0%, 17%);
--sage-green: hsl(95, 19%, 61%);
```

## Typography Specifications

### Font Stack
```css
/* Primary */
--font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;

/* Secondary (Code) */
--font-mono: 'JetBrains Mono', 'SF Mono', 'Monaco', 'Consolas', monospace;

/* Display */
--font-display: 'Playfair Display', 'Georgia', serif;
```

### Font Weights
```css
--font-weight-light: 300;
--font-weight-regular: 400;
--font-weight-medium: 500;
--font-weight-semibold: 600;
--font-weight-bold: 700;
```

### Type Scale
```css
--text-xs: 12px;    /* 0.75rem */
--text-sm: 14px;    /* 0.875rem */
--text-base: 16px;  /* 1rem */
--text-lg: 18px;    /* 1.125rem */
--text-xl: 20px;    /* 1.25rem */
--text-2xl: 24px;   /* 1.5rem */
--text-3xl: 30px;   /* 1.875rem */
--text-4xl: 36px;   /* 2.25rem */
--text-5xl: 48px;   /* 3rem */
--text-6xl: 60px;   /* 3.75rem */
```

### Line Heights
```css
--leading-tight: 1.25;
--leading-snug: 1.375;
--leading-normal: 1.5;
--leading-relaxed: 1.625;
--leading-loose: 2;
```

## Image Specifications

### Hero Images
- **Desktop**: 1920×1080px (16:9)
- **Tablet**: 1200×800px (3:2)  
- **Mobile**: 800×600px (4:3)
- **Format**: WebP (primary), JPEG (fallback)
- **Quality**: 85% compression
- **File size**: <200KB optimized

### Feature Illustrations
- **Large**: 1200×800px (3:2)
- **Medium**: 800×600px (4:3)
- **Small**: 400×300px (4:3)
- **Format**: SVG (preferred), WebP (complex)
- **Quality**: Vector or 90% for raster
- **File size**: <100KB

### Screenshots
- **Desktop**: 1200×900px (4:3)
- **Mobile**: 375×812px (iPhone 14 ratio)
- **Tablet**: 768×1024px (iPad ratio)
- **Format**: PNG (UI precision), WebP (delivery)
- **Quality**: Lossless for PNG, 90% for WebP
- **Annotations**: 2px stroke, brand colors

### Team Photos
- **Profile**: 400×400px (1:1)
- **Header**: 1200×400px (3:1)
- **Full**: 800×600px (4:3)
- **Format**: JPEG
- **Quality**: 85% compression
- **Background**: Brand palette or natural

### Social Media
#### Instagram
- **Feed**: 1080×1080px (1:1)
- **Stories**: 1080×1920px (9:16)
- **Reels**: 1080×1920px (9:16)

#### LinkedIn
- **Post**: 1200×627px (1.91:1)
- **Article header**: 1200×627px (1.91:1)
- **Company banner**: 1192×220px

#### Twitter/X
- **Header**: 1500×500px (3:1)
- **Post image**: 1200×675px (16:9)
- **Profile**: 400×400px (1:1)

## Logo Specifications

### Primary Logo
- **Horizontal**: 300×80px minimum
- **Vertical**: 120×200px minimum
- **Clear space**: 2× logo height all sides
- **Minimum size**: 120px width
- **Format**: SVG (web), PNG (raster), PDF (print)

### Logo Variations
- **Full color**: On white/light backgrounds
- **Monochrome**: Single color applications
- **Reverse**: White on dark backgrounds
- **Icon only**: For small spaces (32×32px minimum)

### Usage Guidelines
```css
/* Logo spacing */
.logo {
  padding: 2rem; /* 2x logo height */
}

/* Minimum sizes */
.logo-horizontal { min-width: 120px; }
.logo-vertical { min-width: 80px; }
.logo-icon { min-width: 32px; }
```

## Icon Specifications

### Lucide Icons
- **Stroke width**: 1.5px (default)
- **Size scale**: 16px, 20px, 24px, 32px, 48px
- **Color**: Inherit or Stone Gray (#8B8680)
- **Hover state**: Transition to Idun Gold (#D4AF37)

### Icon Usage
```jsx
// React/Svelte implementation
<Icon 
  name="code2" 
  size={24} 
  strokeWidth={1.5} 
  color="var(--stone-gray)"
/>
```

### Custom Icons
- **Golden apple**: 24×24px, vector format
- **Human+AI symbol**: 32×32px, dual-tone
- **Swedish elements**: Minimal, geometric

## Animation Specifications

### Transitions
```css
/* Standard easing */
--ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
--ease-out: cubic-bezier(0, 0, 0.2, 1);
--ease-in: cubic-bezier(0.4, 0, 1, 1);

/* Duration */
--duration-fast: 150ms;
--duration-normal: 300ms;
--duration-slow: 500ms;
```

### Hover Effects
```css
.interactive {
  transition: all var(--duration-normal) var(--ease-in-out);
}

.interactive:hover {
  color: var(--idun-gold);
  transform: translateY(-2px);
}
```

## Device Mockups

### MacBook Pro
- **Screen**: 1728×1117px (Retina resolution)
- **Frame**: Natural silver, minimal shadows
- **Perspective**: 15° angle maximum
- **Context**: Clean desk, Scandinavian workspace

### iPhone
- **Model**: iPhone 14/15 (latest)
- **Screen**: 375×812px logical pixels
- **Frame**: Natural colors, no cases
- **Orientation**: Portrait primary, landscape when needed

### iPad  
- **Model**: iPad Air/Pro (modern)
- **Screen**: 768×1024px logical pixels
- **Frame**: Natural silver, minimal
- **Orientation**: Both portrait and landscape

## Performance Requirements

### Web Images
- **Loading**: Lazy loading below fold
- **Format**: WebP with JPEG fallback
- **Compression**: Balance quality/size (usually 80-85%)
- **Responsive**: Multiple sizes via srcset

### Image Optimization
```html
<picture>
  <source 
    srcset="image.webp" 
    type="image/webp"
  />
  <img 
    src="image.jpg" 
    alt="Descriptive text"
    loading="lazy"
  />
</picture>
```

### File Naming Convention
```
brand-logo-horizontal-primary.svg
team-photo-tibbe-buttler-workspace-800x600.jpg
screenshot-idun-cms-dashboard-desktop-1200x900.png
illustration-hero-solarpunk-coding-1920x1080.webp
icon-custom-golden-apple-24x24.svg
```

## Accessibility Requirements

### Color Contrast
- **Normal text**: 4.5:1 minimum ratio
- **Large text**: 3:1 minimum ratio
- **UI elements**: 3:1 minimum ratio
- **Test**: With WebAIM Contrast Checker

### Alt Text Guidelines
- **Descriptive**: Explain content, not just "image"
- **Contextual**: Relevant to surrounding content
- **Concise**: Under 125 characters when possible
- **Functional**: Describe purpose, not appearance

### Image Loading
- **Progressive**: Show placeholder while loading
- **Error states**: Fallback content for failed loads
- **Bandwidth**: Respect user preferences
- **Performance**: Optimize for Core Web Vitals

## Print Specifications

### Business Cards
- **Size**: 85×55mm (European standard)
- **Resolution**: 300 DPI
- **Bleed**: 3mm all sides
- **Color**: CMYK color space

### Letterhead
- **Size**: A4 (210×297mm)
- **Resolution**: 300 DPI
- **Margins**: 25mm minimum
- **Color**: CMYK with Pantone alternatives

### CMYK Conversions
```
Idun Gold: C:15 M:25 Y:90 K:5
Forest Green: C:75 M:45 Y:100 K:25
Stone Gray: C:20 M:15 Y:20 K:45
```

## Quality Assurance Checklist

### Visual Review
- [ ] Brand colors accurate across devices
- [ ] Typography renders consistently  
- [ ] Images sharp at all sizes
- [ ] Consistent spacing and alignment
- [ ] Proper contrast ratios

### Technical Review  
- [ ] Optimized file sizes
- [ ] Proper format selection
- [ ] Responsive behavior
- [ ] Fast loading times
- [ ] Accessibility compliance

### Brand Compliance
- [ ] Logo usage guidelines followed
- [ ] Color palette consistency
- [ ] Typography hierarchy maintained
- [ ] Icon style coherence
- [ ] Overall brand voice alignment