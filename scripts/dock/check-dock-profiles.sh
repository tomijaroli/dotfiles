#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-}"
PROFILES_DIR="$HOME/.config/dock/profiles"

if [[ -z "$PROFILE" ]]; then
    echo "Usage: check-dock-profiles.sh <profile>"
    exit 1
fi

PLIST="$PROFILES_DIR/dock-$PROFILE.plist"

if [[ ! -f "$PLIST" ]]; then
    echo "❌ Profile not found: $PLIST"
    exit 2
fi

# Colors
GRAY="\033[90m"
GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

APP_PATHS=$(defaults read "$PLIST" persistent-apps \
  | grep '_CFURLString"' \
  | sed -E 's/^.*_CFURLString" = "file:\/\/(.*)";/\1/' \
  | sed 's/%20/ /g')

MISSING=0

while IFS= read -r APP; do
    [[ -z "$APP" ]] && continue

    # Strip /Applications/ and .app to get name
    APP_NAME="$(basename "$APP" .app)"

    if [[ -e "$APP" ]]; then
        printf "[%s] %bOK%b %s %b - %s%b\n" \
          "$PROFILE" "$GREEN" "$RESET" "$APP_NAME" "$GRAY" "$APP" "$RESET"
    else
        printf "[%s] %bMISSING%b %s %b - %s%b\n" \
          "$PROFILE" "$RED" "$RESET" "$APP_NAME" "$GRAY" "$APP" "$RESET"
        MISSING=1
    fi
done <<< "$APP_PATHS"

exit $MISSING

