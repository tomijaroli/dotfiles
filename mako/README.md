# Mako Configuration

Lightweight notification daemon for Wayland.

## Structure

```
mako/
  .config/mako/
    config    # Notification styling and behavior
```

## What It Does

Displays desktop notifications with customizable appearance and behavior.

## Platform

**Linux only** - Notification daemon for Wayland compositors.

## Configuration

**Appearance:**
- Background: `#2b3339CC` (semi-transparent Nord-inspired)
- Width: 300px, Height: 110px
- Border: 2px, 4px radius
- Font: Noto Sans 12
- Icons: Enabled, max 64px

**Behavior:**
- Sort: By time (newest first)
- Layer: Top
- Default timeout: 5 seconds
- Ignore timeout on hover

**Urgency levels:**
- Low: Gray border (`#cccccc`)
- Normal: Orange border (`#d08770`)
- High: Red border (`#bf616a`), no timeout

**Categories:**
- MPD: 5 second timeout, grouped by category

## Installation

The installer automatically:
1. Installs mako via package manager
2. Stows the configuration
3. Hyprland autostart launches mako

## Usage

Mako runs automatically with Hyprland. Control via `makoctl`:

```bash
makoctl dismiss        # Dismiss last notification
makoctl dismiss -a     # Dismiss all
makoctl invoke         # Invoke default action on last notification
makoctl reload         # Reload config
```

## Customization

Edit `config` to change:
- Colors, fonts, sizing
- Timeout behavior
- Urgency styling
- Position (currently top layer)

See `man 5 mako` for all options.

## Testing

```bash
# Send test notification
notify-send "Test" "This is a test notification"
notify-send -u critical "Critical" "High urgency test"
```

## Notes

- Automatically started by Hyprland
- Replaces dunst/notify-osd on Wayland
- Lightweight and fast
- Nord color scheme compatible
- Integrates with waybar and other status bars
