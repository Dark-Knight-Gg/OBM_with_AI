# 🔄 Workflow Rules (NHÓM A — Copy nguyên xi khi qua dự án mới)

> Folder này chứa **toàn bộ rule về CÁCH CHẠY workflow**.
> Mọi file trong folder này **KHÔNG phụ thuộc base code Flutter** — copy được sang dự án mới mà không cần sửa.
>
> ⚠️ **THAY ĐỔI QUAN TRỌNG:** Các code pattern trong workflow file (BaseScreen, Provider, ColorApp...) đã được thay bằng biến `{{VARIABLE}}`. Chúng được resolve từ `_project_config.mdc` ở thư mụng `.cursor/rules/`.

---

## 📁 Files Trong Folder Này

```
workflow/
├── README.md                              ← File này (index)
├── vnpt-workflow.mdc                      ← State machine + cách chạy CLI
├── vnpt-workflow-stitch2flutter.mdc       ← Workflow Stitch HTML+CSS → Flutter
├── feature-mapping-workflow.mdc           ← 3-source mapping (SRS+Figma+Postman)
├── templates/
│   └── mapping-template.mdc               ← Template file *_mapping.md
└── review/
    └── review-criteria.mdc                ← Checklist review code
```

---

## 🎯 Mỗi File Làm Gì?

|| File | Mô tả ngắn |
|---|---|
|| `vnpt-workflow.mdc` | Định nghĩa 8 workflows + cách dùng CLI `vnpt_workflow update` |
|| `vnpt-workflow-stitch2flutter.mdc` | Workflow 8: Generate Flutter UI từ Stitch export |
|| `feature-mapping-workflow.mdc` | Workflow chính: Tạo feature từ 3 nguồn (SRS + Figma + Postman) |
|| `templates/mapping-template.mdc` | Template format file `<tên>_mapping.md` |
|| `review/review-criteria.mdc` | Checklist review code (CLI `auto_review.sh` check 10 lỗi) |

---

## 📦 Files Liên Quan Ở Ngoài Folder Này

```
.cursor/
├── rules/
│   ├── _project_config.mdc              ← ⚡ CHỈ SỬA FILE NÀY khi đổi dự án
│   ├── README.md                        ← Hướng dẫn copy + cài đặt
│   ├── SLASH_COMMANDS.md                ← Hướng dẫn slash commands
│   ├── architecture/                    ← NHÓM B (copy nguyên — dùng biến)
│   └── standards/                       ← NHÓM B (copy nguyên — dùng biến)
└── hooks/
    ├── hooks.json
    ├── vnpt-workflow-router.sh           ← Parse flags Figma+Postman
    └── vnpt-session-injector.sh         ← Session start context

.git_hooks/
├── vnpt_workflow                        ← CLI bash (state machine)
├── auto_review.sh                       ← Auto-check 10 lỗi phổ biến
├── pre-commit                           ← Format + analyze
└── install.sh                           ← Cài pre-commit
```

---

## 🔄 Khi Sang Dự Án Mới

### Bước 1: Copy NHÓM A (workflow)

```bash
# Trong dự án mới:
mkdir -p .cursor/rules/workflow/{templates,review}
mkdir -p .cursor/hooks
mkdir -p .git_hooks

# Copy workflow/:
cp -r <old-project>/.cursor/rules/workflow/* .cursor/rules/workflow/

# Copy hooks/:
cp -r <old-project>/.cursor/hooks/* .cursor/hooks/

# Copy git_hooks/:
cp -r <old-project>/.git_hooks/* .git_hooks/

# Cài pre-commit:
bash .git_hooks/install.sh
```

### Bước 2: Tạo _project_config.mdc MỚI

```bash
# Copy template
cp <old-project>/.cursor/rules/_project_config.mdc .cursor/rules/_project_config.mdc

# Sửa các giá trị trong _project_config.mdc cho dự án mới:
# - PACKAGE_IMPORT: package:tên_dự_án/
# - CORE_PATH: lib/core/
# - FEATURES_PATH: lib/features/
# - SERVICE_BASE: BaseService (tên class gốc)
# - PROVIDER_BASE: BaseProvider<S> (tên class gốc)
# - STATE_TYPE: StateType (tên enum gốc)
# - BRAND, TEXT_*, I18N_CLASS, etc.
```

### Bước 3: Copy NHÓM B (architecture + standards) — ĐÃ DÙNG BIẾN

```bash
cp -r <old-project>/.cursor/rules/architecture/ .cursor/rules/architecture/
cp -r <old-project>/.cursor/rules/standards/ .cursor/rules/standards/
```

> Các file trong NHÓM B đã dùng `{{VARIABLE}}` — KHÔNG cần sửa nội dung, chỉ cần update `_project_config.mdc`.

---

## 🎯 Workflow → Rule Mapping

|| Workflow | Đọc rule nào |
|---|---|
|| `/vnpt_workflow_create` | `vnpt-workflow.mdc` + `feature-mapping-workflow.mdc` + `templates/mapping-template.mdc` |
|| `/vnpt_workflow_stitch2flutter` | `vnpt-workflow-stitch2flutter.mdc` |
|| `/vnpt_workflow_review` | `review/review-criteria.mdc` |
|| `/vnpt_workflow_fix` | `vnpt-workflow.mdc` (stage fix) + `review/review-criteria.mdc` |
|| `/vnpt_workflow_status`, `/list`, `/help`, `/update` | `vnpt-workflow.mdc` |

---

## 🔑 Biến trong Workflow Files (từ _project_config.mdc)

Workflow files sử dụng `{{VARIABLE}}` cho code patterns. Các biến quan trọng được dùng:

|| Biến | Ví dụ giá trị | Dùng trong |
|---|---|---|
|| `{{SCREEN_BASE_CLASS}}` | `BasePageStatefulWidget` | Hard Rules |
|| `{{SCREEN_STATE_BASE}}` | `BaseStatefulWidgetState<T,S,P>` | Hard Rules |
|| `{{PROVIDER_BASE}}` | `BaseProvider<S>` | Code examples |
|| `{{STATE_TYPE}}` | `StateType` | State machine |
|| `{{I18N_CLASS}}` | `AppStrings` | Strings |
|| `{{BRAND}}` | `ColorApp.brand` | UI rules |
|| `{{TEXT_STYLE_CLASS}}` | `OneUiText` | Text styles |
|| `{{FEATURES_PATH}}` | `features/` | File paths |
|| `{{IMPORT_CORE}}` | `package:tên_dự_án/core/` | Imports |

Xem đầy đủ trong `_project_config.mdc`.

---

*Maintained by VNPT Workflow Tools — Last updated: 2026-06-19*
