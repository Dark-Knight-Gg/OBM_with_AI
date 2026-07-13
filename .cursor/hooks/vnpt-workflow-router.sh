#!/bin/bash
# vnpt-workflow-router.sh (v4 - stitch2flutter support)
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
# Load .workflow_config
if [[ -f "$PROJECT_ROOT/.workflow_config" ]]; then
    # shellcheck source=/dev/null
   source "$PROJECT_ROOT/.workflow_config" 2>/dev/null || true
fi
INPUT_JSON=$(cat)
PROMPT_TEXT=$(printf '%s' "$INPUT_JSON" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    text = data.get('text', data.get('prompt', data.get('message', data.get('user_message', ''))))
    print(text or '')
except Exception:
    print('')
" 2>/dev/null || echo "")
PROMPT_TEXT=$(printf '%s' "$PROMPT_TEXT" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
if [[ ! "$PROMPT_TEXT" =~ ^/vnpt_workflow_ ]]; then
  printf '%s\n' "$PROMPT_TEXT" | python3 -c "import sys, json; d={'user_message': sys.stdin.read().strip(), 'agent_message': ''}; print(json.dumps(d))" 2>/dev/null || true
  exit 0
fi
COMMAND=$(printf '%s' "$PROMPT_TEXT" | sed -E 's|^/vnpt_workflow_([a-zA-Z0-9_]+).*|\1|')
REST=$(printf '%s' "$PROMPT_TEXT" | sed -E 's|^/vnpt_workflow_[a-zA-Z0-9_]+[[:space:]]*||')
PARSED=$(PROMPT_TEXT="$PROMPT_TEXT" REST="$REST" python3 <<'PYEOF'
import os, re, json
prompt = os.environ.get("PROMPT_TEXT", "")
rest = os.environ.get("REST", "")
flags = {}
pattern = re.compile(r'--(srs|figma|postman|module|html|css)\s+("([^"]*)"|([^\s]+))')
for m in pattern.finditer(rest):
    key = m.group(1)
    val = m.group(3) or m.group(4) or ""
    flags[key] = val
positional = pattern.sub('', rest).strip()
feature_name = ""
extra_args = ""
tokens = positional.split(None, 1)
if tokens:
    feature_name = tokens[0]
    extra_args = tokens[1] if len(tokens) > 1 else ""
file_key = ""
node_id = ""
if "figma" in flags:
    url = flags["figma"]
    m = re.search(r'/design/([A-Za-z0-9]+)/.*?[?&]node-id=([0-9]+[-:][0-9]+)', url)
    if m:
        file_key = m.group(1)
        node_id = m.group(2).replace("-", ":")
    else:
        m = re.search(r'/(?:file|design)/([A-Za-z0-9]+)', url)
        if m:
            file_key = m.group(1)
        m = re.search(r'node-id=([0-9]+[-:][0-9]+)', url)
        if m:
            node_id = m.group(1).replace("-", ":")
print(json.dumps({"feature": feature_name, "extra_args": extra_args, "flags": flags, "figma_file_key": file_key, "figma_node_id": node_id}, ensure_ascii=False))
PYEOF
)
FEATURE=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['feature'])")
EXTRA_ARGS=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['extra_args'])")
SRS_FLAG=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['flags'].get('srs',''))")
FIGMA_FLAG=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['flags'].get('figma',''))")
POSTMAN_FLAG=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['flags'].get('postman',''))")
MODULE_FLAG=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['flags'].get('module',''))")
HTML_FLAG=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['flags'].get('html',''))")
CSS_FLAG=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['flags'].get('css',''))")
FIGMA_KEY=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['figma_file_key'])")
FIGMA_NODE=$(echo "$PARSED" | python3 -c "import sys,json;print(json.load(sys.stdin)['figma_node_id'])")
case "$COMMAND" in
    c) COMMAND="create" ;;
    s) COMMAND="status" ;;
    u) COMMAND="update" ;;
    l) COMMAND="list" ;;
    r) COMMAND="review" ;;
    f) COMMAND="fix" ;;
    h|help) COMMAND="help" ;;
    stitch2flutter|s2f) COMMAND="stitch2flutter" ;;
