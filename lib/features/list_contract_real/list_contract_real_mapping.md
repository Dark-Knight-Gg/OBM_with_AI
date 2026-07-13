# 📐 Feature Mapping — list_contract_real

> **Feature:** `list_contract_real`
> **Date:** 2026-06-26
> **Status:** Draft → Approved

---

## 1. INPUTS

### 1.1 Stitch Design

|| File | Path |
|----|----|
| HTML Export | `lib/features/list_contract_real/list_contract_real_design_stitch/code.html` |
| Design Tokens | `lib/features/list_contract_real/list_contract_real_design_stitch/DESIGN.md` |

### 1.2 Postman

> ⚠️ Postman MCP did not return OBM collection. API endpoints modeled from HTML UI and `list_contract` feature.

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

|| Design | Code File | Route |
|----|----|----|---|
| Contract List | `list_contract_real_screen.dart` | `/list-contract-real` |

### 2.2 Component Mapping

|| Design Element | Code Widget |
|----|----|----|
| TopAppBar (menu + title + avatar) | Handled by drawer/app wrapper |
| Search bar | `TextField` with `Icons.search` |
| Filter button | GestureDetector → bottom sheet |
| Contract cards | `ItemContractWidget` |
| Status badge | Colored `Container` with `BorderRadius.circular(8)` |
| Value display | `Text` with `fontSize: 20, fontWeight: w800` |
| Edit button | `_ActionButton(icon: Icons.edit_outlined)` |
| Delete button | `_ActionButton(icon: Icons.delete_outline, isDanger: true)` |
| FAB | `Container` with gradient (`primary` → `primary-container`) |

### 2.3 Style Mapping

|| Stitch Token | Code Value |
|---|---|
| `primary` (#005f9e) | `Color(0xFF005F9E)` |
| `on-surface` (#191c1e) | `Color(0xFF191C1E)` |
| `outline-variant` (#c0c7d3) | `Color(0xFFC0C7D3)` |
| `outline` (#707882) | `Color(0xFF707882)` |
| `surface-container-low` (#f2f4f6) | `Color(0xFFF2F4F6)` |
| `surface-container-lowest` (#ffffff) | `Colors.white` |
| `error` (#ba1a1a) | `Color(0xFFBA1A1A)` |
| label-bold | `TextStyle(fontSize: 14, fontWeight: w700)` |
| label-sm | `TextStyle(fontSize: 12, fontWeight: w500)` |
| border-radius-xl | `BorderRadius.circular(12)` |

---

## 3. DATA MODELS

### 3.1 ContractModel

```dart
class ContractModel {
  final int? id;
  final String? contractNumber;
  final String? name;
  final String? customerName;
  final String? signingDate;
  final String? contractType;
  final String? unitName;
  final String? linkedProject;
  final double? value;
  final String? statusCode;
  final String? statusLabel;
}
```

### 3.2 API Mapping

|| Action | API | Method |
|----|----|----|-------|
| List contracts | `/api/v1/contracts` | GET |
| Delete contract | `/api/v1/contracts/{id}` | DELETE |

---

## 4. STATE MANAGEMENT

```
ListContractRealScreen (extends BasePageStatefulWidget)
 └── BodyListContractRealWidget (StatefulWidget)
     └── ConsumerBase<ListContractRealService, ListContractRealProvider>
         Provider watches: contracts, selectedStatus, keyword, hasMore
 └── ListContractRealProvider (extends BaseProvider<ListContractRealService>)
     ├── contracts: List<ContractModel>
     ├── keyword, selectedStatus, currentPage, hasMore
     └── loadContracts(), searchContracts(), deleteContract()
 └── ListContractRealService (extends BaseService)
     ├── getContracts(page, keyword, status) → ContractResponse
     └── deleteContract(id) → void
```

---

## 5. FILE STRUCTURE

```
lib/features/list_contract_real/
├── list_contract_real_screen.dart
├── list_contract_real_mapping.md ← this file
├── component/
│ ├── list_contract_real_service.dart
│ └── list_contract_real_provider.dart
├── model/
│ └── list_contract_real_model.dart
└── widget/
    ├── body_list_contract_real_widget.dart
    └── item_contract_widget.dart
```

---

## 6. i18n KEYS ADDED

| Key | VI | EN |
|-----|----|----|
| `hopDong` | Hợp đồng | Contract |
| `soHd` | Số HĐ | Contract No. |
| `ngayKy` | Ngày ký | Signing Date |
| `loai` | Loại | Type |
| `lienKet` | Liên kết | Linked |
| `giaTri` | Giá trị | Value |
| `timKiemHopDong` | Tìm kiếm hợp đồng... | Search contracts... |
| `khongCoHopDong` | Không có hợp đồng nào | No contracts found |
| `hienThiSoHopDong(count)` | Hiển thị {count} hợp đồng | Showing {count} contracts |
| `xoa` | Xóa | Delete |
| `xacNhanXoa` | Xác nhận xóa | Confirm Delete |
| `xoaHopDongThanhCong(name)` | Đã xóa hợp đồng thành công | Contract deleted successfully |
| `banCoChacChanMuonXoaHopDong(name)` | Bạn có chắc chắn muốn xóa...? | Are you sure you want to delete...? |

---

## 7. ROUTE

```
RouteGenerator.listContractReal = '/list-contract-real'
RouteGenerator.contractEdit = '/contract-edit' (TODO: implement contract edit screen)
Navigation: Navigator.pushNamed(context, RouteGenerator.listContractReal)
```

---

*Mapped by VNPT Stitch2Flutter Workflow — Auto-generated*
