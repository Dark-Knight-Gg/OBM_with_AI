# 📐 Feature Mapping — Contract Detail

> **Feature:** Contract Detail
> **Variant:** —
> **Date:** 2026-06-26
> **Status:** Draft → Approved

> **Variables:** This file uses `{{VARIABLE}}` tokens resolved from `_project_config.mdc`.

---

## 1. INPUTS

### 1.1 SRS Reference

| Field | Value |
|----|---|
| SRS File | `lib/features/contract_detail/contract_detail_srs/OBM_contract_detail_srs.docx` |
| Version | v1.0.0 |
| Date | 26/06/2026 |

### 1.2 Stitch Design

| File | Path |
|----|------|
| HTML | `lib/features/contract_detail/contract_detail_design_stitch/code.html` |
| CSS (YAML) | `lib/features/contract_detail/contract_detail_design_stitch/DESIGN.md` |

### 1.3 API (SRS)

| Endpoint | Method |
|---|---|
| `/api/v1/contracts/{id}` | GET |

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

| Design Screen | Code File | Route |
|---|---|---|
| Contract Detail | `contract_detail_screen.dart` | `/contract-detail` |

### 2.2 Component Mapping

| UI Element | Code Widget |
|---|---|
| Header (fixed) | `AppBar` in `body_contract_detail_widget.dart` |
| Summary Block | `_SummarySection` widget |
| Status Badge | `_StatusBadge` widget |
| Accordion Sections | `_AccordionSection` widget |
| Link Classification | `_LinkClassificationContent` |
| Contract Info | `_ContractInfoContent` |
| Timeline | `_TimelineContent` |
| Value | `_ValueContent` |
| Terms | `_TermsContent` |
| Label/Value Row | `_LabelValue`, `_RowLabelValue`, `_LinkLabelValue` |

### 2.3 Style Mapping

| Design Style | Code Token |
|---|---|
| Primary blue | `ColorApp.color005F9E` |
| On surface | `ColorApp.color191C1E` |
| On surface variant | `ColorApp.color404751` |
| Success badge bg | `ColorApp.colorD1E7DD` |
| Success badge text | `ColorApp.color0F5132` |
| Error | `ColorApp.colorBA1A1A` |
| Surface container low | `ColorApp.colorF2F4F6` |
| Outline variant | `ColorApp.colorC0C7D3` |
| Primary fixed | `ColorApp.colorD1E4FF` |
| Background | `ColorApp.colorF7F9FB` |

---

## 3. DATA MODELS

### 3.1 Contract Detail Model

```dart
class ContractDetailModel {
  int? id;
  String? name;
  String? contractNo;
  String? owningUnitName;
  String? customerName;
  String? productServiceName;
  String? opportunityName;
  int? opportunityId;
  String? projectName;
  int? projectId;
  String? regionLabel;
  String? fieldLabel;
  String? typeLabel;
  String? statusLabel;
  String? statusBadge;
  String? signedDate;
  String? acceptanceDate;
  String? expiryDate;
  String? bindingTerms;
  double? contractValue;
  int? durationMonths;
  String? kmsLink;
  String? managerName;
  double? vnptValue;
  double? itPercent;
  double? vnptItValue;
  String? note;
  List<RevenueModel>? revenues;
}
```

---

## 4. API MAPPING

### 4.1 Endpoint

| Action | Endpoint | Method |
|---|---|---|
| Load contract detail | `/api/v1/contracts/{id}` | GET |

### 4.2 Response

```json
{
  "id": 3,
  "name": "Hợp đồng cho hệ thống GQ TTHC của Đảng",
  "contractNo": "123456",
  "statusLabel": "Đang hiệu lực",
  "statusBadge": "#198755",
  ...
}
```

---

## 5. STATE MANAGEMENT

```
ContractDetailScreen (extends {{SCREEN_BASE_CLASS}})
 └── BodyContractDetailWidget (StatelessWidget + context.watch)
 └── ContractDetailProvider (extends {{PROVIDER_BASE}}<ContractDetailService>)
     ├── contract: ContractDetailModel?
     ├── isExpiringSoon: bool
     ├── loadContractDetail(id)
     ├── formatCurrency(), formatDate(), formatPercent()
     └── orEmpty()
 └── ContractDetailService (extends {{SERVICE_BASE}})
     └── getContractDetail(id)
```

---

## 6. FILE STRUCTURE

```
lib/features/contract_detail/
├── contract_detail_screen.dart
├── contract_detail_mapping.md
├── DEVELOPMENT_STATUS.md
├── component/
│   ├── contract_detail_provider.dart
│   └── contract_detail_service.dart
├── model/
│   └── contract_detail_model.dart
└── widget/
    └── body_contract_detail_widget.dart
```

---

## 7. ROUTE

| Route | Value |
|---|---|
| `contractDetail` | `/contract-detail` |

**Navigation arguments:** `int id` (contract ID)

---

## 8. i18n KEYS ADDED

- `chiTietHopDong`, `lienKetVaPhanLoai`, `thongTinHopDong`, `mocThoiGian`
- `dieuKhoanVaGhiChu`, `spDvCungCap`, `diaBan`, `duAn`
- `soHopDong`, `loaiHopDong`, `nhanSuChuyenQuan`, `thoiGianThueBhThang`
- `ngayKyHd`, `ngayNghiemThuVaoSd`, `hetHanHdBhbt`
- `giaTriHd`, `giaTriVeVnpt`, `tiLeVeIt`, `tongGiaTriVnptIt`
- `dieuKhoanRangBuoc`, `dashDash`, `hopDongKhongTonTai`

---

*Mapped by VNPT Stitch2Flutter Workflow*