esac
USER_MSG_DISPLAY=""
case "$COMMAND" in
    create)
        USER_MSG_DISPLAY="🚀 Tạo feature: $FEATURE"
        [ -n "$SRS_FLAG" ] && USER_MSG_DISPLAY="$USER_MSG_DISPLAY + SRS"
        [ -n "$FIGMA_FLAG" ] && USER_MSG_DISPLAY="$USER_MSG_DISPLAY + Figma"
        [ -n "$POSTMAN_FLAG" ] && USER_MSG_DISPLAY="$USER_MSG_DISPLAY + Postman"
        ;;
    update) USER_MSG_DISPLAY="📝 Update: $FEATURE → $EXTRA_ARGS" ;;
    status) USER_MSG_DISPLAY="📊 Status: ${FEATURE:-tất cả}" ;;
    list) USER_MSG_DISPLAY="📁 List features" ;;
    review) USER_MSG_DISPLAY="🔍 Review: $FEATURE" ;;
    fix) USER_MSG_DISPLAY="🐛 Fix: $FEATURE" ;;
    stitch2flutter) USER_MSG_DISPLAY="🎨 Stitch2Flutter: $FEATURE" ;;
    help) USER_MSG_DISPLAY="📖 Help" ;;
    *) USER_MSG_DISPLAY="⚠️ Unknown: $COMMAND" ;;
