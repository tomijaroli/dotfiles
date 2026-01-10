# Themes Configuration

This directory contains GTK themes for Linux desktop environments. These themes provide consistent visual styling for GTK-based applications, window managers, and UI elements.

## Structure

```
themes/
  .themes/
    Nordic/           # Nordic GTK theme
    Graphite/         # Graphite GTK theme (standard DPI)
    Graphite-Dark/    # Graphite dark variant
    Graphite-Light/   # Graphite light variant
    Graphite-hdpi/    # Graphite for high DPI displays
    Graphite-xhdpi/   # Graphite for extra high DPI displays
    (+ dark/light variants for high DPI)
```

## How It Works

GTK themes are installed to `~/.themes/` and can be selected via GTK settings, GNOME Tweaks, or your desktop environment's appearance settings. Each theme provides styling for GTK-3, GTK-4, window decorations (xfwm4), and other UI components.

### Included Themes

**Nordic:**
- A dark, Nordic-inspired theme with a blue/grey color palette
- Matches well with the Nord color scheme used in other configs (Alacritty, Rofi, etc.)
- Provides GTK-3, GTK-4, and xfwm4 window decoration support

**Graphite:**
- A modern, material-design inspired theme
- Available in multiple variants:
  - **Dark**: Dark background with light text
  - **Light**: Light background with dark text
  - **Standard/hdpi/xhdpi**: Different DPI variants for various screen resolutions

## Platform Notes

-   **Linux-Only**: GTK themes are used on Linux desktop environments (GNOME, XFCE, Cinnamon, MATE, etc.).
-   **Stow Module**: This configuration is set up as a `stow` module and will only be symlinked on Linux systems by the `install.sh` script.
-   **Location**: Stowed to `~/.themes/`.

## Usage

After installation, you can set your GTK theme using:

**GNOME/GTK:**
```bash
gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
gsettings set org.gnome.desktop.interface gtk-theme "Graphite-Dark"
```

**Via GUI:**
- GNOME: Use GNOME Tweaks → Appearance → Themes
- XFCE: Settings → Appearance → Style
- Other DEs: Look for "Themes" or "Appearance" in your system settings

**Environment Variable:**
```bash
export GTK_THEME=Nordic
```

## Customization

-   **Add Themes**: Download additional GTK themes and place them in the `.themes/` directory.
-   **Remove Themes**: Delete unwanted theme directories from `.themes/`.
-   **Variants**: Choose the appropriate DPI variant (standard, hdpi, xhdpi) based on your display resolution for optimal rendering.

## Notes

- These themes primarily affect GTK-based applications (e.g., GNOME apps, Firefox, LibreOffice).
- Qt applications may require separate Qt theme configuration.
- Window manager decorations (title bars, borders) are styled by the xfwm4 component in each theme.
