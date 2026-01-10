# Fonts

Nerd Font patched fonts with icon support for terminals and editors.

## Structure

```
fonts/
  install.sh       # Cross-platform font installer
  Hack/            # Hack Nerd Font (all variants)
  Meslo/           # Meslo Nerd Font (all variants)
```

## Included Fonts

**Hack Nerd Font:**
- Monospace font for coding
- Complete icon support
- Regular, Bold, Italic, Bold Italic

**Meslo LG Nerd Font:**
- Powerline-compatible
- Used in Alacritty configuration
- Multiple variants (L, M, S, LG, etc.)

## Installation

### Automatic

The main installer automatically runs `fonts/install.sh`.

### Manual

```bash
cd ~/dotfiles/fonts
./install.sh
```

**Platform behavior:**
- **macOS**: Opens fonts in Font Book for installation
- **Linux**: Copies to `~/.local/share/fonts/` and updates font cache

## Adding More Fonts

1. Download Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/)
2. Extract to `fonts/FontName/`
3. Add font name to `SUPPORTED_FONTS` array in `install.sh`:
   ```bash
   SUPPORTED_FONTS=(Hack Meslo FontName)
   ```

## Font Names

Font names differ between platforms:

| Font | macOS | Linux |
|------|-------|-------|
| Meslo | MesloLGS NF | Meslo LGM Nerd Font |
| Hack | Hack Nerd Font | Hack Nerd Font |

This is why platform-specific configs exist for terminal emulators.

## Verification

**macOS:**
```bash
# Check Font Book or:
system_profiler SPFontsDataType | grep -i meslo
```

**Linux:**
```bash
fc-list | grep -i meslo
fc-cache -fv  # Rebuild font cache if needed
```

## Notes

- All fonts include Nerd Font icons (glyphs)
- Required for proper rendering of powerline prompts
- Used by Alacritty, terminal prompts, and status bars
- Windows Compatible variants included but not required
