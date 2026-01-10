# Rofi Configuration

This directory contains the configuration for **Rofi**, a fast and flexible application launcher and window switcher for Linux (X11/Wayland). It's configured with a modern, minimal design using the OneDark color scheme.

## Structure

```
rofi/
  .config/rofi/
    config.rasi           # Main Rofi configuration
    shared/
      colors.rasi         # Color scheme imports
      fonts.rasi          # Font configuration
    colors/
      onedark.rasi        # OneDark color theme
```

## How It Works

Rofi uses the RASI (Rofi Advanced Style Information) configuration format. The main `config.rasi` imports shared styling modules for colors and fonts, making it easy to maintain and customize the appearance.

### Configuration Highlights

**Modes:**
- `drun` - Desktop application launcher
- `run` - Command runner
- `filebrowser` - File browser
- `window` - Window switcher

**Appearance:**
- **Window:** Centered, 35% width, rounded borders (10px), semi-transparent
- **Font:** Noto Sans Nerd Font 15pt
- **Theme:** OneDark-inspired color scheme with subtle transparency
- **Icons:** Enabled (24px size)
- **Listview:** 6 visible lines, scrollable, dynamic

**Color Scheme (OneDark):**
- Background: `#333333` (semi-transparent)
- Foreground: `#dedede`
- Selected: `#0860F2` (blue)
- Active: `#98C379` (green)
- Urgent: `#E06C75` (red)

## Platform Notes

-   **Linux-Only**: Rofi is primarily used on Linux systems (X11 and Wayland).
-   **Stow Module**: This configuration is set up as a `stow` module and will only be symlinked on Linux systems by the `install.sh` script.

## Usage

Rofi is typically launched via keybindings set in your window manager or compositor. In Hyprland, it's bound to `$mainMod + D` (Super + D) to open the application launcher.

```bash
rofi -show drun          # Application launcher
rofi -show run           # Command runner
rofi -show window        # Window switcher
rofi -show filebrowser   # File browser
```

## Customization

-   **Colors**: Edit `colors/onedark.rasi` or create a new color scheme file and update the import in `shared/colors.rasi`.
-   **Font**: Modify `shared/fonts.rasi` to change the font family or size.
-   **Layout**: Adjust window dimensions, border radius, padding, and spacing in `config.rasi`.
-   **Modes**: Add or remove modes in the `configuration` section of `config.rasi`.
