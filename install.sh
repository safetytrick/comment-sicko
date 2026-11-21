#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok       $dest"
  elif [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "skipped  $dest (already exists)"
  else
    ln -s "$src" "$dest"
    echo "linked   $dest"
  fi
}

link "$repo/agents/comment-sicko.md" "$claude/agents/comment-sicko.md"
link "$repo/skills/no-comments" "$claude/skills/no-comments"
