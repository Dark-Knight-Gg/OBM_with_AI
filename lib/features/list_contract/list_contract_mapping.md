# 📐 Feature Mapping — list_contract

> **Feature:** Quản lý Dự án (Project Management List)
> **Variant:** Stitch2Flutter — Corporate Blue Clarity Design
> **Date:** 2026-06-25
> **Status:** Done → Review

> **Variables:** `{{FEATURES_PATH}}` = `lib/features/`

---

## 1. INPUTS

### 1.1 SRS Reference

| Field | Value |
|----|-----|
| SRS File | `lib/features/list_contract/list_contract_srs/OBM_list_contract_srs.docx` |
| Version | v2.8.0 |
| Owner | DAS OBM Team |

### 1.2 Stitch Design

| File | Path |
|----|-----|
| HTML | `lib/features/list_contract/list_contract_stitch_design/list_contract_design/code.html` |
| CSS YAML | `lib/features/list_contract/list_contract_stitch_design/list_contract_design/DESIGN.md` |

### 1.3 Postman Collection

| Collection | ID |
|----|-----|
| OBM | `c828d846-f288-4af3-a973-2f249e6d648a` |

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

| Design Screen | Code File | Route |
|-----|-----|-----|
| Project List | `list_contract_screen.dart` | `/list-contract` |

### 2.2 Component Mapping

| Design Component | Code Widget | Notes |
|-----|-----|-----|
| TopAppBar | In `body_list_contract_widget.dart` `_buildHeader()` | Search bar + filter button |
| Search Input | `TextField` with search icon | Debounce 500ms via `_onSearchChanged` |
| Filter Button | IconButton (tune) | Opens `_showFilterBottomSheet()` |
| Project Summary | Text via `hienThiCongDuAn()` | Shows "Hiển thị X dự án" |
| Project Card | `ItemProjectWidget` | Full card with metadata, progress, forecast |
| FAB Add | IconButton (add) | Positioned fixed bottom-right |
| Filter BottomSheet | `showModalBottomSheet` | Status, Unit filters |
| Progress Bar | `LinearProgressIndicator` | Shows project progress % |
| Action Row | `_ActionButton` | Edit + View buttons |
| Status Badge | Container with colored left border | Maps `statusBadge` to color |

### 2.3 Style Mapping (Stitch → Flutter)

| Stitch Token | CSS Value | Flutter / ColorApp |
|---|---|---|
| `surface` / `background` | `#f7f9fb` | `Color(0xFFF7F9FB)` |
| `primary` | `#005f9e` | `Color(0xFF005F9E)` |
| `on-surface` | `#191c1e` | `Color(0xFF191C1E)` |
| `on-surface-variant` | `#404751` | `Color(0xFF404751)` |
| `outline` | `#707882` | `Color(0xFF707882)` |
| `outline-variant` | `#c0c7d3` | `Color(0xFFC0C7D3)` |
| `surface-container-low` | `#f2f4f6` | `Color(0xFFF2F4F6)` |
| `surface-container` | `#eceef0` | `Color(0xFFECEEF0)` |
| `tertiary` | `#2a5aa7` | `Color(0xFF2A5AA7)` |
| `tertiary-container` | `#4773c2` | `Color(0xFF4773C2)` |
| `error` | `#ba1a1a` | `Color(0xFFBA1A1A)` |
| Typography `headline-lg-mobile` | 24px/700 | `TextStyle(fontSize:24, fontWeight:w700)` |
| Typography `label-bold` | 14px/700 | `TextStyle(fontSize:14, fontWeight:w700)` |
| Typography `body-md` | 14px/400 | `TextStyle(fontSize:14, fontWeight:w400)` |
| Typography `label-sm` | 12px/500 | `TextStyle(fontSize:12, fontWeight:w500)` |
| Typography `mono-sm` | 12px/400 mono | `TextStyle(fontFamily:JetBrains Mono, fontSize:12)` |
| Spacing `container-padding` | 16px | `EdgeInsets.fromLTRB(16,8,16,8)` |
| Spacing `stack-sm` | 8px | `SizedBox(height:8)` |
| Spacing `stack-md` | 24px | `SizedBox(height:24)` |
| Spacing `gutter-md` | 16px | `SizedBox(width:16)` |
| Radius `xl` | 0.75rem=12px | `BorderRadius.circular(12)` |
| Radius `lg` | 0.5rem=8px | `BorderRadius.circular(8)` |

