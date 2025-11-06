#!/usr/bin/env bash
set -euo pipefail

echo "▶️  Installing Dock Profile Manager…"

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

DOCK_SCRIPTS="$HOME/dotfiles/scripts/dock"

# Make scripts executable
for file in "$DOCK_SCRIPTS"/*.sh; do
  [[ -e "$file" ]] || continue
  chmod +x "$file"
done

# List scripts and command names in pairs
LINKS=(
  "$DOCK_SCRIPTS/dock.sh"          "dock"
  "$DOCK_SCRIPTS/switch-default.sh" "dock-default"
  "$DOCK_SCRIPTS/switch-dev.sh"     "dock-dev"
  "$DOCK_SCRIPTS/switch-studio.sh"  "dock-studio"
  "$DOCK_SCRIPTS/export-dock.sh"    "dock-export"
)

echo "🔗 Linking dock scripts into $BIN_DIR"

# Loop in pairs: src dest
for ((i=0; i<${#LINKS[@]}; i+=2)); do
  src="${LINKS[i]}"
  dest="$BIN_DIR/${LINKS[i+1]}"

  if [[ -L "$dest" || -e "$dest" ]]; then
    echo "  ⏭️  Already exists: $dest"
  else
    ln -s "$src" "$dest"
    echo "  ✅ Linked: $dest → $src"
  fi
done

echo "✅ Dock scripts installed"
echo "   Run: dock <default|dev|studio>"

