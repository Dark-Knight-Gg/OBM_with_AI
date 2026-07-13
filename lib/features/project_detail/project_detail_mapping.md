# Feature Mapping — project_detail

> **Feature:** Project Detail
> **Variant:** Base
> **Date:** 2026-06-26
> **Status:** Done

> **Variables:** See `_project_config.mdc`.

---

## 1. INPUTS

### 1.1 SRS Reference

|| Field | Value |
|----|----|
| SRS File | `lib/features/project_detail/project_detail_srs/OBM_project_detail_srs.docx` |
| Export Folder | `lib/features/project_detail/` |
| Version | — |
| Owner | — |

### 1.2 Stitch Design

|| File | Path |
|----|---|
| HTML | `lib/features/project_detail/project_detail_design_stitch/code.html` |
| CSS YAML | `lib/features/project_detail/project_detail_design_stitch/DESIGN.md` |

### 1.3 Postman Collection

|| | |
|---|---|
| Collection | OBM (`40297950-c828d846-f288-4af3-a973-2f249e6d648a`) |
| Endpoint | `getProjectDetail` — `GET /api/v1/projects/{id}` |

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

|| Stitch Screen | Code File | Route |
|-----|-----|----|
| Project Detail | `project_detail_screen.dart` | `/project-detail` |

### 2.2 Component Mapping

|| Stitch Element | Code Widget | Notes |
|-----|----|----|
| AppBar + Back button | `AppBar` + `IconButton` | Arrow back icon |
| Project header card | `_ProjectHeader` | Status badge, name, customer |
| Collapsible section | `_CollapsibleSection` | AnimatedRotation + AnimatedCrossFade |
| General info section | `_SectionGeneralInfo` | Info grid with dividers |
| Value section | `_SectionValue` | Currency display |
| Manage at opportunity btn | `_ManageAtOpportunityButton` | OutlinedButton |

### 2.3 Style Mapping

|| Stitch Style | Code Token |
|---|---|
| Background | `Color(0xFFF7F9FB)` — `colorF7F9FB` |
| Primary | `{{BRAND}}` / `Color(0xFF005F9E)` |
| On-surface | `Color(0xFF191C1E)` — `color191C1E` |
| On-surface-variant | `Color(0xFF404751)` — `color404751` |
| Outline-variant | `Color(0xFFC0C7D3)` — `colorC0C7D3` |
| Status badge | `color1A73E8` |
| Customer text | `colorD81B60` |
| Radius | `BorderRadius.circular(12)` |
| Section header bg | `primary-container/10` |

---

## 3. DATA MODELS

### 3.1 Entity Mapping

|| Source | Model | Fields |
|---|----|-----|
| API `/api/v1/projects/{id}` | `ProjectDetailModel` | id, name, description, status, customer, leadUnit, projectManager, productServiceType, field, jiraProjectCode, jiraNote, startDate, endDate, totalExpectedAmount, forecast, valueNote, unitId, unitName |
|| Response | `ProjectDetailResponse` | data, status, message |

### 3.2 Model Code

```dart
class ProjectDetailModel {
  final int? id;
  final String? name;
  final String? status;
  final String? customer;
  final String? leadUnit;
  final String? projectManager;
  final String? productServiceType;
  final String? field;
  final String? jiraProjectCode;
  final String? startDate;
  final String? endDate;
  final double? totalExpectedAmount;
  final double? forecast;
  final String? valueNote;
  ...
}
```

---

## 4. API MAPPING

### 4.1 Endpoint

|| Action | API Endpoint | Method | Service Method |
|-----|-----|-----|----|
| Load Detail | `/api/v1/projects/{id}` | GET | `getProjectDetail(projectId)` |

### 4.2 Request/Response

```
GET /api/v1/projects/4
Headers: Authorization: Bearer <token>
Accept: */*

Response: { "data": { ...ProjectDetailModel }, "status": 200, "message": "..." }
```

---

## 5. STATE MANAGEMENT

```
ProjectDetailScreen (extends BasePageStatefulWidget)
 └── BodyProjectDetailWidget (StatelessWidget + context.select)
 └── ProjectDetailProvider (extends BaseProvider<ProjectDetailService>)
    ├── currentState: StateType
    ├── detail: ProjectDetailModel?
    ├── fetchProjectDetail(int id)
    └── ProjectDetailService (extends BaseService)
        └── Dio GET /api/v1/projects/{id}
```

---

## 6. FILE STRUCTURE OUTPUT

```
lib/features/project_detail/
├── project_detail_screen.dart
├── project_detail_mapping.md
├── DEVELOPMENT_STATUS.md
├── component/
│   ├── project_detail_provider.dart
│   └── project_detail_service.dart
├── model/
│   └── project_detail_model.dart
└── widget/
    └── body_project_detail_widget.dart
```

---

## 7. ROUTE

```
RouteGenerator.projectDetail = '/project-detail'
Case: MultiProvider(ChangeNotifierProvider<ProjectDetailProvider>) → ProjectDetailScreen
```

---

## 8. REVIEW CHECKLIST

- [ ] Screen extends `BasePageStatefulWidget`
- [ ] State extends `BaseStatefulWidgetState<ProjectDetailScreen, ProjectDetailService, ProjectDetailProvider>`
- [ ] `buildBody()` returns `BodyProjectDetailWidget`
- [ ] Provider extends `BaseProvider<ProjectDetailService>`
- [ ] Service extends `BaseService`
- [ ] Model + Response defined
- [ ] i18n keys added (all 4 JSON + AppStrings)
- [ ] Color tokens appended to `color_app.dart`
- [ ] Route registered in `route_generator.dart`
- [ ] No hardcoded Vietnamese strings in code

---

*Mapped by VNPT Workflow CLI — Stitch2Flutter — 2026-06-26*
