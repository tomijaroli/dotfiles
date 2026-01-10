#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-}"
PROFILES_DIR="$HOME/.config/dock/profiles"
CHECKER="$HOME/dotfiles/scripts/dock/check-dock-profiles.sh"

if [[ -z "$PROFILE" ]]; then
  echo "Usage: dock <default|dev|studio>"
  exit 1
fi

PLIST="$PROFILES_DIR/dock-$PROFILE.plist"
if [[ ! -f "$PLIST" ]]; then
  echo "❌ Profile not found: $PLIST"
  exit 2
fi

echo "📂 Target profile: $PROFILE"

### ─────────────────────────────────────────────
### Detect current dock profile
### ─────────────────────────────────────────────
CURRENT_PROFILE=""
CURRENT_TMP="/tmp/current-dock.plist"
NORMALIZED_CURRENT="/tmp/current-dock-normalized.plist"

# Export current dock, normalize
defaults export com.apple.dock "$CURRENT_TMP" >/dev/null 2>&1 || true
plutil -convert xml1 "$CURRENT_TMP" -o "$CURRENT_TMP" 2>/dev/null

plutil -convert xml1 "$CURRENT_TMP" -o - \
  | xmllint --format - \
  | sed '/<key>mod-count<\/key>/,/[^0-9]/d' \
  > "$NORMALIZED_CURRENT"

# Loop through known profiles and match normalized content
for p in "$PROFILES_DIR"/dock-*.plist; do
  PROFILE_NAME="$(basename "$p" .plist | sed 's/^dock-//')"

  NORMALIZED_PROFILE="/tmp/dock-$PROFILE_NAME-normalized.plist"

  plutil -convert xml1 "$p" -o - \
    | xmllint --format - \
    | sed '/<key>mod-count<\/key>/,/[^0-9]/d' \
    > "$NORMALIZED_PROFILE"

  if diff -q "$NORMALIZED_CURRENT" "$NORMALIZED_PROFILE" >/dev/null 2>&1; then
    CURRENT_PROFILE="$PROFILE_NAME"
    break
  fi
done

rm -f "$CURRENT_TMP" "$NORMALIZED_CURRENT" /tmp/dock-*-normalized.plist

if [[ -n "${CURRENT_PROFILE}" ]]; then
  echo "🧠 Currently active Dock profile: ${CURRENT_PROFILE}"
else
  echo "⚠️  Unable to detect current Dock profile"
fi

### ─────────────────────────────────────────────
### Skip if already on target
### ─────────────────────────────────────────────
if [[ "$CURRENT_PROFILE" == "$PROFILE" ]]; then
  echo "✅ Dock already set to '$PROFILE' — nothing to do"
  exit 0
fi

### ─────────────────────────────────────────────
### Switch Dock to new profile
### ─────────────────────────────────────────────
echo "🔄 Switching Dock → $PROFILE"
defaults import com.apple.dock "$PLIST"
killall Dock >/dev/null 2>&1 || true

### ─────────────────────────────────────────────
### Run checker for only this profile
### ─────────────────────────────────────────────
echo "🔍 Verifying Dock apps for: $PROFILE"
"$CHECKER" "$PROFILE" || true


echo "✅ Dock switched to '$PROFILE'"

