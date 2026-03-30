#!/bin/bash
# Hook: Kjører Prettier automatisk etter filendringer
INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if echo "$FILE_PATH" | grep -qE '\.(ts|tsx|js|jsx|css|json)$'; then
  if command -v npx &> /dev/null && [ -f "node_modules/.bin/prettier" ]; then
    npx prettier --write "$FILE_PATH" 2>/dev/null
  fi
fi

exit 0
