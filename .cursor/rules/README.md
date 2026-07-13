# 📚 Cursor Rules — obm_gen_with_ai

> **Mục đích:** Copy sang dự án mới chỉ cần sửa **DUY NHẤT 1 file** — `_project_config.mdc`.

---

## 🟢 NHÓM A — WORKFLOW (Copy nguyên xi khi qua dự án mới)

> Phần này **KHÔNG phụ thuộc** base code Flutter. Mọi dự án Flutter đều dùng được.

```
.cursor/rules/
├── workflow/                         ← Folder này chứa toàn bộ rule workflow
│   ├── README.md                    ← Index trong workflow/
│   ├── vnpt-workflow.mdc            ← State machine + cách chạy CLI
│   ├── vnpt-workflow-stitch2flutter.mdc  ← Workflow Stitch HTML+CSS → Flutter
│   ├── feature-mapping-workflow.mdc ← 3-source mapping (SRS+Figma+Postman)
│   ├── templates/
│   │   └── mapping-template.mdc    ← Template file *_mapping.md
│   └── review/
│       └── review-criteria.mdc      ← Checklist review code
├── README.md                        ← File này (index tổng quan)
├── SLASH_COMMANDS.md                ← Hướng dẫn slash commands
├── _project_config.mdc              ← ⚡ CHỈ SỬA FILE NÀY khi đổi dự án
└── hooks/
    ├── hooks.json
    ├── vnpt-workflow-router.sh       ← Parse flags Figma+Postman
    └── vnpt-session-injector.sh    ← Session start context

.git_hooks/
├── vnpt_workflow                    ← CLI bash (state machine)
├── auto_review.sh                   ← Auto-check lỗi phổ biến
├── pre-commit                       ← Format + analyze
└── install.sh                       ← Cài pre-commit
```

---

## 🟡 NHÓM B — BASE CODE RULES (Dùng biến — copy nguyên)

> Phần này dùng `{{VARIABLE}}` tokens thay vì hardcoded values.
> **Copy nguyên khi qua dự án mới — KHÔNG cần sửa nội dung.**

```
.cursor/rules/
├── _project_config.mdc              ← ⚡ Config cho dự án (biến {{VARIABLE}})
├── architecture/                    ← Pattern kiến trúc hệ thống
│   ├── architecture.mdc             ← UI → Provider → Service → Dio
│   ├── provider.mdc                ← Template Provider extends BaseProvider
│   └── api.mdc                     ← Network rules: BaseService + Dio
└── standards/                      ← Chuẩn code (UI, naming, perf, widget)
    ├── ui.mdc                      ← ColorApp, OneUiText, AppStrings, sizing
    ├── naming.mdc                  ← snake_case file, PascalCase class
    ├── performance.mdc              ← SelectorBase, const, dispose, mounted
    └── widgets.mdc                  ← CoreButton, ConsumerBase, EmptyListIndicator…
```

### Biến quan trọng nhất

|| Biến | Mô tả |
|---|---|
| `{{PROVIDER_BASE}}` | Class gốc của Provider (VD: `BaseProvider<S>`) |
| `{{SERVICE_BASE}}` | Class gốc của Service (VD: `BaseService`) |
| `{{STATE_TYPE}}` | Enum state (VD: `StateType`) |
| `{{SCREEN_STATE_BASE}}` | Base class của Screen State (VD: `BaseStatefulWidgetState<T,S,P>`) |
| `{{BRAND}}` | Mã màu brand (VD: `ColorApp.brand`) |
| `{{I18N_CLASS}}` | Class i18n (VD: `AppStrings`) |
| `{{TEXT_STYLE_CLASS}}` | Class text style (VD: `OneUiText`) |

Xem đầy đủ trong `_project_config.mdc`.

---

## 🆕 KIẾN TRÚC MỚI: 1 Config — Tất Cả Rules Tự Động Phù Hợp

### Trước đây (VNA Office)

```
Mỗi dự án mới → phải viết lại 7 file NHÓM B
```

### Bây giờ (obm_gen_with_ai)

```
Mỗi dự án mới → chỉ sửa _project_config.mdc (1 file)
```

**Cách hoạt động:** Tất cả rules dùng `{{VARIABLE}}` thay vì hardcoded values. Biến được resolve từ `_project_config.mdc`.

---

## 🔄 Khi Sang Dự Án Mới

### Bước 1: Copy NHÓM A (workflow)

```bash
# Trong dự án mới:
mkdir -p .cursor/rules/workflow/{templates,review}
mkdir -p .cursor/hooks
mkdir -p .git_hooks

# Copy NHÓM A:
cp -r <old-project>/.cursor/rules/workflow/* .cursor/rules/workflow/
cp -r <old-project>/.cursor/hooks/* .cursor/hooks/
cp -r <old-project>/.git_hooks/* .git_hooks/

# Cài pre-commit:
bash .git_hooks/install.sh
```

### Bước 2: Copy NHÓM B + Config (đã dùng biến)

