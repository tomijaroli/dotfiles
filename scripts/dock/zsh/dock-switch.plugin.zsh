dock() {
"$HOME/dotfiles/scripts/dock/dock.sh" "$1"
}

_dock_profiles() {
local profiles_dir="$HOME/.config/dock/profiles"
local -a profs
if [[ -d "$profiles_dir" ]]; then
profs=( $(ls "$profiles_dir" | sed -e 's/^dock-//' -e 's/\.plist$//') )
fi
_describe 'dock profiles' profs
}

compdef _dock_profiles dock