---

## 3. DATA MODELS

### 3.1 Entity: `ListContractModel`

| Field | Type | Source |
|---|---|---|
| `id` | `int?` | API `id` |
| `code` | `String?` | API `code` |
| `name` | `String?` | API `name` |
| `customerName` | `String?` | API `customerName` |
| `owningUnitName` | `String?` | API `owningUnitName` |
| `projectManagerName` | `String?` | API `projectManagerName` |
| `statusLabel` | `String?` | API `statusLabel` |
| `statusBadge` | `String?` | API `statusBadge` |
| `estimatedValue` | `double?` | API `estimatedValue` |
| `forecastRevenue` | `double?` | API `forecastRevenue` |
| `progress` | `int?` | API `progress` (computed from SRS) |
| `opportunityId` | `int?` | API `opportunityId` |
| `opportunityCode` | `String?` | API `opportunityCode` |
| `startDate` | `String?` | API `startDate` |
| `endDate` | `String?` | API `endDate` |

### 3.2 Entity: `DeptModel` (Filter Options)

| Field | Type | Source |
|---|---|---|
| `id` | `int?` | API `depts[].id` |
| `name` | `String?` | API `depts[].name` |
| `parentId` | `int?` | API `depts[].parentId` |

### 3.3 Static Status Config

| Code | Label | Badge |
|---|---|---|
| `PLANNING` | Lập kế hoạch | bg-secondary |
| `IN_PROGRESS` | Đang thực hiện | bg-primary |
| `ON_HOLD` | Tạm dừng | bg-warning |
| `COMPLETED` | Hoàn thành | bg-success |
| `CANCELLED` | Đã hủy | bg-secondary |

---

## 4. API MAPPING

### 4.1 Endpoint: GET `/api/v1/projects`

| Action | Method | Path | Query Params |
|-----|-----|-----|-----|
| Load List | GET | `/api/v1/projects` | `page`, `size`, `keyword`, `status`, `field`, `unitId` |
| Load More | GET | `/api/v1/projects` | Same as above, `page+1` |
| Search | GET | `/api/v1/projects` | `keyword=value`, `page=0` |
| Filter | GET | `/api/v1/projects` | Combined params, `page=0` |

### 4.2 Endpoint: GET `/api/v1/dashboard/filter-options`

| Action | Method | Path | Notes |
|-----|-----|-----|-----|
| Load Filter Options | GET | `/api/v1/dashboard/filter-options` | Extracts `depts[]` array |

### 4.3 Request / Response

```json
// GET /api/v1/projects?page=0&size=20&keyword=&status=&field=&unitId=
{
  "content": [
    {
      "id": 4,
      "code": "NENTANGCCVCQG",
      "name": "Nền tảng Công chức viên chức Quốc gia",
      "customerName": "Bộ Nội Vụ",
      "owningUnitName": "Line Công chức viên chức",
      "projectManagerName": null,
      "statusLabel": "Đang thực hiện",
      "statusBadge": "bg-primary",
      "estimatedValue": 6000000000.00,
      "forecastRevenue": 6000000000.00,
      "startDate": "2026-06-17",
      "opportunityCode": "NENTANGCCVCQG"
    }
  ],
  "page": 0,
  "size": 20,
  "totalElements": 2,
  "totalPages": 1,
  "last": true
}
```

---

