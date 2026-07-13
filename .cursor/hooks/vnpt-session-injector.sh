#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# VNPT WORKFLOW SESSION INJECTOR (v2 — conditional)
# Inject workflow instructions vào session context. Cursor sẽ dùng
# description-based matching để trigger rule tương ứng.
#
# Trigger: sessionStart
# Output:  { "additional_context": "..." }
# ═══════════════════════════════════════════════════════════════
#!/bin/bash
set -e
INPUT=$(cat)

# Build additional context — chỉ nhắc commands, KHÔNG ép phải dùng
cat << 'EOF'
{
  "additional_context": "ℹ️ VNPT Workflow slash commands có sẵn (CHỈ DÙNG KHI USER GÕ):\n  • /vnpt_workflow_create <tên> — tạo feature mới\n  • /vnpt_workflow_update <tên> <stage> <status> — update dev/review/fix\n  • /vnpt_workflow_status [tên] — xem trạng thái\n  • /vnpt_workflow_list — list tất cả features\n  • /vnpt_workflow_review <tên> — code review\n  • /vnpt_workflow_fix <tên> — fix bugs\n  • /vnpt_workflow_help — help\n\nQUAN TRỌNG: Những command này CHỈ trigger workflow khi user GÕ RÕ slash command trong prompt. Khi user chat bình thường (không có slash command), hãy phản hồi bình thường — KHÔNG tự ý chạy workflow."
}
EOF

exit 0
