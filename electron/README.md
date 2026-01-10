# Electron Configuration

Performance and rendering flags for Electron-based applications on Linux.

## Structure

```
electron/
  .config/
    electron-flags.conf    # Wayland and GPU acceleration flags
```

## What It Does

Optimizes Electron apps (VS Code, Discord, Slack, etc.) for:
- **Wayland** native rendering
- **Hardware acceleration** via Vulkan/ANGLE
- **Video decode** acceleration
- **Better performance** and battery life

## Platform

**Linux only** - Specifically for Wayland environments (Hyprland, Sway, etc.)

## Key Flags

- `--ozone-platform=wayland` - Native Wayland rendering
- `--enable-features=UseOzonePlatform,Vulkan` - GPU acceleration
- `--enable-accelerated-video-decode` - Hardware video decoding
- `--enable-gpu-rasterization` - GPU-accelerated rendering

## Installation

The installer automatically stows this on Linux systems. Electron apps will read the flags on startup.

## Affected Applications

- Visual Studio Code / Cursor
- Discord
- Slack
- Obsidian
- Any Chromium/Electron-based app

## Testing

```bash
# Launch an Electron app and check if flags are applied
code --verbose  # Look for "Ozone platform: wayland"
```

## Troubleshooting

**App crashes or visual glitches:**
Remove problematic flags from `electron-flags.conf` and restart the app.

**Not using Wayland:**
Check if app is running on Wayland:
```bash
xlsclients  # Should not list your Electron app
```

## Notes

- Not needed on macOS (uses native rendering)
- Requires Wayland compositor (Hyprland, Sway, etc.)
- Some flags may not work on older hardware/drivers
- Can significantly improve battery life on laptops
