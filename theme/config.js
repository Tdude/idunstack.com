// IdunWorks Theme Configuration
export default {
  name: 'idunworks',
  extends: 'default',
  
  // Color scheme
  colors: {
    primary: '#1a1a2e',
    accent: '#16213e', 
    background: '#ffffff',
    text: '#333333',
    cta: '#2563eb',
    tech: '#f59e0b'
  },
  
  // Typography
  typography: {
    headingFont: 'Inter, sans-serif',
    bodyFont: 'Inter, sans-serif',
    headingWeight: '600',
    bodyWeight: '400'
  },
  
  // Layout
  layout: {
    containerMaxWidth: '1200px',
    sectionPadding: '4rem',
    heroHeight: 'large'
  },
  
  // Component overrides
  overrides: {
    components: ['Home', 'Header'], // Components we'll customize
    styles: ['colors.css', 'idunworks.css'] // Additional stylesheets
  },
  
  // Assets
  assets: {
    logo: '/assets/idunworks-logo.svg',
    favicon: '/assets/favicon.ico',
    ogImage: '/assets/og-image.jpg'
  }
};