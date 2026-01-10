# Greetd Configuration

Minimal and flexible login manager (display manager) for Linux.

## Structure

```
greetd/
  config.toml                   # Main greetd configuration
  sway-config                   # Sway config for greeter
  gtkgreet.css                  # GTK greeter styling
  environments                  # Available session list
  lock-screen-background.jpg    # Lock screen wallpaper
```

## What It Does

Provides a graphical login screen using:
- **greetd** - Login manager daemon
- **gtkgreet** - GTK-based greeter UI
- **Sway** - Wayland compositor for the greeter

## Platform

**Linux only** - Display manager for Linux systems.

## Configuration

**Main config** (`config.toml`):
- Runs on VT 1
- Launches Sway with gtkgreet
- Runs as `greeter` user

**Available sessions** (`environments`):
- sway
- bash

**Styling** (`gtkgreet.css`):
- Custom CSS for the login screen appearance

## Installation

**Manual setup required:**

1. Install greetd and gtkgreet:
```bash
# Arch
yay -S greetd gtkgreet

# Configure
sudo systemctl enable greetd
```

2. Copy greetd config:
```bash
sudo cp ~/dotfiles/greetd/config.toml /etc/greetd/config.toml
```

3. Link user configs:
```bash
mkdir -p ~/.config/greetd
ln -s ~/dotfiles/greetd/sway-config ~/.config/greetd/sway-config
ln -s ~/dotfiles/greetd/gtkgreet.css ~/.config/greetd/gtkgreet.css
```

## Customization

**Change wallpaper:**
Replace `lock-screen-background.jpg` with your image.

**Edit greeter appearance:**
Modify `gtkgreet.css` for custom styling.

**Add sessions:**
Add entries to `environments` file.

## Notes

- Greetd runs on VT 1 by default
- Uses user-level config paths (`$HOME/.config/greetd/`)
- Requires `greeter` user to exist
- More lightweight than GDM or SDDM
- Works with any Wayland compositor or X11
