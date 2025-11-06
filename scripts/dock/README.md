# Dock Profile Manager Scripts

This directory contains the Dock profile switching system.

## Scripts

| Script | Purpose |
|--------|--------|
| `dock.sh` | Main CLI to switch profiles |
| `switch-default.sh` | Shortcut → switches to `default` profile |
| `switch-dev.sh` | Shortcut → switches to `dev` profile |
| `switch-studio.sh` | Shortcut → switches to `studio` profile |
| `export-dock.sh` | Export current Dock to a plist profile |

## Installation / Linking

Scripts are symlinked to `~/.local/bin` by the installer:

```bash
~/dotfiles/scripts/dock/install-dock-profile-manager.sh
```

After install, you can run:

```bash
dock default
dock dev
dock studio
dock-export
```

## Usage

### Switch Dock profile
```bash
dock <default|dev|studio>
```

### Export current Dock configuration
```bash
dock-export default
dock-export dev
dock-export studio
```

### Features
- Automatically detects current profile
- Only switches when target differs
- Verifies app existence in profile
- Clean readable output like:

```
[dev] OK Finder (/System/Applications/Finder.app)
[dev] MISSING Chrome (/Applications/Google Chrome.app)
```

No backups are created — Dock changes are fully reversible via `dock-export`.

## Notes
- Make sure `~/.local/bin` is in your `$PATH`
- Works on macOS (Bash 3.x & 5.x)
