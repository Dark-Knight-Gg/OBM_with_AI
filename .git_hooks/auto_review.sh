#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'; BOLD='\033[1m'
print_banner() {
  echo -e "${CYAN}${BOLD}"; echo "╔══════════════════════════════════════════════════════════╗"; echo "║          AUTO REVIEW - Bug Scanner                       ║"; echo "╚══════════════════════════════════════════════════════════╝"; echo -e "${NC}"
}
print_section() { echo -e "${CYAN}━━━ $1 ━━━${NC}"; }
print_pass() { echo -e "${GREEN}✅ PASS:${NC} $1"; }
print_fail() { echo -e "${RED}❌ FAIL:${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }

FEATURE_DIR="${1:-}"
FEATURE_NAME="${2:-}"

if [ -z "$FEATURE_DIR" ] || [ -z "$FEATURE_NAME" ]; then
  echo "Usage: $0 <feature_dir> <feature_name>"
  exit 1
fi

if [ ! -d "$FEATURE_DIR" ]; then
  echo "❌ Feature directory not found: $FEATURE_DIR"
  exit 1
fi

print_banner
echo -e "${BOLD}Feature:${NC} $FEATURE_NAME"
echo -e "${BOLD}Dir:${NC} $FEATURE_DIR"
echo ""

REPORT_FILE="$FEATURE_DIR/.vnpt_cache/report_$(date '+%Y%m%d_%H%M%S').md"
BUGS_FOUND=0
BUGS_FIXED=0

# Initialize report
cat > "$REPORT_FILE" << EOF
# 🔍 Auto Review Report: $FEATURE_NAME

> Generated: $(date '+%Y-%m-%d %H:%M')
> Feature: $FEATURE_NAME
> Path: $FEATURE_DIR

---

EOF

# ═══════════════════════════════════════════════════════════════
# CHECK 1: Scaffold in screen files
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 1: Screen uses BaseScreen (not Scaffold)"

SCAFFOLD_COUNT=$(grep -r "return Scaffold(" "$FEATURE_DIR" --include="*.dart" 2>/dev/null | wc -l || echo "0")
if [ "$SCAFFOLD_COUNT" -eq 0 ]; then
  print_pass "No direct Scaffold found in screen files"
  echo "✅ **PASS**: Không dùng `Scaffold` trực tiếp\n" >> "$REPORT_FILE"
else
  print_fail "Found $SCAFFOLD_COUNT direct Scaffold usage(s)"
  echo "❌ **FAIL**: Tìm thấy $SCAFFOLD_COUNT lần dùng `Scaffold` trực tiếp\n" >> "$REPORT_FILE"
  echo "**Cần fix:** Đổi sang `BaseScreen`\n" >> "$REPORT_FILE"
  grep -rn "return Scaffold(" "$FEATURE_DIR" --include="*.dart" >> "$REPORT_FILE" 2>/dev/null || true
  BUGS_FOUND=$((BUGS_FOUND+SCAFFOLD_COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 2: AppBar/ProgressHUD in body widgets
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 2: Body widget không có AppBar/ProgressHUD"

BODY_DIR="$FEATURE_DIR/widget"
APPBAR_COUNT=0
PROGRESSHUD_COUNT=0
if [ -d "$BODY_DIR" ]; then
  APPBAR_COUNT=$(grep -r "appBar: AppBar\|AppBar(" "$BODY_DIR" --include="*.dart" 2>/dev/null | wc -l || echo "0")
  PROGRESSHUD_COUNT=$(grep -r "ProgressHUD" "$BODY_DIR" --include="*.dart" 2>/dev/null | wc -l || echo "0")
fi

if [ "$APPBAR_COUNT" -eq 0 ] && [ "$PROGRESSHUD_COUNT" -eq 0 ]; then
  print_pass "Body widget clean (no AppBar/ProgressHUD)"
  echo "✅ **PASS**: Body widget không có `AppBar`/`ProgressHUD`\n" >> "$REPORT_FILE"
else
  TOTAL=$((APPBAR_COUNT + PROGRESSHUD_COUNT))
  print_fail "Found $APPBAR_COUNT AppBar + $PROGRESSHUD_COUNT ProgressHUD in body widget"
  echo "❌ **FAIL**: Tìm thấy AppBar/ProgressHUD trong body widget\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+TOTAL))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 3: Hardcoded colors (Color(0xFF...) or Colors.xxx)
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 3: Hardcoded colors"

HARDCODED_COLORS=$(grep -rn "Color(0x\|Colors\." "$FEATURE_DIR" --include="*.dart" 2>/dev/null | grep -v "ColorApp\|import " || true)
if [ -z "$HARDCODED_COLORS" ]; then
  print_pass "No hardcoded colors"
  echo "✅ **PASS**: Không có hardcoded colors\n" >> "$REPORT_FILE"
else
  COUNT=$(echo "$HARDCODED_COLORS" | wc -l | tr -d ' ')
  print_fail "Found $COUNT hardcoded color(s)"
  echo "❌ **FAIL**: Tìm thấy $COUNT hardcoded color(s)\n" >> "$REPORT_FILE"
  echo "**Cần fix:** Thay bằng `ColorApp.*`\n" >> "$REPORT_FILE"
  echo "\`\`\`dart" >> "$REPORT_FILE"
  echo "$HARDCODED_COLORS" >> "$REPORT_FILE"
  echo "\`\`\`\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 4: Hardcoded strings (Text('...'))
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 4: Hardcoded strings"

HARDCODED_STRINGS=$(grep -rn "Text('" "$FEATURE_DIR" --include="*.dart" 2>/dev/null | grep -v "LocaleKeys\|import " || true)
if [ -z "$HARDCODED_STRINGS" ]; then
  print_pass "No hardcoded strings"
  echo "✅ **PASS**: Không có hardcoded strings\n" >> "$REPORT_FILE"
else
  COUNT=$(echo "$HARDCODED_STRINGS" | wc -l | tr -d ' ')
  print_fail "Found $COUNT hardcoded string(s)"
  echo "❌ **FAIL**: Tìm thấy $COUNT hardcoded string(s)\n" >> "$REPORT_FILE"
  echo "**Cần fix:** Thay bằng `LocaleKeys.*` hoặc `OneUiText.*`\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 5: Hardcoded URLs
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 5: Hardcoded URLs"

HARDCODED_URLS=$(grep -rn "https\?://" "$FEATURE_DIR" --include="*.dart" 2>/dev/null | grep -v "UrlEOffice\|import " || true)
if [ -z "$HARDCODED_URLS" ]; then
  print_pass "No hardcoded URLs"
  echo "✅ **PASS**: Không có hardcoded URLs\n" >> "$REPORT_FILE"
else
  COUNT=$(echo "$HARDCODED_URLS" | wc -l | tr -d ' ')
  print_fail "Found $COUNT hardcoded URL(s)"
  echo "❌ **FAIL**: Tìm thấy $COUNT hardcoded URL(s)\n" >> "$REPORT_FILE"
  echo "**Cần fix:** Thay bằng `UrlEOffice.*`\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 6: print/debugPrint statements
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 6: print/debugPrint statements"

PRINT_COUNT=$(grep -rn "^\s*print(\|^\s*debugPrint(" "$FEATURE_DIR" --include="*.dart" 2>/dev/null | wc -l || echo "0")
if [ "$PRINT_COUNT" -eq 0 ]; then
  print_pass "No print/debugPrint statements"
  echo "✅ **PASS**: Không có print/debugPrint\n" >> "$REPORT_FILE"
else
  print_fail "Found $PRINT_COUNT print/debugPrint statement(s)"
  echo "❌ **FAIL**: Tìm thấy $PRINT_COUNT print/debugPrint\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+PRINT_COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 7: TODO comments
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 7: TODO comments"

TODO_COUNT=$(grep -rn "TODO\|FIXME\|XXX\|HACK" "$FEATURE_DIR" --include="*.dart" 2>/dev/null | wc -l || echo "0")
if [ "$TODO_COUNT" -eq 0 ]; then
  print_pass "No TODO comments"
  echo "✅ **PASS**: Không có TODO comments\n" >> "$REPORT_FILE"
else
  print_warning "Found $TODO_COUNT TODO/FIXME comment(s)"
  echo "⚠️ **WARNING**: Tìm thấy $TODO_COUNT TODO/FIXME\n" >> "$REPORT_FILE"
  echo "**Cần xử lý:** Xóa hoặc implement\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+TODO_COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 8: ConsumerBase (should be SelectorBase)
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 8: SelectorBase vs ConsumerBase"

CONSUMER_COUNT=$(grep -rn "ConsumerBase" "$FEATURE_DIR" --include="*.dart" 2>/dev/null | wc -l || echo "0")
if [ "$CONSUMER_COUNT" -eq 0 ]; then
  print_pass "Using SelectorBase (not ConsumerBase)"
  echo "✅ **PASS**: Dùng `SelectorBase` thay vì `ConsumerBase`\n" >> "$REPORT_FILE"
else
  print_fail "Found $CONSUMER_COUNT ConsumerBase usage(s)"
  echo "❌ **FAIL**: Tìm thấy $CONSUMER_COUNT `ConsumerBase` (nên đổi sang `SelectorBase`)\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+CONSUMER_COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 9: mounted check after await
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 9: mounted check after await"

MOUNTED_ISSUES=$(grep -B2 -A2 "await " "$FEATURE_DIR" --include="*.dart" -r 2>/dev/null | grep -B1 -A1 "setState\|notifyListeners" | grep -v "mounted" | wc -l || echo "0")
if [ "$MOUNTED_ISSUES" -eq 0 ]; then
  print_pass "mounted checks present"
  echo "✅ **PASS**: Có mounted check sau await\n" >> "$REPORT_FILE"
else
  print_fail "Possible missing mounted checks: $MOUNTED_ISSUES"
  echo "❌ **FAIL**: Có thể thiếu mounted check sau await\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+MOUNTED_ISSUES))
fi

# ═══════════════════════════════════════════════════════════════
# CHECK 10: setState in Provider
# ═══════════════════════════════════════════════════════════════
print_section "CHECK 10: No setState in Provider"

SETSTATE_COUNT=$(grep -rn "setState(" "$FEATURE_DIR/component" --include="*.dart" 2>/dev/null | wc -l || echo "0")
if [ "$SETSTATE_COUNT" -eq 0 ]; then
  print_pass "Provider uses notifyListeners"
  echo "✅ **PASS**: Provider không dùng `setState`\n" >> "$REPORT_FILE"
else
  print_fail "Found $SETSTATE_COUNT setState in Provider"
  echo "❌ **FAIL**: Tìm thấy $SETSTATE_COUNT `setState` trong Provider\n" >> "$REPORT_FILE"
  echo "**Cần fix:** Dùng `notifyListeners()`\n" >> "$REPORT_FILE"
  BUGS_FOUND=$((BUGS_FOUND+SETSTATE_COUNT))
fi

# ═══════════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${BOLD}══════════════════════════════════════════════════════════${NC}"
if [ "$BUGS_FOUND" -eq 0 ]; then
  echo -e "${GREEN}${BOLD}✅ REVIEW PASSED - No bugs found!${NC}"
  echo ""
  echo "## 📊 Summary" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "| Metric | Value |" >> "$REPORT_FILE"
  echo "|--------|-------|" >> "$REPORT_FILE"
  echo "| Bugs Found | 0 |" >> "$REPORT_FILE"
  echo "| Status | ✅ CLEAN |" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "*Review completed successfully*" >> "$REPORT_FILE"
  exit 0
else
  echo -e "${RED}${BOLD}❌ REVIEW FAILED - $BUGS_FOUND bug(s) found${NC}"
  echo ""
  echo "## 📊 Summary" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "| Metric | Value |" >> "$REPORT_FILE"
  echo "|--------|-------|" >> "$REPORT_FILE"
  echo "| Bugs Found | $BUGS_FOUND |" >> "$REPORT_FILE"
  echo "| Status | ❌ NEEDS FIX |" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "---" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "## 🔧 Action Required" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "Agent cần đọc report này và fix các bugs theo thứ tự ưu tiên:" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "1. Đọc file report: \`$REPORT_FILE\`" >> "$REPORT_FILE"
  echo "2. Fix từng bug theo mô tả" >> "$REPORT_FILE"
  echo "3. Chạy lại: \`$SCRIPT_DIR/auto_review.sh $FEATURE_DIR $FEATURE_NAME\`" >> "$REPORT_FILE"
  echo "4. Lặp cho đến khi BUGS_FOUND = 0" >> "$REPORT_FILE"
  echo "" >> "$REPORT_FILE"
  echo "*Agent MUST fix all bugs before proceeding*" >> "$REPORT_FILE"
  exit 1
fi
