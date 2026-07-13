# 🚀 VNPT Workflow Slash Commands cho Cursor

> **Cách hoạt động:** Cursor IDE không hỗ trợ custom slash commands thật. Hook `beforeSubmitPrompt` ở `.cursor/hooks/vnpt-workflow-router.sh` sẽ:
> 1. Phát hiện prompt có prefix `/vnpt_workflow_*`
> 2. **Parse đầy đủ flags** (`--srs`, `--figma`, `--postman`, `--module`)
> 3. **Parse Figma URL** → `fileKey` + `nodeId`
> 4. Inject context đầy đủ vào `agent_message` để agent biết chính xác cần làm gì

---

## 🎯 8 Slash Commands Khả Dụng

|| Slash Command | Mô tả |
|---|---|
|| `/vnpt_workflow_create <tên> [--srs <file>] [--figma <url>] [--postman <collection>] [--module <path>]` | Tạo feature mới với 3-source input (SRS + Figma + Postman) |
|| `/vnpt_workflow_update <tên> <stage> <status> [note]` | Update status (CLI v2.0 tự sửa `DEVELOPMENT_STATUS.md`) |
|| `/vnpt_workflow_status [tên]` | Xem trạng thái 1 feature (hoặc tất cả) |
|| `/vnpt_workflow_list` | Liệt kê tất cả features |
|| `/vnpt_workflow_review <tên>` | Chạy code review |
|| `/vnpt_workflow_fix <tên>` | Bắt đầu giai đoạn fix bug |
|| `/vnpt_workflow_help` | Hiển thị danh sách slash commands |
|| **`/vnpt_workflow_stitch2flutter <tên> --html <path> --css <path> [--srs] [--postman] [--output]`** | **🆕 Generate Flutter UI từ Stitch export (HTML + CSS YAML)** |

### Stages hợp lệ
`dev` | `review` | `fix`

### Status hợp lệ
`pending` ⏳ | `progress` 🔄 | `done` ✅ | `failed` ❌ | `no_bug` 🧼 | `clean` 🧼

---

## 📖 Cách Sử Dụng (Trong Cursor Chat)

### 1. Tạo feature mới (3-SOURCE WORKFLOW — Khuyến nghị)

```
/vnpt_workflow_create <tên_feature> \
  --srs <đường_dẫn_SRS.md> \
  --figma "<Figma_URL_có_node-id>" \
  --postman <Tên_Postman_Collection> \
  --module <module_path_tùy_chọn>
```

**Hook router sẽ:**
- Parse Figma URL → `fileKey` + `nodeId`
- Auto-detect module path từ SRS path (nếu không có `--module`)
- Inject context vào agent_message (bảng Context ở đầu prompt)

**Agent tự động:**
1. Chạy `vnpt_workflow create <tên>` → tạo folder + mapping doc + status file + `.vnpt_cache/sources.json`
2. Đọc 3 nguồn song song: SRS file → Figma MCP → Postman MCP
3. Tổng hợp → điền mapping doc
4. Code 5 files theo template + standards (sử dụng `{{VARIABLE}}` từ `_project_config.mdc`)
5. Auto-review theo checklist
6. Update status dev/review/fix tự động

### 2. Update status
```
/vnpt_workflow_update user_profile dev done "Hoàn thành UI"
/vnpt_workflow_update user_profile review no_bug "Clean code"
/vnpt_workflow_update user_profile review done
```

### 3. Xem trạng thái
```
/vnpt_workflow_status user_profile     # xem 1 feature
/vnpt_workflow_status                  # xem tất cả
/vnpt_workflow_list                   # list tất cả (bảng summary)
```

### 4. Review code
```
/vnpt_workflow_review user_profile
```

### 5. Fix bug
```
/vnpt_workflow_fix user_profile
```

---

### 6. 🆕 Generate Flutter UI từ Stitch export

```
/vnpt_workflow_stitch2flutter <tên_feature> \
  --html    <path/to/export.html>           # BẮT BUỘC
  --css     <path/to/styles.md>             # BẮT BUỘC (YAML format)
  --srs     <path/to/SRS.md>                # OPTIONAL
  --postman <collection_name>               # OPTIONAL
  --output  <path/to/output/folder>         # OPTIONAL → default: features/<tên>/
```

