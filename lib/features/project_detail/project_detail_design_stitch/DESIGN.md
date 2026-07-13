---
name: Corporate Blue Clarity
colors:
  surface: '#f7f9fb'
  surface-dim: '#d8dadc'
  surface-bright: '#f7f9fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f6'
  surface-container: '#eceef0'
  surface-container-high: '#e6e8ea'
  surface-container-highest: '#e0e3e5'
  on-surface: '#191c1e'
  on-surface-variant: '#404751'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f3'
  outline: '#707882'
  outline-variant: '#c0c7d3'
  surface-tint: '#0061a2'
  primary: '#005f9e'
  on-primary: '#ffffff'
  primary-container: '#0078c7'
  on-primary-container: '#fdfcff'
  inverse-primary: '#9dcaff'
  secondary: '#00677f'
  on-secondary: '#ffffff'
  secondary-container: '#35d4ff'
  on-secondary-container: '#00586d'
  tertiary: '#2a5aa7'
  on-tertiary: '#ffffff'
  tertiary-container: '#4773c2'
  on-tertiary-container: '#fefcff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d1e4ff'
  primary-fixed-dim: '#9dcaff'
  on-primary-fixed: '#001d36'
  on-primary-fixed-variant: '#00497c'
  secondary-fixed: '#b6eaff'
  secondary-fixed-dim: '#4ad6ff'
  on-secondary-fixed: '#001f28'
  on-secondary-fixed-variant: '#004e60'
  tertiary-fixed: '#d8e2ff'
  tertiary-fixed-dim: '#acc7ff'
  on-tertiary-fixed: '#001a40'
  on-tertiary-fixed-variant: '#064490'
  background: '#f7f9fb'
  on-background: '#191c1e'
  surface-variant: '#e0e3e5'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '800'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 30px
    fontWeight: '700'
    lineHeight: '1.3'
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: '1.3'
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
  label-bold:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '700'
    lineHeight: '1.2'
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: '1.2'
  mono-sm:
    fontFamily: JetBrains Mono
    fontSize: 12px
    fontWeight: '400'
    lineHeight: '1.2'
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: '1.3'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  container-padding: 40px
  gutter-md: 16px
  stack-sm: 8px
  stack-md: 24px
  stack-lg: 48px
---

## Brand & Style

This design system embodies a **Modern Corporate** aesthetic tailored for Vietnamese enterprise and administrative environments. It conveys reliability, precision, and digital transformation. The visual narrative centers on clarity and trust, utilizing a sophisticated blue-centric palette that signifies authority and technological progress.

The interface leverages a "Split-Screen" layout for entry points, contrasting a dynamic, patterned gradient area for storytelling with a clean, focused white workspace for interaction. Key characteristics include:
- **Atmospheric Depth:** Large-scale gradients and subtle dot patterns create a sense of expansive digital space.
- **Precision Typography:** Clean, sans-serif layouts with strict hierarchical alignment to ensure readability of complex Vietnamese characters.
- **Soft Focus Surfaces:** High-radius containers with deep, diffused shadows that lift critical functional blocks from the background.

## Colors

The palette is anchored in a professional blue spectrum, ranging from deep royal tones to vibrant cyan. 

- **Primary:** A medium-vibrant blue used for primary actions and brand presence.
- **Secondary:** A bright cyan used exclusively in gradients and interactive highlights to add energy.
- **Tertiary:** A deep navy used for high-contrast text and branding.
- **Neutral:** A foundation of clean whites and cool-toned grays to maintain an institutional and organized feel.
- **Success/Feedback:** Muted sage greens are used for status indicators, ensuring they remain legible without disrupting the primary blue brand identity.

Gradients should be applied with a linear transition at approximately 135 degrees, blending the primary and secondary colors.

## Typography

This design system utilizes **Inter** as the primary typeface to ensure exceptional legibility for Vietnamese diacritics and technical terminology. 

The hierarchy is "bottom-heavy," where body text and labels are kept clean and small to allow for complex data density, while "Display" styles use heavy weights (ExtraBold/Black) to establish a firm brand presence. Monospaced accents (e.g., JetBrains Mono) are permitted for system technicalities, such as demo credentials or ID strings.

## Layout & Spacing

The layout philosophy follows a **Fixed Container** model for functional components (like login cards) and a **Fluid Fluid** model for background canvases. 

- **Grid:** A 12-column grid is used for dashboard layouts, but entry screens utilize a centered 480px max-width container.
- **Rhythm:** Spacing follows a 4px baseline. Vertical stacking relies on generous "Stack-LG" (48px) units for separating major sections, while "Stack-SM" (8px) is used for label-to-input relationships.
- **Responsiveness:** On mobile devices, the split-screen layout collapses to a single column, prioritizing the functional white card. Side margins reduce from 40px to 16px.

## Elevation & Depth

Hierarchy is established through **Ambient Shadows** and **Z-axis Layering**.

- **Level 0 (Floor):** High-saturation blue gradients with low-opacity geometric dot patterns (opacity 0.1).
- **Level 1 (Surface):** Pure white containers.
- **Shadow Profile:** Surfaces utilize a complex shadow to mimic soft studio lighting: 
  - `0px 10px 40px rgba(0, 0, 0, 0.08)` 
  - `0px 2px 10px rgba(0, 0, 0, 0.04)`
- **Interactive Depth:** Buttons use a tighter, more saturated shadow tinted with the primary blue to appear "pressed" or "active" against the white surface.

## Shapes

The design system employs a **Rounded** shape language to soften the institutional feel of the corporate branding.

- **Primary Containers:** 24px (1.5rem) border radius for main cards.
- **Form Elements:** 8px (0.5rem) border radius for input fields and buttons to balance friendliness with professional structure.
- **Icons:** Enclosed in circular or 12px rounded-square containers with low-opacity fills to create visual anchors.

## Components

### Buttons
Primary buttons use a **linear gradient** (Primary to Secondary) with white text and an integrated icon for directional actions. Transitions should include a subtle scale-down effect (0.98) on click.

### Input Fields
Inputs are defined by a light gray border (#E2E8F0) and an 8px radius. They must include:
- **Left-aligned icons:** Light gray icons to provide visual context without competing with the input text.
- **Labeling:** Bold, 14px labels positioned 8px above the field.
- **Placeholder text:** Muted gray, using the `body-md` typography style.

### Cards
Cards are the primary structural element. They must be pure white, contain at least 40px of internal padding, and utilize the defined Level 1 shadow profile.

### Status Alerts
Success messages use a subtle green background (#D1E7DD) with dark green text and a leading check-circle icon, spanning the full width of the container internal padding.

### Feature Lists
Items in lists should use a horizontal layout: a 40px rounded-square icon container (20% white opacity on blue backgrounds) followed by clear, high-contrast text.