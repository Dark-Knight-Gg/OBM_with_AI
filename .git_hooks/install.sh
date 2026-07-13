#!/bin/bash
# Script cài đặt pre-commit hook
# Self-relocating: hoạt động từ bất kỳ vị trí nào

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GIT_HOOKS_DIR="$(cd "$SCRIPT_DIR/../.git/hooks" && pwd)"
PRE_COMMIT_SOURCE="$SCRIPT_DIR/pre-commit"

if [[ ! -f "$PRE_COMMIT_SOURCE" ]]; then
    echo "ERROR: pre-commit not found at $PRE_COMMIT_SOURCE"
    exit 1
fi

echo "Linking pre-commit hook to $GIT_HOOKS_DIR..."

cd "$GIT_HOOKS_DIR"
ln -sf "../../.git_hooks/pre-commit" pre-commit
chmod +x "$PRE_COMMIT_SOURCE"
chmod +x pre-commit

echo "✅ Pre-commit hook installed successfully!"
echo ""
echo "Hook sẽ tự động chạy trước mỗi commit để:"
echo "  • Format code (flutter format)"
echo "  • Analyze code (flutter analyze)"
echo "  • Kiểm tra TODO comments"
echo "  • Kiểm tra print statements"
echo "  • Kiểm tra hardcoded colors"