```bash
# Copy NHÓM B (dùng biến — không cần sửa):
cp -r <old-project>/.cursor/rules/architecture/ .cursor/rules/architecture/
cp -r <old-project>/.cursor/rules/standards/ .cursor/rules/standards/

# Copy config template:
cp <old-project>/.cursor/rules/_project_config.mdc .cursor/rules/_project_config.mdc

# Copy README + SLASH_COMMANDS:
cp <old-project>/.cursor/rules/README.md .cursor/rules/README.md
cp <old-project>/.cursor/rules/SLASH_COMMANDS.md .cursor/rules/SLASH_COMMANDS.md
```

### Bước 3: Sửa DUY NHẤT `_project_config.mdc`

```bash
code .cursor/rules/_project_config.mdc
```

Các giá trị cần update cho dự án mới:

| Variable | Thay đổi |
|---|---|
| `PACKAGE_IMPORT` | `package:tên_dự_án/` |
| `SERVICE_BASE` | Class gốc của Service |
| `PROVIDER_BASE` | Class gốc của Provider |
| `STATE_TYPE` | Tên enum state |
| `BRAND` | `ColorApp.xxx` |
| `I18N_CLASS` | Class i18n |
| ... | (xem đầy đủ trong file) |

**Tất cả rules tự động phù hợp sau khi update config.**

---

## 🎯 Mapping: Workflow nào cần đọc rule nào?

|| Khi làm gì | Đọc file nào |
|---|---|
| Tạo feature mới từ SRS+Figma+Postman | `workflow/vnpt-workflow.mdc` + `workflow/feature-mapping-workflow.mdc` + NHÓM B |
| Generate UI từ Stitch export | `workflow/vnpt-workflow-stitch2flutter.mdc` |
| Review code | `workflow/review/review-criteria.mdc` + NHÓM B |
| Fix bug | `workflow/vnpt-workflow.mdc` (stage fix) |
| Tìm hiểu slash command | `SLASH_COMMANDS.md` |
| Viết code cho 1 feature | NHÓM B (architecture + standards) |
| Copy sang dự án mới | `_project_config.mdc` (duy nhất 1 file) |

---

## 🚀 Workflow Tổng Thể

```
[YÊU CẦU] → [CREATE] → [MAPPING] → [DEV] → [REVIEW] → [FIX] → ✅ DONE
   "Tạo ABC"   Auto     Auto-gen    Code    Auto      Auto
              folder    file MD    theo    check     fix
                        + biến   template
```

---

## ✅ Checklist Code Bắt Buộc

Lấy từ NHÓM B:

- [ ] Screen `extends {{SCREEN_BASE_CLASS}}`, State `extends {{SCREEN_STATE_BASE}}<T,S,P>`
- [ ] Body widget KHÔNG có `Scaffold` / `AppBar` / `ProgressHUD`
- [ ] Provider `extends {{PROVIDER_BASE}}`, dùng `{{M_SHOW_LOADING}}`/`{{M_SHOW_LOADED}}`/`{{M_SHOW_ERROR}}`/`{{M_SHOW_NO_DATA}}`
- [ ] Provider KHÔNG declare lại `{{STATE_TYPE}} status`
- [ ] Màu: `{{BRAND}}` | Text: `{{TEXT_STYLE_CLASS}}.*` | String: `{{I18N_GETTER}}`
- [ ] File `{{FILE_CASE}}`, class `{{CLASS_CASE}}`
- [ ] `{{ASYNC_METHOD}}` thay vì `void async`
- [ ] `if (!mounted) return;` sau mỗi `await`
- [ ] `notifyListeners()` thay vì `setState` trong Provider
- [ ] `const` constructors cho stateless widgets
- [ ] Dispose `AnimationController`, `StreamSubscription`, `Timer`, `FocusNode`
- [ ] KHÔNG log sensitive data
- [ ] KHÔNG dùng BLoC / Riverpod / GetX

---

## 🔍 Status Legend

|| Emoji | Status | Mô tả |
|---|---|---|
| ⏳ | `pending` | Chưa bắt đầu |
| 🔄 | `progress` | Đang làm |
| ✅ | `done` | Hoàn thành |
| 🧼 | `no_bug` | Review không có bug |
| ❌ | `failed` | Có lỗi |

### 3 Stages Bắt Buộc

|| Stage | Ý nghĩa |
|---|---|---|
| `dev` | Development |
| `review` | Code Review |
| `fix` | Bug Fixing |

---

## 🔗 Mapping Với Script CLI

|| Rule file | CLI liên quan |
|---|---|
| `workflow/vnpt-workflow.mdc` | `vnpt_workflow create` / `update` |
| `workflow/feature-mapping-workflow.mdc` | `vnpt_workflow create` |
| `workflow/review/review-criteria.mdc` | `auto_review.sh` |
| `architecture/*.mdc` + `standards/*.mdc` | Code template (dùng biến) |
| `_project_config.mdc` | Chỉ sửa file này khi đổi dự án |

---

## 📝 Lưu Ý Quan Trọng

1. **Agent PHẢI tự gọi `vnpt_workflow update`** sau mỗi bước dev/review/fix
2. **NHÓM A + NHÓM B copy nguyên được** khi qua dự án mới
3. **CHỈ cần sửa `_project_config.mdc`** khi đổi dự án — tất cả biến tự resolve
4. **Workflow files dùng biến** — không chứa hardcoded code pattern
5. **Config file là Single Source of Truth** cho base class names, import paths, UI tokens

---

*Maintained by VNPT Workflow Tools — Last updated: 2026-06-19*
