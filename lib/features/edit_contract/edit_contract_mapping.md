# 📐 Feature Mapping: edit_contract

> **Feature:** Chỉnh sửa hợp đồng (Edit Contract)
> **Variant:** Edit
> **Date:** 2026-07-02
> **Status:** ✅ Dev done, AI review passed

---

## 1. INPUTS

### 1.1 SRS Reference

| Field | Value |
|---|---|
| SRS File | `lib/features/edit_contract/edit_contract_srs/OBM_edit_contract_srs.docx` |
| Endpoint | `PUT http://10.168.6.37:9080/api/v1/contracts/{id}` |
| Scope | Form-based editor reusing AddContract fields & validation |

### 1.2 Figma Design

| Screen | URL | Node ID |
|---|---|---|
| (n/a — Stitch export) | — | — |

### 1.3 User Stories

```
- US-01: As a contract owner, I want to edit an existing contract so that I can update its values when requirements change.
- US-02: As a user, I want the form pre-populated with current contract data so I don't retype everything.
- US-03: As a user, I want validation matching the Add form so I don't save an invalid contract.
```

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

| Figma Screen | Code File | Route |
|---|---|---|
| Edit Contract | `edit_contract_screen.dart` | `/contract-edit` (with `arguments: {'id': int}`) |

### 2.2 Component Mapping

| HTML Section | Code Widget |
|---|---|
| Top sticky header (`arrow_back` + "Chỉnh sửa hợp đồng" + `more_vert`) | Custom `_buildHeader` row in body widget |
| Section 1: Liên kết & Phân loại (collapsible) | `_buildLinkSection` + `_buildSection` wrapper |
| Section 2: Thông tin hợp đồng | `_buildInfoSection` |
| Section 3: Mốc thời gian | `_buildTimelineSection` |
| Section 4: Giá trị (đồng) | `_buildValueSection` (Selector for `computedVnptItValue`) |
| Section 5: Điều khoản & Ghi chú | `_buildTermsSection` |
| Bottom fixed save bar | `_buildBottomActionBar` |

### 2.3 Style Mapping

| HTML Class | Code Token |
|---|---|
| Section header bg | `ColorApp.colorE2F0FB` |
| Section header icon | `ColorApp.color005F9E` |
| Section icon uppercase | `TextStyle(fontSize: 14, fontWeight: w500, letterSpacing: 0.5)` |
| Primary button | `ColorApp.color005F9E` |
| Border 8px | `BorderRadius.circular(8)` |
| Spacing between rows | `SizedBox(height: 12)` |
| Field to label gap | `EdgeInsets.only(bottom: 4)` |

---

## 3. DATA MODELS

### 3.1 Entity Mapping

| API Field | Model | Notes |
|---|---|---|
| `id` | `int?` | Required in PUT path |
| `owningUnitId` | `int?` | Required (validation) |
| `customerId` | `int?` | Resolved via name lookup |
| `name` | `String?` | Required (validation) |
| Dates | `String?` (ISO yyyy-MM-dd) | Parsed to `DateTime?` on hydration |
| Money | `double?` | Parsed from server number |
| `vnptItValue` | `double?` | Auto-computed = `vnptValue × itPercent/100` |

### 3.2 Model Code

```dart
class ContractDetailModel {
  final int? id;
  final int? owningUnitId;
  final String? name;
  // ... 20+ fields matching PUT body
  ContractDetailModel.fromJson(Map<String, dynamic>);
}
```

---

## 4. API MAPPING

| Action | Method | Endpoint |
|---|---|---|
| Load contract | GET | `/api/v1/contracts/{id}` |
| Load filter data | GET | `/api/v1/dashboard/filter-options` + `/opportunities` + `/projects` + `/customers` + `/product-services` |
| Save edit | PUT | `/api/v1/contracts/{id}` |

---

## 5. STATE MANAGEMENT

