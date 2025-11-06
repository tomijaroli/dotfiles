#!/usr/bin/env bash
set -euo pipefail

echo "▶️  Installing Dock Profile Manager…"

# Where to link binaries
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

DOCK_SCRIPTS="$HOME/dotfiles/scripts/dock"

# Ensure scripts are executable
chmod +x "$DOCK_SCRIPTS"/*.sh

# Scripts to link
declare -A DOCK_LINKS=(
  ["$DOCK_SCRIPTS/dock.sh"]="dock"
  ["$DOCK_SCRIPTS/switch-default.sh"]="dock-default"
  ["$DOCK_SCRIPTS/switch-dev.sh"]="dock-dev"
  ["$DOCK_SCRIPTS/switch-studio.sh"]="dock-studio"
)

echo "🔗 Linking dock scripts into $BIN_DIR"
for src in "${!DOCK_LINKS[@]}"; do
  dest="$BIN_DIR/${DOCK_LINKS[$src]}"
  if [[ -L "$dest" || -e "$dest" ]]; then
    echo "  ⏭️  Already exists: $dest"
  else
    ln -s "$src" "$dest"
    echo "  ✅ Linked: $dest → $src"
  fi
done

echo "✅ Dock scripts installed"
echo "   Run: dock <default|dev|studio>"