**Agent tự động:**
1. Parse HTML + CSS YAML + SRS + Postman (nếu có)
2. Tạo scaffold `features/<tên>/`
3. Generate files: screen + body widget + mapping + status
4. **Append color tokens** vào `lib/core/constants/color_app.dart`
5. Apply Hard Rules (sử dụng `{{VARIABLE}}` từ `_project_config.mdc`)
6. Auto-loop review (max 3 vòng)

---

## 🛠️ Cách Hoạt Động (v3)

```
┌─────────────────────────────────────────────────────────────┐
│ User gõ trong Cursor chat:                                  │
│   /vnpt_workflow_create user_profile --srs SRS.md           │
│           --figma "https://.../?node-id=74-7479"            │
│           --postman CollectionName                          │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Hook beforeSubmitPrompt trigger                             │
│ Script: .cursor/hooks/vnpt-workflow-router.sh (v3)         │
│                                                              │
│ 1. Parse prompt → COMMAND, FEATURE, ARGS                   │
│ 2. Parse flags bằng Python regex                            │
│ 3. Parse Figma URL → fileKey + nodeId                       │
│ 4. Build AGENT_MESSAGE đầy đủ context                       │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Agent nhận được context → thực thi:                         │
│ 1. Chạy CLI: ./vnpt_workflow create user_profile ...       │
│ 2. Đọc _project_config.mdc → resolve {{VARIABLE}}           │
│ 3. Đọc 3 nguồn (MCP + Read)                               │
│ 4. Điền mapping doc                                         │
│ 5. Code files với biến đã resolve                          │
│ 6. Auto-review (max 3 vòng)                                │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Files Liên Quan

```
.cursor/
├── rules/
│   ├── _project_config.mdc              ← ⚡ Config cho dự án (biến {{VARIABLE}})
│   ├── README.md
│   ├── SLASH_COMMANDS.md                ← File này
│   ├── architecture/                    ← NHÓM B (dùng biến)
│   │   ├── architecture.mdc
│   │   ├── provider.mdc
│   │   └── api.mdc
│   └── standards/                       ← NHÓM B (dùng biến)
│       ├── ui.mdc
│       ├── naming.mdc
│       ├── performance.mdc
│       └── widgets.mdc
└── hooks/
    ├── hooks.json
    ├── vnpt-workflow-router.sh (v3)
    └── vnpt-session-injector.sh

.git_hooks/
├── vnpt_workflow (v2.0)
├── auto_review.sh
├── pre-commit
└── install.sh
```

---

## ⚙️ Cài Đặt

1. **Restart Cursor** để load hook mới
2. **Verify trong Cursor settings** → **Hooks** tab → kiểm tra `beforeSubmitPrompt` đã được register
3. **Test ngay**: gõ `/vnpt_workflow_help` trong chat

---

## 💡 Tips

1. **Biến `{{VARIABLE}}`**: Tất cả code pattern trong rules đều dùng biến. Chỉ cần sửa `_project_config.mdc` khi đổi dự án.
2. **Trigger nhanh**: Chỉ cần gõ `/vnpt_workflow_` → tự gõ tiếp.
3. **Multi-step workflow**: Sau khi `create` xong, agent tự chạy review-loop (max 3 vòng).
4. **Debug hook**: Mở **Cursor Settings → Hooks → Output channel** xem log lỗi.

---

## 🆚 So Sánh: Slash Command vs CLI

|| Cách | Ưu điểm | Nhược điểm |
|---|---|---|
|| **CLI (`./.git_hooks/vnpt_workflow create abc`)** | Chạy nhanh, deterministic, **tự sửa file Markdown** | Phải nhớ path + cú pháp |
|| **Slash command (chat)** | Gõ trực tiếp trong chat, agent tự thực thi, có thể kèm giải thích | Phụ thuộc agent, có thể chậm hơn |

**Khuyến nghị:** Dùng slash command cho việc phức tạp (create, review, fix). Dùng CLI cho việc đơn giản (update status, list).