## 5. STATE MANAGEMENT

```
ListContractScreen (extends BasePageStatefulWidget)
 └── _ListContractScreenState (extends BaseStatefulWidgetState)
      └── buildBody() → BodyListContractWidget (StatefulWidget)
           └── ConsumerBase<S,P> → handles loading/error/noData/success
                ├── ListContractProvider (extends BaseProvider<ListContractService>)
                │    ├── projects: List<ListContractModel>
                │    ├── depts: List<DeptModel>
                │    ├── keyword, selectedStatus, selectedField, selectedUnitId
                │    ├── currentPage, hasMore
                │    ├── loadProjects(), loadMoreProjects()
                │    ├── searchProjects(value), applyFilters(...)
                │    └── loadFilterOptions()
                └── ListContractService (extends BaseService)
                     ├── getProjects(page, keyword, status, field, unitId)
                     └── getFilterOptions()
```

### Provider Methods

| Method | Action |
|-----|-----|
| `loadProjects()` | Initial load, page=0 |
| `loadMoreProjects()` | Append next page |
| `searchProjects(value)` | Debounced search, page=0 |
| `applyFilters(...)` | Apply BottomSheet filters, page=0 |
| `clearFilters()` | Reset all filters |
| `loadFilterOptions()` | Load depts from `/filter-options` |

---

## 6. FILE STRUCTURE OUTPUT

```
lib/features/list_contract/
├── list_contract_screen.dart         ← Entry point (BasePageStatefulWidget)
├── component/
│   ├── list_contract_service.dart   ← API layer (BaseService)
│   └── list_contract_provider.dart  ← State management (BaseProvider)
├── model/
│   └── list_contract_model.dart     ← Data models + Response types
└── widget/
    ├── body_list_contract_widget.dart  ← Main body widget
    └── item_project_widget.dart         ← Project card component
```

---

## 7. IMPLEMENTATION NOTES

- **Search Debounce:** 500ms timer in `_onSearchChanged`, cancelled on each keystroke.
- **Load More:** `NotificationListener<ScrollNotification>` detects scroll end → calls `loadMoreProjects()`.
- **Pull-to-Refresh:** `RefreshIndicator` in `_buildList()` calls `loadProjects()`.
- **Filter BottomSheet:** Uses `showModalBottomSheet` with `StatefulBuilder` for temp state management. Calls `provider.applyFilters()` on "Áp dụng" and `provider.clearFilters()` on "Huỷ".
- **Status Color:** Maps `statusBadge` string to `ColorApp` constants (primary/tertiary/success/warning).
- **Progress Bar:** `LinearProgressIndicator` with `value: progress/100`, background `Color(0xFFECEEF0)`.
- **Forecast Currency:** `formattedForecastRevenue` getter in model formats large numbers (B, M, K).
- **No Delete:** SRS explicitly states no delete button on this screen.

---

## 8. REVIEW CHECKLIST

- [ ] `BasePageStatefulWidget` + `BaseStatefulWidgetState` pattern followed
- [ ] `ConsumerBase` handles loading/error/noData/success at page level
- [ ] Debounce 500ms on search input
- [ ] Load more triggered by `ScrollEndNotification` near bottom
- [ ] Pull-to-refresh via `RefreshIndicator`
- [ ] Filter BottomSheet with Status + Unit filters
- [ ] Filter params combined with search keyword on apply
- [ ] All API strings via `AppStrings.*` (no hardcoded Vietnamese)
- [ ] All color tokens use `Color(0xFF...)` from Stitch design
- [ ] `ListContractModel` parses `progress` from response
- [ ] `ListContractService` uses `BaseService` + injected `Dio`
- [ ] Provider uses `showLoading/showLoaded/showError/showNoData` state transitions
- [ ] Routes added to `route_generator.dart` with `MultiProvider`

---

*Mapped by VNPT Stitch2Flutter Workflow — 2026-06-25*