esac
AGENT_MSG=$(PROMPT_TEXT="$PROMPT_TEXT" COMMAND="$COMMAND" FEATURE="$FEATURE" EXTRA_ARGS="$EXTRA_ARGS" SRS_FLAG="$SRS_FLAG" FIGMA_FLAG="$FIGMA_FLAG" POSTMAN_FLAG="$POSTMAN_FLAG" MODULE_FLAG="$MODULE_FLAG" FIGMA_KEY="$FIGMA_KEY" FIGMA_NODE="$FIGMA_NODE" HTML_FLAG="$HTML_FLAG" CSS_FLAG="$CSS_FLAG" PROJECT_ROOT="$PROJECT_ROOT" python3 <<'PYEOF'
import os
prompt = os.environ.get("PROMPT_TEXT", "")
cmd = os.environ.get("COMMAND", "")
feature = os.environ.get("FEATURE", "")
extra = os.environ.get("EXTRA_ARGS", "")
srs = os.environ.get("SRS_FLAG", "")
figma_url = os.environ.get("FIGMA_FLAG", "")
postman = os.environ.get("POSTMAN_FLAG", "")
module = os.environ.get("MODULE_FLAG", "")
fk = os.environ.get("FIGMA_KEY", "")
fn = os.environ.get("FIGMA_NODE", "")
html_path = os.environ.get("HTML_FLAG", "")
css_path = os.environ.get("CSS_FLAG", "")
project_root = os.environ.get("PROJECT_ROOT", "obm_gen_with_ai")

ctx_rows = [
    "| Feature name | `{0}` |".format(feature or '_(chưa có)_'),
    "| Module | `{0}` |".format(module or '_(chưa có — suy từ SRS path)_'),
    "| SRS file | `{0}` |".format(srs or '_(không có)_'),
    "| Figma URL | `{0}` |".format(figma_url or '_(không có)_'),
    "| Figma fileKey | `{0}` |".format(fk or '_(chưa parse được)_'),
    "| Figma nodeId | `{0}` |".format(fn or '_(chưa parse được)_'),
    "| Postman collection | `{0}` |".format(postman or '_(không có)_'),
    "| HTML file | `{0}` |".format(html_path or '_(không có)_'),
    "| CSS file | `{0}` |".format(css_path or '_(không có)_'),
]
ctx = "\n".join(ctx_rows)

if cmd == "create":
    flags_cli = []
    if srs: flags_cli.append('--srs "' + srs + '"')
    if figma_url: flags_cli.append('--figma "' + figma_url + '"')
    if postman: flags_cli.append('--postman "' + postman + '"')
    if module: flags_cli.append('--module "' + module + '"')
    flags_joined = " \\\n  ".join(flags_cli)
    msg = """🚨 **BẮT BUỘC ĐỌC TRƯỚC KHI HÀNH ĐỘNG**

Bạn đang chạy workflow `/vnpt_workflow_create`. Prompt gốc của user:

> `{prompt}`

## 📋 CONTEXT ĐÃ PARSE (từ hook router)

{ctx}

## ⚡ HÀNH ĐỘNG BẮT BUỘC (theo thứ tự)

### 1️⃣ Chạy CLI để tạo scaffold

```bash
cd {project_root}
./.git_hooks/vnpt_workflow create {feature} \\
  {flags}
```

CLI sẽ tự động:
- Parse Figma URL → lưu fileKey + nodeId vào sources.json
- Tạo folder theo module path
- Tạo sources.json (đầy đủ 3 nguồn + parsed data)
- Tạo <feature>_mapping.md (template rỗng — agent điền)
- Tạo DEVELOPMENT_STATUS.md
- Tạo 5 file Dart template

### 2️⃣ ĐỌC 3 NGUỒN (parallel — MCP + Read)

**A. Nếu có `--srs`:**
```python
Read(path="<absolute_path_to_SRS>")
# → trích: user stories, field tables, validation rules
```

**B. Nếu có `--figma`:**
```python
# Parsed sẵn: fileKey=`{fk}`, nodeId=`{fn}`
CallMcpTool(
  server="plugin-figma-figma",
  toolName="get_design_context",
  arguments={{"fileKey": "{fk}", "nodeId": "{fn}"}}
)
# (optional) Screenshot
CallMcpTool(
  server="plugin-figma-figma",
  toolName="get_screenshot",
  arguments={{"fileKey": "{fk}", "nodeId": "{fn}", "scale": 2}}
)
```

**C. Nếu có `--postman`:**
```python
CallMcpTool(
  server="user-postman",
  toolName="searchPostmanElements",
  arguments={{"entityType":"collections", "q":"{postman}", "ownership":"organization"}}
)
# Lấy collectionId → getCollection
CallMcpTool(
  server="user-postman",
  toolName="getCollection",
  arguments={{"collectionId":"<id>"}}
)
```

### 3️⃣ ĐIỀN `<feature>_mapping.md` (QUAN TRỌNG)

Dùng `StrReplace` để thay các placeholder:
- 1.1 SRS Reference → từ SRS
- 1.2 Figma Design → URL + fileKey + nodeId
- 1.3 User Stories → trích từ SRS
- 2.1 Screen Mapping → từ Figma MCP
- 2.2 Component Mapping → từ Figma MCP
- 2.3 Style Mapping → colors/text → ColorApp/OneUiText
- 3.1 Entity Mapping → từ SRS + Postman schema
- 4.1 Endpoint Mapping → từ Postman MCP

### 4️⃣ CODE 5 FILES THEO MAPPING DOC

| File | Lấy data từ |
|------|-------------|
| `<feature>_screen.dart` | Title từ Figma, route name |
| `component/<feature>_provider.dart` | Fields từ SRS/Postman |
| `component/<feature>_service.dart` | Endpoint + method từ Postman MCP |
| `model/<feature>_model.dart` | Fields từ Postman response |
| `widget/body_<feature>_widget.dart` | UI layout từ Figma |

### 5️⃣ UPDATE STATUS

```bash
./.git_hooks/vnpt_workflow update {feature} dev progress "Đang code"
./.git_hooks/vnpt_workflow update {feature} dev done "Code xong"
```

### 6️⃣ TỰ ĐỘNG REVIEW + FIX (loop max 3 lần)

Đọc `.cursor/rules/review/review-criteria.mdc` → check → fix → loop.

## 🔑 CRITICAL RULES

- **BaseScreen** thay vì Scaffold trực tiếp
- Body widget KHÔNG có Scaffold/AppBar/ProgressHUD
- Import: `package:vna_utilities/index.dart;` (1 dòng)
- Provider KHÔNG declare lại Status status
- Service dùng UrlEOffice.* (KHÔNG hardcode URL)
- Colors: ColorApp.*, Text: OneUiText.*, Strings: AppStrings.*

## ⚠️ LƯU Ý

- Prompt có thể dùng format ngắn `+ SRS: @<path>` — ĐỌC PROMPT GỐC để lấy đúng data.
- Nếu prompt không rõ ràng, hỏi user trước khi chạy CLI.
""".format(prompt=prompt, ctx=ctx, feature=feature, flags=flags_joined, fk=fk, fn=fn, postman=postman, project_root=project_root)
    print(msg)
elif cmd == "stitch2flutter":
    flags_cli = []
    if html_path: flags_cli.append('--html "' + html_path + '"')
    if css_path: flags_cli.append('--css "' + css_path + '"')
    if srs: flags_cli.append('--srs "' + srs + '"')
    if postman: flags_cli.append('--postman "' + postman + '"')
    flags_joined = " \\\n  ".join(flags_cli)
    msg = """🚨 **BẮT BUỘC ĐỌC TRƯỚC KHI HÀNH ĐỘNG**

Bạn đang chạy workflow `/vnpt_workflow_stitch2flutter`. Prompt gốc của user:

> `{prompt}`

## 📋 CONTEXT ĐÃ PARSE (từ hook router)

{ctx}

## ⚡ HÀNH ĐỘNG BẮT BUỘC (theo thứ tự)

### 1️⃣ Validate input (BẮT BUỘC)

```bash
# --html là BẮT BUỘC
if [ -z "{html_path}" ]; then
  echo "❌ --html là bắt buộc"
  exit 1
fi

# --css là BẮT BUỘC
if [ -z "{css_path}" ]; then
  echo "❌ --css là bắt buộc"
  exit 1
fi
```

### 2️⃣ Parse Stitch export files

**A. Read HTML file:**
```python
Read(path="{html_path}")
# → extract: title, main content, sections, inline styles, icons
```

**B. Read CSS YAML file:**
```python
Read(path="{css_path}")
# → extract: colors, typography, rounded, spacing blocks
```

**C. Nếu có `--srs`:**
```python
Read(path="{srs}")
# → extract: user stories, field tables
```

**D. Nếu có `--postman`:**
```python
CallMcpTool(
  server="user-postman",
  toolName="searchPostmanElements",
  arguments={{"entityType":"collections", "q":"{postman}", "ownership":"organization"}}
)
```

### 3️⃣ Tạo scaffold

```bash
mkdir -p {project_root}/{{FEATURES_PATH}}<feature>/component
mkdir -p {project_root}/{{FEATURES_PATH}}<feature>/model
mkdir -p {project_root}/{{FEATURES_PATH}}<feature>/widget
```

Output mặc định: `{{FEATURES_PATH}}<feature>/`

### 4️⃣ Generate files

| File | Nguồn |
|------|--------|
| `<feature>_screen.dart` | Template → dùng `{{SCREEN_BASE_CLASS}}` |
| `widget/body_<feature>_widget.dart` | HTML → Flutter widget mapping |
| `<feature>_mapping.md` | Auto-gen từ HTML/CSS/SRS |
| `DEVELOPMENT_STATUS.md` | Auto-gen status tracker |
| `component/<feature>_service.dart` | CHỈ khi có `--postman` |
| `component/<feature>_provider.dart` | CHỈ khi có `--postman` hoặc `--srs` |
| `model/<feature>_model.dart` | CHỈ khi có `--srs` hoặc `--postman` |

### 5️⃣ Append color tokens vào `lib/core/constants/color_app.dart`

**QUY TẮC RẤT QUAN TRỌNG:**
- CHỈ thêm token MỚI (skip nếu tên đã có)
- KHÔNG sửa phần nào khác của file
- Vị trí: tìm dòng cuối cùng `static const Color` rồi insert sau

```python
existing = Read(path="lib/core/constants/color_app.dart")
existing_names = re.findall(r'static const Color (\\w+)', existing)
for css_name, hex in css_colors.items():
    dart_name = css_to_dart_name(css_name)
    if dart_name in existing_names:
        continue  # SKIP — đã có
    # Append vào file
```

### 6️⃣ HTML → Flutter Widget Mapping

| HTML/Tailwind class | Flutter widget |
|---------------------|---------------|
| `<main class="flex flex-col ...">` | `Column(...)` |
| `<div class="bg-gradient">` | `Container(gradient: LinearGradient(...))` |
| `<div class="card-shadow bg-white rounded-xl">` | `Container(boxShadow: [...], borderRadius: ...)` |
| `<h1 class="text-headline-lg">` | `Text('...', style: TextStyle(fontSize: 30, fontWeight: w700))` |
| `<form class="flex flex-col gap-stack-md">` | `Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [...])` |
| `<input class="rounded-lg border">` | `TextField(decoration: InputDecoration(border: ...))` |
| `<button class="btn-gradient rounded-lg">` | `ElevatedButton(...)` |
| `<span class="material-symbols-outlined">login</span>` | `Icon(Icons.login, size: 20)` |
| `<div class="bg-[#D1E7DD] text-[#0f5132] rounded-lg">` | `Container(color: Color(0xFFD1E7DD), borderRadius: ...)` |

### 7️⃣ Apply Hard Rules

| Rule | Check |
|------|-------|
| `{{SCREEN_STATE_BASE}}` | `<feature>_screen.dart` dùng `{{SCREEN_BASE_CLASS}}` |
| Import | `import 'package:obm_gen_with_ai/core/';` |
| Colors | Dùng `{{BRAND}}` cho color tokens |
| Strings | Dùng `{{I18N_GETTER}}` cho text |
| Typography | Flutter `TextStyle(fontSize:, fontWeight:, height:)` inline |
| Spacing/Radius | `BorderRadius.circular()`, `EdgeInsets.all()` inline |
| const constructor | StatelessWidget có `const` |
| mounted check | Sau `await`, check `mounted` |

### 8️⃣ UPDATE STATUS + AUTO-LOOP REVIEW

```bash
./.git_hooks/vnpt_workflow update {feature} dev progress "Đang code"
./.git_hooks/vnpt_workflow update {feature} dev done "Code xong"
# → Auto-loop review (max 3 vòng)
```

## 🔑 CRITICAL RULES

1. **Slash command = lệnh thực thi** → làm ngay, KHÔNG hỏi
2. **ĐỘC LẬP với workflow create cũ** — KHÔNG sửa `vnpt-workflow.mdc`, CLI, hooks khác
3. **KHÔNG sửa code cũ trong `color_app.dart`** — CHỈ append token mới
4. **Typography = Flutter `TextStyle(...)`** inline
5. **Spacing/Radius = inline numbers** trong code
6. **Auto-loop review** sau dev done (max 3 vòng)
7. **QUAN TRỌNG**: `--html` và `--css` là BẮT BUỘC — nếu thiếu phải báo lỗi rõ ràng
""".format(prompt=prompt, ctx=ctx, feature=feature, flags=flags_joined, html_path=html_path, css_path=css_path, srs=srs, postman=postman, project_root=project_root)
    print(msg)
elif cmd == "update":
    print("""🔄 **UPDATE STATUS**

Feature `{feature}`. ARGS: `{extra}`

```bash
cd {project_root}
./.git_hooks/vnpt_workflow update {feature} <stage> <status> "<note>"
```

Stages: dev | review | fix
Status: pending | progress | done | no_bug | failed

CLI mới đã tự sửa file `DEVELOPMENT_STATUS.md` (không chỉ log).

Emoji: pending=⏳, progress=🔄, done=✅, no_bug=🧼, failed=❌
""".format(feature=feature, extra=extra, project_root=project_root))
elif cmd == "review":
    print("""🔍 **REVIEW CODE**

Review feature `{feature}`.

```bash
./.git_hooks/vnpt_workflow update {feature} review progress "Đang review"
```

Đọc file trong `<module>/{feature}/` + `review-criteria.mdc`.

**Không bug:**
```bash
./.git_hooks/vnpt_workflow update {feature} review no_bug "Clean code"
./.git_hooks/vnpt_workflow update {feature} review done "Feature hoàn thành"
```

**Có bug:**
```bash
./.git_hooks/vnpt_workflow update {feature} review failed "Tìm thấy N bugs"
./.git_hooks/vnpt_workflow update {feature} fix progress "Bắt đầu fix"
```
""".format(feature=feature))
elif cmd == "fix":
    print("""🐛 **FIX BUGS**

Fix feature `{feature}`.

```bash
./.git_hooks/vnpt_workflow update {feature} fix progress "Fixing bugs"
```

Đọc Bugs Log từ DEVELOPMENT_STATUS.md, fix từng bug.

```bash
./.git_hooks/vnpt_workflow update {feature} fix done "Đã fix N bugs"
./.git_hooks/vnpt_workflow update {feature} review pending "Reset để review lại"
```
""".format(feature=feature))
elif cmd == "status":
    target = feature if feature else ""
    print("""📊 **STATUS**

{info}

```bash
cd {project_root}
./.git_hooks/vnpt_workflow status {target}
```
""".format(target=target, info=('Feature: `'+target+'`' if target else 'Tất cả features'), project_root=project_root))
elif cmd == "list":
    print("""📁 **LIST FEATURES**

```bash
cd {project_root}
./.git_hooks/vnpt_workflow list
```
""".format(project_root=project_root))
elif cmd == "help":
    print("""📖 **HELP**

| Command | Mô tả |
|---------|-------|
| `/vnpt_workflow_create <tên> [--srs <file>] [--figma <url>] [--postman <name>] [--module <path>]` | Tạo feature từ Figma |
| `/vnpt_workflow_stitch2flutter <tên> --html <path> --css <path> [--srs <file>] [--postman <name>]` | Tạo feature từ Stitch HTML + CSS |
| `/vnpt_workflow_update <tên> <stage> <status> [note]` | Update status |
| `/vnpt_workflow_status [tên]` | Xem trạng thái |
| `/vnpt_workflow_list` | List tất cả |
| `/vnpt_workflow_review <tên>` | Code review |
| `/vnpt_workflow_fix <tên>` | Fix bugs |

Stages: dev | review | fix
Status: pending | progress | done | no_bug | failed

**Stitch2Flutter Usage:**
```bash
/vnpt_workflow_stitch2flutter login_screen \\
  --html export/login.html \\
  --css export/styles.md
```
""")
else:
    print("⚠️ Unknown command: `{0}`. Gõ `/vnpt_workflow_help`.".format(cmd))
PYEOF
)
USER_MSG_DISPLAY="$USER_MSG_DISPLAY" AGENT_MSG="$AGENT_MSG" python3 -c "
import os, json
print(json.dumps({'user_message': os.environ.get('USER_MSG_DISPLAY',''), 'agent_message': os.environ.get('AGENT_MSG','')}, ensure_ascii=False))
"
