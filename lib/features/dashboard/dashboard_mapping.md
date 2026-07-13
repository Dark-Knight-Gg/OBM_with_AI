# 📐 Feature Mapping — Dashboard Screen

> **Feature:** Dashboard Screen
> **Variant:** — (main screen)
> **Date:** 2026-06-25
> **Status:** Done

> **Variables:** This file uses `{{VARIABLE}}` tokens resolved from `_project_config.mdc`.

---

## 1. INPUTS

### 1.1 SRS Reference

| Field | Value |
|-------|-------|
| SRS File | `lib/features/dashboard/dashboard_srs/OBM_dashboard_srs.docx` |
| Version | — |
| Owner | — |

### 1.2 Stitch Design

| Screen | HTML File | CSS File |
|--------|-----------|----------|
| Dashboard Screen | `dashboard_screen_design/code.html` | `dashboard_screen_design/DESIGN.md` |

### 1.3 Postman Collection

| Collection | API Endpoint | Method |
|-----------|-------------|--------|
| OBM | `http://10.168.6.37:9080/api/v1/dashboard` | GET |
| OBM | `http://10.168.6.37:9080/api/v1/dashboard/filter-options` | GET |

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

| Design Screen | Code File | Route |
|--------------|-----------|-------|
| Dashboard Screen | `dashboard_screen.dart` | `/dashboard` |

### 2.2 Component Mapping

| Design Element | Code Widget | Props |
|---------------|------------|-------|
| TopAppBar | `_TopAppBar` (inline) | — |
| Brand Title | `_BrandTitle` (inline) | AppStrings.dasObm |
| Notification Badge | `_NotificationBadge` (inline) | hasUnread, onTap |
| DAS Center Badge | `_DasCenterBadge` (inline) | — |
| Profile Avatar | `_ProfileAvatar` (inline) | — |
| Filter Toggle | `_FilterSection` / `_FilterToggleRow` | showFilters, toggleFilters |
| Filter Form | `_FilterForm` / `_YearDropdown`, etc. | provider |
| Revenue Info Banner | `_RevenueInfoBanner` | — |
| Stat Cards Grid | `_StatCardsGrid` / `_StatCard` | dashboardData |
| Revenue Trend Chart | `_RevenueTrendChart` / `_ChartBar` | barHeights, monthLabels |

### 2.3 Style Mapping

| Design Token | Code Token |
|-------------|-----------|
| Primary (#005F9E) | `ColorApp.color005F9E` |
| Secondary (#0078C7) | `ColorApp.color0078C7` |
| Success Green (#12B76A) | `ColorApp.color12B76A` |
| Warning Orange (#F79009) | `ColorApp.colorF79009` |
| Error Red (#F04438) | `ColorApp.colorF04438` |
| Surface (#F7F9FB) | `ColorApp.colorF7F9FB` |
| On Surface (#191C1E) | `ColorApp.color191C1E` |
| On Surface Variant (#404751) | `ColorApp.color404751` |
| Outline Variant (#C0C7D3) | `ColorApp.colorC0C7D3` |
| Border Radius (12px) | `BorderRadius.circular(12)` |
| Border Radius (8px) | `BorderRadius.circular(8)` |
| Soft Shadow | `BoxShadow(blurRadius: 20, offset: (0,4))` |

---

## 3. DATA MODELS

### 3.1 Entity Mapping

| Design Data | Model | Fields |
|------------|-------|--------|
| Dashboard KPI | `DashboardData` | totalRevenueActual, totalOrderValue, expectedRevenue, totalResources, openRisks, revenueByMonth |
| Filter Options | `FilterOptionsData` | years, priceTypes, units, departments, productServices |
| Revenue Month | `RevenueMonthData` | label, value |

### 3.2 Model Code

```dart
class DashboardData {
  final double? totalRevenueActual;
  final double? totalOrderValue;
  final double? expectedRevenue;
  final int? totalResources;
  final int? openRisks;
  final List<RevenueMonthData>? revenueByMonth;
}
```

---

## 4. API MAPPING

### 4.1 Endpoint Mapping

| Action | API Endpoint | Method | Service Method |
|--------|-------------|--------|---------------|
| Load Dashboard | `/api/v1/dashboard` | GET | `getDashboardData()` |
| Load Filter Options | `/api/v1/dashboard/filter-options` | GET | `getFilterOptions()` |

### 4.2 Request/Response

```json
// GET /api/v1/dashboard?year=2026&priceType=Doanh thu chủ quản
// Response
{
  "data": {
    "totalRevenueActual": 6000000000,
    "totalOrderValue": 595000000,
    "expectedRevenue": 5000000,
    "totalResources": 9,
    "openRisks": 6,
    "revenueByMonth": [
      {"label": "T1", "value": 400000000},
      ...
    ]
  }
}
```

---

## 5. STATE MANAGEMENT

```
DashboardScreen (extends {{SCREEN_BASE_CLASS}})
 └── BodyDashboardWidget (StatelessWidget)
 └── {{CONSUMER_BASE}}<DashboardService, DashboardProvider>
     (handles loading/error/noData via buildRoot)
 └── DashboardProvider (extends {{PROVIDER_BASE}}<DashboardService>)
     ├── selectedYear, selectedPriceType, selectedUnit, etc.
     ├── showFilters (bool)
     ├── dashboardData (DashboardData?)
     ├── revenueBarHeights (List<double>)
     └── revenueMonthLabels (List<String>)
 └── DashboardService (extends {{SERVICE_BASE}})
     └── Dio HTTP → /api/v1/dashboard
```

---

## 6. FILE STRUCTURE OUTPUT

```
lib/features/dashboard/
├── dashboard_screen.dart
├── dashboard_mapping.md ← this file
├── component/
│ ├── dashboard_provider.dart
│ └── dashboard_service.dart
├── model/
│ └── dashboard_model.dart
└── widget/
    └── body_dashboard_widget.dart
```

---

## 7. IMPLEMENTATION NOTES

- **Import core:** `import 'package:obm_gen_with_ai/core/constants/color_app.dart';`
- **Colors:** Use `ColorApp.color*` from Stitch Design System tokens
- **Text:** Use `AppStrings.*` (all strings already in 4 JSON files + AppStrings class)
- **State:** Provider `extends {{PROVIDER_BASE}}`, state via `showLoading/showLoaded/showError`
- **Filter collapse:** `showFilters` bool in provider, animated via `AnimatedCrossFade`
- **Chart bars:** Heights computed as `value / maxValue` (relative), rendered via `LayoutBuilder`
- **Stat card values:** Default mock values shown when `dashboardData` is null
- **No hardcoded colors** — all colors mapped to `ColorApp.*` tokens

---

## 8. REVIEW CHECKLIST

- [ ] Screen `extends BasePageStatefulWidget`, State `extends BaseStatefulWidgetState`
- [ ] `buildBody()` returns `BodyDashboardWidget`
- [ ] All user-facing strings via `AppStrings.*`
- [ ] All colors via `ColorApp.*` tokens
- [ ] No hex literals inline
- [ ] `AnimatedCrossFade` for filter section expand/collapse
- [ ] Provider `extends BaseProvider`, service `extends BaseService`
- [ ] Dio calls only in service, not in provider
- [ ] `fetchDashboardData()` in `onStart()` override
- [ ] Error toast via `showToast()` from provider
- [ ] `mounted` check not needed (provider doesn't store context)

---

*Mapped by Stitch2Flutter Workflow — 2026-06-25*
