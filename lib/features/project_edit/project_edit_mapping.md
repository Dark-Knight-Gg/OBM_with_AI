# 📐 Feature Mapping — project_edit

> **Feature:** `project_edit`
> **Date:** 2026-06-26
> **Status:** Draft → Approved

---

## 1. INPUTS

### 1.1 SRS Reference

|| Field | Value |
|----|----|
| SRS File | `lib/features/project_edit/project_edit_srs/OBM_project_edit.docx` |
| Export Folder | `lib/features/project_edit/` |

### 1.2 Stitch Design

|| File | Path |
|----|----|
| HTML Export | `lib/features/project_edit/project_edit_design_stitch/code.html` |
| Design Tokens | `lib/features/project_edit/project_edit_design_stitch/DESIGN.md` |

### 1.3 Postman

|| Collection | Endpoint | Method |
|----|----|----|
| OBM | `/api/v1/projects/{id}` | `PUT` (editProject) |

---

## 2. DESIGN → CODE MAPPING

### 2.1 Screen Mapping

|| Design | Code File | Route |
|----|----|----|---|
| Edit Project Form | `project_edit_screen.dart` | `/project-edit` |

### 2.2 Component Mapping

|| Design Element | Code Widget |
|----|----|----|
| Header with back button | `AppBar` with `Icons.arrow_back` |
| Project name input | `TextField` with prefix icon |
| Status dropdown | `DropdownButton` |
| PM dropdown | `DropdownButton` |
| Start date picker | `showDatePicker` |
| End date picker | `showDatePicker` |
| Notes textarea | `TextField(maxLines: 5)` |
| Save button | `GestureDetector` with primary color |

### 2.3 Style Mapping

|| Stitch Token | Code Value |
|---|---|
| `surface` (#f7f9fb) | `Color(0xFFF7F9FB)` |
| `on-surface` (#191c1e) | `Color(0xFF191C1E)` |
| `primary` (#005f9e) | `Color(0xFF005F9E)` |
| `error` (#ba1a1a) | `Color(0xFFBA1A1A)` |
| `outline-variant` (#c0c7d3) | `Color(0xFFC0C7D3)` |
| `outline` (#707882) | `Color(0xFF707882)` |
| label-bold | `TextStyle(fontSize: 14, fontWeight: w700)` |
| body-md | `TextStyle(fontSize: 14, fontWeight: w400)` |
| border-radius-lg | `BorderRadius.circular(8)` |

---

## 3. DATA MODELS

### 3.1 ProjectEditModel

```dart
class ProjectEditModel {
  final int? id;
  final String? name;
  final String? statusCode;
  final int? projectManagerId;
  final String? startDate;
  final String? endDate;
  final String? note;
}
```

### 3.2 API Mapping

|| Action | API | Method |
|----|----|----|-------|
| Load detail | `/api/v1/projects/{id}` | GET |
| Update project | `/api/v1/projects/{id}` | PUT |

---

## 4. STATE MANAGEMENT

```
ProjectEditScreen (extends BasePageStatefulWidget)
 └── BodyProjectEditWidget (StatefulWidget)
     └── Consumer<ProjectEditProvider>
         Provider watches: detailState, nameValue, statusValue,
                         projectManagerValue, startDateValue,
                         endDateValue, noteValue
 └── ProjectEditProvider (extends BaseProvider<ProjectEditService>)
     ├── detailState: StateType
     ├── project: ProjectEditModel?
     ├── nameValue, statusValue, noteValue
     ├── startDateValue, endDateValue (DateTime?)
     └── loadProjectDetail(), updateProject()
 └── ProjectEditService (extends BaseService)
     ├── getProjectDetail(int id) → ProjectEditResponse
     └── updateProject(int id, ProjectEditModel data) → ProjectEditResponse
```

---

## 5. FILE STRUCTURE

```
lib/features/project_edit/
├── project_edit_screen.dart
├── project_edit_mapping.md ← this file
├── component/
│ ├── project_edit_service.dart
│ └── project_edit_provider.dart
├── model/
│ └── project_edit_model.dart
└── widget/
    └── body_project_edit_widget.dart
```

---

## 6. i18n KEYS ADDED

| Key | VI | EN |
|-----|----|----|
| `suaDuAn` | Sửa dự án | Edit Project |
| `tenDuAn` | Tên dự án | Project Name |
| `nhapTenDuAn` | Nhập tên dự án | Enter project name |
| `vuiLongNhapTenDuAn` | Vui lòng nhập tên dự án | Please enter project name |
| `quanLyDuAnPM` | Quản lý dự án (PM) | Project Manager (PM) |
| `nhapGhiChuDuAn` | Nhập ghi chú chi tiết... | Enter project details and notes... |
| `duAnDaDuocCapNhatThanhCong` | Dự án đã được cập nhật thành công | Project updated successfully |
| `luu` | Lưu | Save |

---

## 7. ROUTE

```
RouteGenerator.projectEdit = '/project-edit'
Navigation: Navigator.pushNamed(context, RouteGenerator.projectEdit, arguments: projectId)
```

---

*Mapped by VNPT Stitch2Flutter Workflow — Auto-generated*
