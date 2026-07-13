# Feature Mapping — splash_screen

> **Feature:** `splash_screen`
> **Date:** 2026-06-25
> **Status:** Done

---

## 1. INPUTS

### 1.1 Sources

| Source | Path |
|--------|------|
| Stitch HTML | `lib/features/splash/splash_design_stitch/code.html` |
| CSS YAML | `lib/features/splash/splash_design_stitch/DESIGN.md` |
| SRS | `lib/features/splash/splash_srs/OBM_splash_srs.docx` |
| Postman Collection | `OBM` (collection `c828d846-f288-4af3-a973-2f249e6d648a`) |

### 1.2 Postman OBM Collection Endpoints

| Name | Method | Endpoint | Notes |
|------|--------|----------|-------|
| login | POST | `/api/v1/auth/login` | Existing — login_service |
| getListOpportunity | — | — | Future feature |
| dashboardController | — | — | Future feature |
| dashboardFilterOptions | — | — | Future feature |

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

| Stitch Section | Flutter Widget | File |
|---------------|---------------|------|
| `<main class="h-screen ... bg-surface ...">` | `Scaffold + Stack` | `body_splash_widget.dart` |
| `<div class="absolute inset-0 bg-surface">` | `Container(color: ColorApp.colorF7F9FB)` | `_BackgroundLayer` |
| `<div class="absolute inset-0 bg-dot-pattern">` | `CustomPaint(_DotPatternPainter)` | `_DotPatternPainter` |
| `<h1 class="text-brand-blue ...">` | `Text('DAS OBM', style: ...)` | `_MainBranding` |
| `<h2 class="uppercase tracking-widest">` | `Text(AppStrings.heThongQuanTriCoHoiDieuHanhKinhDoanh)` | `_SubHeadline` |
| `<p class="italic text-secondary">` | `Text(AppStrings.slogan)` | `_Slogan` |
| Footer attribution | `RichText + Text` | `_FooterContent` |

### 2.2 Color Mapping

| Stitch Token | CSS Hex | ColorApp | Usage |
|-------------|---------|----------|-------|
| `brand-blue` | `#2185d5` | `colorBrandBlue` | Main title "DAS OBM" |
| `surface` / `background` | `#f7f9fb` | `colorF7F9FB` | Background |
| `on-surface-variant` | `#404751` | `color404751` | Sub-headline, footer |
| `secondary` | `#00677f` | `color00677F` | Slogan text |
| `outline` | `#707882` | `color707882` | Enterprise edition mono text |
| `primary` | `#005f9e` | `color005F9E` | "Powered by Trung tâm DAS" |
| Dot pattern | `#cbd5e1` | inline `Color(0xFFCBD5E1)` | `CustomPaint` painter |

### 2.3 Typography Mapping

| Stitch Style | CSS | Flutter TextStyle |
|-------------|-----|-------------------|
| `text-brand-blue text-[64px]` | 64px, w900, -1.28 tracking | `fontSize: 64, w900, letterSpacing: -1.28` |
| `text-on-surface-variant uppercase tracking-widest` | 14px, w700, letterSpacing 1.5 | `fontSize: 14, w700, letterSpacing: 1.5` |
| `text-secondary italic text-xl` | 20px, w500, italic | `fontSize: 20, w500, italic` |
| `font-mono-sm uppercase tracking-widest` | 11px, JetBrains Mono | `fontFamily: 'JetBrains Mono', fontSize: 11` |

### 2.4 Animation Mapping

| Stitch Animation | Flutter Equivalent |
|-----------------|-------------------|
| `fade-in-up` (delay 0.1s) | `TweenAnimationBuilder` with 0.1s implicit duration |
| `fade-in-up` (delay 0.5s) | `TweenAnimationBuilder` with 0.5s implicit duration |

---

## 3. FILE STRUCTURE

```
lib/features/splash/
├── splash_screen.dart          ← Screen entry
├── splash_mapping.md           ← This file
├── DEVELOPMENT_STATUS.md
├── component/
│   ├── splash_provider.dart    ← App init logic (1500ms delay)
│   └── splash_service.dart    ← BaseService stub
├── model/
│   └── splash_model.dart      ← Stub model
└── widget/
    └── body_splash_widget.dart ← UI body (StatelessWidget)
```

---

## 4. i18n STRINGS

All strings already present in all 4 JSON files:

| Key | Vietnamese | English |
|-----|-----------|---------|
| `dasObm` | DAS OBM | DAS OBM |
| `heThongQuanTriCoHoiDieuHanhKinhDoanh` | HỆ THỐNG QUẢN TRỊ CƠ HỘI & ĐIỀU HÀNH KINH DOANH | BUSINESS ADMIN & MANAGEMENT SYSTEM |
| `slogan` | "Đồng hành kiến tạo hành chính số" | "Building digital government together" |
| `poweredByTrungTamDas` | Powered by Trung tâm DAS | Powered by DAS Center |
| `enterpriseEdition` | ENTERPRISE EDITION V4.0 | ENTERPRISE EDITION V4.0 |

---

## 5. ROUTE

| Route | Path | Screen |
|-------|------|--------|
| `/splash` | `RouteGenerator.splash` | `SplashScreen` |

---

## 6. NOTES

- Splash screen is **pure UI / animation** — no API calls required.
- Provider stub generated per `--postman OBM` flag to maintain consistent structure.
- `AppProvider._initializeApp()` handles actual app init delay (1500ms) in `app_provider.dart`.
- `SplashProvider.initialize()` stub ready for future async init logic if needed.
