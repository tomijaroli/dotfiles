# Hyprland Configuration

Dynamic tiling Wayland compositor with animations and modern features.

## Structure

```
hypr/
  .config/hypr/
    hyprland.conf     # Main compositor config
    hypridle.conf     # Idle management (screen timeout, suspend)
    hyprlock.conf     # Lock screen configuration
    hyprpaper.conf    # Wallpaper manager
```

## What It Does

Provides a complete Hyprland desktop environment with:
- **Window management** - Dynamic tiling, floating, fullscreen
- **Workspaces** - 10 workspaces with vim-style navigation
- **Idle management** - Auto-lock and suspend
- **Lock screen** - Custom styled lock screen with time/date
- **Wallpapers** - Multi-monitor wallpaper management

## Platform

**Linux only** - Wayland compositor for Linux.

## Main Configuration (`hyprland.conf`)

**Key settings:**
- Monitor: Auto-detect with preferred resolution
- Xwayland: Force zero scaling enabled
- Layout: Dwindle (default), Master available
- Animations: Disabled for performance
- Gaps: 8px inner and outer
- Border: 1px, subtle colors

**Modifier key:** `SUPER` (Windows/Command key)

## Key Bindings

### Applications
- `SUPER + Return` - Terminal (Alacritty)
- `SUPER + D` - App launcher (Rofi)
- `SUPER + E` - File manager (Nautilus)

### Window Management
- `SUPER + W` - Close window
- `SUPER + F` - Fullscreen
- `SUPER + Shift + T` - Toggle floating
- `SUPER + T` - Toggle split

### Navigation (Vim-style)
- `SUPER + H/J/K/L` - Move focus
- `SUPER + Shift + H/J/K/L` - Move window

### Workspaces
- `SUPER + 1-9/0` - Switch to workspace 1-10
- `SUPER + Shift + 1-9/0` - Move window to workspace
- `SUPER + S` - Toggle scratchpad
- `SUPER + Mouse Wheel` - Cycle workspaces

### System
- `SUPER + Shift + Q` - Lock screen (hyprlock)
- `SUPER + Shift + C` - Exit Hyprland
- `SUPER + Shift + R` - Reload config

### Media & Clipboard
- `XF86AudioRaiseVolume/Lower/Mute` - Volume control (swayosd)
- `XF86AudioPlay/Next/Prev` - Media controls (playerctl)
- `SUPER + V` - Clipboard manager (clipman + rofi)
- `SUPER + Shift + F` - Screenshot region (grim + slurp)

## Idle Management (`hypridle.conf`)

- **5 min** - Lock screen
- **5.5 min** - Turn off display (DPMS)
- **30 min** - Suspend system

## Lock Screen (`hyprlock.conf`)

Features:
- Wallpaper background
- Large clock (Helsinki timezone)
- Date display
- Password input field
- Nord-inspired colors

## Wallpapers (`hyprpaper.conf`)

Preloads 6 wallpapers, displays `wallpaper_04.jpg` by default.

## Autostart

Automatically launches:
- waybar (status bar)
- hyprpaper (wallpaper)
- mako (notifications)
- hypridle (idle management)
- polkit agent (authentication)
- Discord
- swayosd-server (volume/brightness OSD)
- clipman (clipboard manager)
- XDG desktop portal

## Customization

**Change wallpaper:**
Edit `hyprpaper.conf`, line 8:
```ini
wallpaper = ,~/.wallpapers/wallpaper_04.jpg
```

**Enable animations:**
Edit `hyprland.conf`, line 126:
```ini
animations {
    enabled = true
```

**Change gaps/borders:**
Edit `hyprland.conf`, `general` section.

**Adjust keyboard layouts:**
Line 164: `kb_layout = us, fi, hu`  
Switch with: `Ctrl + Space`

## Device-Specific

**Mouse sensitivity** configured for "MX Anywhere 2S" (line 188).  
Adjust or add your device with `hyprctl devices`.

## Installation

The installer automatically:
1. Installs Hyprland via package manager
2. Stows the configuration
3. Sets up all components

**First launch:**
```bash
# From TTY or display manager
Hyprland
```

## Notes

- Requires Wayland-capable GPU drivers
- Works best with AMD/Intel GPUs
- NVIDIA requires additional setup
- Animations disabled for better performance/battery
- Uses Nord-inspired color scheme throughout
