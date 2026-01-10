# Waybar Configuration

This directory contains the configuration for **Waybar**, a highly customizable status bar for Wayland compositors (Sway, Hyprland, etc.). It displays system information, workspaces, media controls, and more.

## Structure

```
waybar/
  .config/waybar/
    config      # Main Waybar configuration (modules, layout)
    style.css   # Styling and appearance
```

## How It Works

Waybar is configured via a JSON configuration file (`config`) that defines which modules to display and their behavior, along with a CSS file (`style.css`) for visual styling.

### Configuration Highlights

**Layout:**
- **Position**: Top of the screen
- **Height**: 30 pixels
- **Spacing**: 4 pixels between modules

**Modules Left:**
- `hyprland/workspaces` - Virtual desktop workspaces
- `hyprland/mode` - Current mode (if any)
- `hyprland/scratchpad` - Scratchpad indicator
- `custom/media` - Media player info (optional)

**Modules Center:**
- `hyprland/window` - Active window title

**Modules Right:**
- `mpd` - Music Player Daemon status
- `pulseaudio` - Volume and audio device
- `network` - Network connection and status
- `hyprland/language` - Keyboard layout indicator
- `clock` - Date and time
- `custom/exit` - Power menu (opens `wlogout`)
- `tray` - System tray icons

### Module Features

**Workspaces:**
- Shows all workspaces across all outputs
- Click to switch workspaces

**Clock:**
- **Format**: `Sat 10. Jan 14.45` (day, date, time)
- **Tooltip**: Full calendar view
- **Click Action**: Opens `gnome-calendar`

**Network:**
- **Wi-Fi**: Shows ESSID and signal strength
- **Ethernet**: Shows connected icon
- **Tooltip**: Gateway and interface info

**Audio (PulseAudio):**
- Volume icon with percentage
- Mute indicator
- **Click Action**: Opens `pavucontrol` (volume control)

**Power Menu:**
- Power icon that opens `wlogout`
- Provides logout, shutdown, reboot options

**MPD (Music Player Daemon):**
- Shows playing track, artist, album
- Playback controls and state icons

**System Tray:**
- Icon size: 21 pixels
- Displays system tray applications

### Styling

**Color Scheme:**
- **Background**: Semi-transparent dark grey (`rgba(43, 48, 59, 0.65)`)
- **Foreground**: White text
- **Font**: Noto Sans, FontAwesome, 14px
- **Hover Effects**: Subtle background change with white underline

**Transparency:**
- The bar has a slight transparency for a modern look
- Hidden state reduces opacity to 0.2

## Platform Notes

-   **Linux-Only**: Waybar is a status bar for Wayland compositors on Linux.
-   **Stow Module**: This configuration is set up as a `stow` module and will only be symlinked on Linux systems by the `install.sh` script.
-   **Location**: Stowed to `~/.config/waybar/`.

## Usage

Waybar is typically started automatically by your Wayland compositor. In Hyprland, it's launched via the autostart section:

```
exec-once = waybar
```

You can manually start/restart Waybar:
```bash
waybar                    # Start waybar
killall waybar && waybar  # Restart waybar
```

## Customization

-   **Modules**: Add, remove, or reorder modules in the `modules-left`, `modules-center`, and `modules-right` arrays in `config`.
-   **Styling**: Edit `style.css` to change colors, fonts, spacing, borders, and other visual properties.
-   **Icons**: Update the icon formats in `config` for different modules (e.g., `format-icons` in pulseaudio, network).
-   **Actions**: Modify `on-click` actions for modules to launch different applications.
-   **Height/Position**: Change `height` and `layer` properties in `config`.

## Dependencies

- **Font Awesome**: Icons require Font Awesome or Nerd Fonts for proper display.
- **pavucontrol**: For the volume control click action.
- **wlogout**: For the power menu click action.
- **gnome-calendar** (optional): For the clock click action.
- **mpd** (optional): If using the MPD module.
