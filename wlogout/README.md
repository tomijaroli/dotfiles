# Wlogout Configuration

This directory contains the configuration for **wlogout**, a Wayland-based logout menu that provides a graphical interface for system power actions (lock, logout, suspend, hibernate, reboot, shutdown).

## Structure

```
wlogout/
  .config/wlogout/
    layout        # Button layout and actions
    style.css     # Visual styling
    icons/        # Button icons
      lock.png
      logout.png
      suspend.png
      hibernate.png
      shutdown.png
      reboot.png
    noise.png     # Background texture (optional)
```

## How It Works

Wlogout displays a full-screen overlay with clickable buttons for various power actions. It's configured via a JSON layout file that defines the actions and keybindings, along with a CSS file for styling.

### Available Actions

Each action has a dedicated button with an icon and keybinding:

| Action      | Command                         | Keybind | Description           |
|:------------|:--------------------------------|:--------|:----------------------|
| **Lock**    | `hyprlock`                      | `l`     | Lock the screen       |
| **Hibernate** | `systemctl hibernate`         | `h`     | Hibernate system      |
| **Logout**  | `hyprctl dispatch exit`         | `e`     | Exit Hyprland session |
| **Shutdown** | `systemctl poweroff`           | `s`     | Power off system      |
| **Suspend** | `systemctl suspend`             | `u`     | Suspend to RAM        |
| **Reboot**  | `systemctl reboot`              | `r`     | Reboot system         |

### Styling

**Appearance:**
- **Background**: Semi-transparent dark overlay (`rgba(46, 52, 64, 0.8)`)
- **Buttons**: Transparent with icon backgrounds (25% size), centered
- **Font**: 14pt, white text
- **Hover Effect**: Light grey background (`rgba(76, 85, 106, 0.4)`)
- **Focus Effect**: Darker grey background (`#4c566a`)

**Icons:**
- Custom PNG icons for each action
- Located in `icons/` directory
- Displayed as background images on buttons

## Platform Notes

-   **Linux-Only**: Wlogout is a Wayland-native power menu for Linux systems.
-   **Stow Module**: This configuration is set up as a `stow` module and will only be symlinked on Linux systems by the `install.sh` script.
-   **Location**: Stowed to `~/.config/wlogout/`.

## Usage

Wlogout is typically invoked via a keybinding or from Waybar. In Hyprland, it's accessible through:
- **Waybar**: Click the power icon in the status bar
- **Command**: Run `wlogout` from a terminal

```bash
wlogout                           # Open power menu
wlogout -p layer-shell            # Use layer-shell protocol
```

Once open, you can:
- **Click** a button to execute the action
- **Press** the corresponding keybind (l, h, e, s, u, r)
- **Press Escape** or click outside to cancel

## Customization

-   **Actions**: Edit `layout` to add, remove, or modify actions and keybindings.
-   **Commands**: Change the `action` field to use different commands (e.g., `swaylock` instead of `hyprlock`).
-   **Styling**: Modify `style.css` to change colors, fonts, button sizes, and hover effects.
-   **Icons**: Replace PNG files in `icons/` with custom icons (ensure they match the button labels).
-   **Background**: Add or modify the background texture by editing the CSS or using `noise.png`.

## Dependencies

- **hyprlock**: For the lock screen action (or substitute with `swaylock`).
- **systemd**: For power management commands (hibernate, suspend, reboot, poweroff).
- **Hyprland**: For the logout action (`hyprctl dispatch exit`).

## Notes

- The `sleep` delays before actions give wlogout time to close gracefully before executing the system command.
- If hibernate doesn't work, ensure your system has a configured swap partition or swap file.
