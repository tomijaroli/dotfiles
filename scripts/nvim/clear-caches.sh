#!/usr/bin/env bash
# Remove plugins and caches from a previous Neovim install (lazy.nvim, Mason,
# packer, luacache, …) so the next launch can install via vim.pack.
# Does not touch ~/.config/nvim or ~/.config/xim.
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: clear-caches.sh [--dry-run] [--yes]

Clear Neovim plugin data and caches for nvim and xim. Config files are left
alone (run this after the new config is already checked out / stowed).

  --dry-run   Print paths that would be removed
  --yes       Do not ask for confirmation
EOF
}

DRY_RUN=0
YES=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --yes | -y) YES=1 ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      usage >&2
      exit 2
      ;;
  esac
done

DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
APPS=(nvim xim)

info() { printf '\033[1;34m%s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m%s\033[0m\n' "$*"; }

targets=()
for app in "${APPS[@]}"; do
  targets+=("$DATA_HOME/$app" "$STATE_HOME/$app" "$CACHE_HOME/$app")
done

existing=()
for path in "${targets[@]}"; do
  if [[ -e $path ]]; then
    existing+=("$path")
  fi
done

if [[ ${#existing[@]} -eq 0 ]]; then
  info "Nothing to clear. Next nvim / xim launch will install plugins via vim.pack."
  exit 0
fi

info "Will remove (plugins, state, cache — not ~/.config):"
for path in "${existing[@]}"; do
  echo "  $path"
done

if [[ $DRY_RUN -eq 1 ]]; then
  info "Dry run; nothing deleted."
  exit 0
fi

if pgrep -x nvim >/dev/null 2>&1; then
  warn "Neovim is running. Quit it first so files are not recreated."
  exit 1
fi

if [[ $YES -ne 1 ]]; then
  read -r -p "Continue? [y/N] " reply
  case "$reply" in
    y | Y | yes | YES) ;;
    *)
      info "Aborted."
      exit 0
      ;;
  esac
fi

rm -rf "${existing[@]}"
info "Cleared. Open nvim (and xim on macOS) to install plugins from the lockfile."
