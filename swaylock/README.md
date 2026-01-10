# Swaylock Configuration

This directory contains the configuration for **swaylock**, a screen locking utility for Wayland compositors. It provides a minimal, customizable lock screen with visual effects.

## Structure

```
swaylock/
  config    # Main swaylock configuration
```

## How It Works

Swaylock is configured via a simple configuration file that defines the lock screen's appearance, indicator style, colors, and effects. It's typically invoked by your compositor or idle manager.

### Configuration Highlights

**Background:**
- **Image**: `$HOME/.wallpapers/wallpaper_04.jpg`
- **Effects**: 
  - Blur: `20x6` (20-pixel radius, 6 passes)
  - Greyscale filter applied

**Clock:**
- **Time Format**: `%R` (24-hour format, e.g., 14:30)
- **Date Format**: `%a, %e of %B` (e.g., "Mon, 6 of January")

**Indicator (Authentication Feedback):**
- **Radius**: 200 pixels
- **Thickness**: 20 pixels
- **Caps Lock**: Indicator shown when Caps Lock is active
- **Position**: Centered on screen

**Color Scheme:**
- **Ring**: White (`ffffff`)
- **Inside (indicator fill)**: Transparent black (`00000033`)
- **Text**: White (`ffffff`)
- **Key Highlight**: Transparent black (`00000066`)
- **Backspace Highlight**: White (`ffffff`)
- **Separator**: Transparent (`00000000`)
- **Line**: Transparent, white when active

**Behavior:**
- **Empty Password**: Ignored (prevents accidental blank password attempts)
- **Caps Lock Text**: Disabled

## Platform Notes

-   **Linux-Only**: Swaylock is a Wayland-native screen locker for Linux systems.
-   **Stow Module**: This configuration is set up as a `stow` module and will only be symlinked on Linux systems by the `install.sh` script.
-   **Location**: Stowed to `~/.config/swaylock/config`.

## Usage

Swaylock is typically invoked automatically by your idle manager (e.g., `hypridle`, `swayidle`) or via a keybinding in your compositor configuration.

**Manual invocation:**
```bash
swaylock                     # Lock screen with config
swaylock -f                  # Lock screen (fork to background)
swaylock -c 000000           # Lock with solid black color (ignores config)
```

In Hyprland, it's bound to `$mainMod + L` (Super + L) via `loginctl lock-session`.

## Customization

-   **Wallpaper**: Change the `image` path to use a different background image.
-   **Effects**: Adjust `effect-blur` values or remove `effect-greyscale` for a colorful lock screen.
-   **Clock Format**: Modify `timestr` and `datestr` for different time/date formats (see `man strftime`).
-   **Colors**: Update the various color values (in RRGGBBAA hex format) to match your theme.
-   **Indicator Size**: Adjust `indicator-radius` and `indicator-thickness` for a larger/smaller authentication indicator.

## Dependencies

- **swaylock-effects**: This config uses effects like blur and greyscale, which require `swaylock-effects` (a fork of swaylock). Standard `swaylock` does not support these features.
