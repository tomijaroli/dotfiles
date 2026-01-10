#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${1:-}" ]]; then
  echo "Usage: $0 <profile-name>"
  exit 2
fi

PROFILE="$1"

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
TARGET_DIR="$DOTFILES_DIR/dock/.config/dock/profiles"
mkdir -p "$TARGET_DIR"

TARGET_FILE="$TARGET_DIR/dock-${PROFILE}.plist"
BACKUP_FILE="${TARGET_FILE}.bak"

if [[ -f "$TARGET_FILE" ]]; then
  echo "⚠️  Profile already exists: $TARGET_FILE"
  echo "Choose an option:"
  echo "  1) Do nothing"
  echo "  2) Backup existing file to: ${BACKUP_FILE} and overwrite"
  echo "  3) Overwrite"

  read -rp "Enter choice [1/2/3]: " choice
  case "$choice" in
    1)
      echo "Cancelled, no changes were made."
      exit 0
      ;;
    2)
      echo "Backing up existing profile to: $BACKUP_FILE"
      cp "$TARGET_FILE" "$BACKUP_FILE"
      ;;
    3)
      echo "Overwriting existing profile."
      ;;
    *)
      echo "Invalid option. Exited."
      exit 1
      ;;
  esac
fi

echo "Exporting current Dock to: $TARGET_FILE"
defaults export com.apple.dock "$TARGET_FILE"
echo "✅ Export complete"