```
EditContractScreen (BasePageStatefulWidget)
 └── _EditContractScreenState extends BaseStatefulWidgetState<T, EditContractService, EditContractProvider>
 └── BodyEditContractWidget (StatefulWidget — needs TextEditingControllers)
 └── EditContractProvider (extends BaseProvider<EditContractService>)
 ├── currentState: { none, loading, loaded, error, noData }
 ├── Form state: selectedOwningUnitId, ..., contractValue, note
 ├── Filter lists: depts, opportunities, projects, customers, productServices
 ├── Validation: owningUnitError, contractNameError, expiryDateError
 ├── loadContractAndFilters() — fetch contract + filters in parallel
 ├── submit() → service.updateContract(id, body) → toast → navigate back
 └── EditContractService
 ├── getContract(int id) → GET /api/v1/contracts/{id}
 ├── getFilterOptions / getOpportunities / ... (reuses AddContractService internally)
 └── updateContract(int id, body) → PUT /api/v1/contracts/{id}
```

---

## 6. VARIANT DIFFERENCES (vs add_contract)

| Aspect | add_contract | edit_contract |
|---|---|---|
| Header title | "Thêm mới hợp đồng" | "Chỉnh sửa hợp đồng" |
| Submit button | "Lưu hợp đồng" | "Cập nhật hợp đồng" |
| Initial data fetch | Load filters only | Load contract by id + filters |
| Submit method | POST `/contracts` | PUT `/contracts/{id}` |
| Hydration | None (empty form) | Pre-populate from server response |
| Required arg | none | `int contractId` |

---

## 7. FILE STRUCTURE OUTPUT

```
lib/features/edit_contract/
├── edit_contract_screen.dart
├── edit_contract_mapping.md ← File này
├── DEVELOPMENT_STATUS.md
├── component/
│ ├── edit_contract_provider.dart
│ └── edit_contract_service.dart
├── model/
│ └── edit_contract_model.dart
└── widget/
 └── body_edit_contract_widget.dart
```

---

## 8. IMPLEMENTATION NOTES

- **Code reuse**: `EditContractService` composes `AddContractService` to share filter endpoints, avoiding 5x duplicate Dio definitions.
- **Hydration guard**: `BodyEditContractWidget` has `_controllersHydrated` bool to avoid overwriting user-typed values during late filter loading.
- **Dropdown null-safety**: All nullable-value dropdowns include a `value: null` first item to satisfy Flutter's `DropdownButton` requirement.
- **Date auto-format**: `_formatDate()` outputs ISO `yyyy-MM-dd` to match server contract.
- **Status default**: Loads from existing contract — `selectedStatusCode` may be null until `loadContractAndFilters` completes.

---

## 9. REVIEW CHECKLIST

- [x] Screen `extends BasePageStatefulWidget`, State `extends BaseStatefulWidgetState<T,S,P>`
- [x] Provider `extends BaseProvider<EditContractService>`
- [x] Service `extends BaseService`, reuses AddContractService for filter endpoints
- [x] Body widget is StatefulWidget (needed for controllers), uses `Selector` + `context.watch` for narrow rebuild scope
- [x] i18n: 3 new keys (`suaHopDong`, `capNhatHopDong`, `hopDongDaDuocCapNhatThanhCong`)
- [x] Color tokens from CSS all already exist in `color_app.dart` — no append needed
- [x] All controllers disposed in `dispose()`
- [x] `mounted` checked after `await provider.submit()` in widget
- [x] `dart analyze` clean (0 issues)

---

## 🔍 AI Review Summary

| Bug # | Severity | Status |
|---|---|---|
| #1: Customer hydration order (FALSE POSITIVE) | HIGH | ✅ verified correct |
| #2: DropdownMenuItem null-value missing | MEDIUM | ✅ FIXED (owningUnit/opportunity/project) |
| #3: Date field controller leak | MEDIUM | ⚠️ Pre-existing pattern in add_contract, deferred (low impact: controllers auto-GC) |
| #4: AutomaticKeepAliveClientMixin missing | MEDIUM | ⚠️ Pre-existing pattern, deferred |

*Mapped by /vnpt_workflow_stitch2flutter — edit_contract*
