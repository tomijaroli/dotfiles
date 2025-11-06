# Dock switch wrapper
dock() {
  command dock "$@"
}

# Export Dock state
dock-export() {
  command dock-export "$@"
}

# Autocomplete profiles
_dock_profiles() {
  local profiles_dir="$HOME/.config/dock/profiles"
  local -a profs

  if [[ -d "$profiles_dir" ]]; then
    profs=(${profiles_dir}/dock-*.plist)
    profs=("${profs[@]##*/}")     # remove path
    profs=("${profs[@]%.plist}")  # remove .plist
    profs=("${profs[@]#dock-}")   # remove prefix
  fi

  _describe 'dock profiles' profs
}

compdef _dock_profiles dock

