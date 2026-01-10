# Alacritty Configuration

Cross-platform terminal emulator configuration with platform-specific overrides.

## Structure

```
alacritty/
  .config/alacritty/
    alacritty.common.toml      # Shared settings
    alacritty.macos.toml       # macOS overrides
    alacritty.linux.toml       # Linux overrides
    alacritty.toml             # Symlink (gitignored)
    themes/                    # Color schemes
```

## Platform Differences

| Setting | macOS | Linux |
|---------|-------|-------|
| Font | MesloLGS NF | Meslo LGM Nerd Font |
| Decorations | Full | None |
| Opacity | 1.0 | 0.8 |

Everything else (cursor, keybindings, colors, etc.) is shared in `alacritty.common.toml`.

## Installation

The installer automatically:
1. Stows the directory via GNU Stow
2. Creates platform-specific symlink to `alacritty.toml`

**Manual setup:**
```bash
# macOS
ln -sf ~/.config/alacritty/alacritty.macos.toml ~/.config/alacritty/alacritty.toml

# Linux
ln -sf ~/.config/alacritty/alacritty.linux.toml ~/.config/alacritty/alacritty.toml
```

## Customization

**Change theme** (edit line 1 of `alacritty.common.toml`):
```toml
general.import = ["~/.config/alacritty/themes/nord.toml"]
```
Available: `nord`, `catppuccin_macchiato`, `nordic`, `onedark`, `tokyonight`

**Change font size** (edit `alacritty.common.toml`):
```toml
[font]
size = 14.0
```

**Platform-specific changes:**
- macOS: edit `alacritty.macos.toml`
- Linux: edit `alacritty.linux.toml`
- Common: edit `alacritty.common.toml`

## Key Bindings

- **Alt + ←/→**: Word navigation
- **Cmd + ←/→** (macOS): Line start/end
- **Alt + Backspace**: Delete word
- **Shift + PgUp/PgDn**: Scroll

## Troubleshooting

**Font not found:**
```bash
# macOS
open ~/dotfiles/fonts/Meslo/*.ttf

# Linux
fc-list | grep Meslo
```

**Config not loading:**
```bash
ls -la ~/.config/alacritty/alacritty.toml  # Check symlink
```
