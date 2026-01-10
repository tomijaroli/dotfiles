# Foot Terminal Configuration

Fast, lightweight Wayland-native terminal emulator for Linux.

## Structure

```
foot/
  .config/foot/
    foot.ini    # Main configuration
```

## What It Does

Provides a Foot terminal configuration matching the Alacritty Linux setup:
- Nord color scheme
- Meslo LGM Nerd Font (14pt)
- 0.8 opacity
- Block cursor, no blinking
- Vim-style keybindings

## Platform

**Linux only** - Foot is Wayland-native and not available on macOS.

## Configuration Highlights

**Font:** Meslo LGM Nerd Font, size 14  
**Colors:** Nord theme (matching Alacritty)  
**Window:** 164x36 chars, 4x4 padding, 0.8 opacity  
**Scrollback:** 10,000 lines  
**Mouse:** Hide when typing

## Key Bindings

**Scrolling:**
- `Shift + PageUp/Down` - Page scroll
- `Ctrl + Shift + Up/Down` - Line scroll
- `Ctrl + Shift + Home/End` - Top/bottom

**Font size:**
- `Ctrl + Plus/=` - Increase
- `Ctrl + Minus` - Decrease
- `Ctrl + 0` - Reset

**Clipboard:**
- `Ctrl + Shift + C` - Copy
- `Ctrl + Shift + V` - Paste
- `Shift + Insert` - Primary paste

**Search:**
- `Ctrl + Shift + F` - Start search
- `Ctrl + G` - Next match

## Installation

The installer automatically stows this on Linux systems.

## Customization

Edit `foot.ini` to change:
- Font, colors, padding
- Key bindings
- Terminal behavior

See `man foot.ini` for all options.

## Why Foot?

- **Fast**: Written in C, minimal resource usage
- **Wayland-native**: No X11 dependencies
- **Battery efficient**: Lower power consumption than GPU-accelerated terminals
- **Simpler**: Single config file, straightforward options

## Notes

- Alternative to Alacritty for pure Wayland setups
- Lighter weight than Alacritty
- No GPU acceleration (uses CPU rendering)
- Requires Wayland compositor (Hyprland, Sway, etc.)
