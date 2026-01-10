# Fastfetch Configuration

Fast system information display tool (modern neofetch alternative).

## Structure

```
fastfetch/
  .config/fastfetch/
    config.jsonc    # Display modules configuration
```

## What It Does

Displays system information in the terminal:
- OS, kernel, uptime
- Hardware (CPU, GPU, memory)
- Desktop environment and window manager
- Shell, terminal, fonts
- Package count
- Disk usage

## Platform

**Linux only** - System information tool for Linux distributions.

## Display Modules

Configured to show (in order):
1. Title (username@hostname)
2. OS, host, kernel
3. Uptime, packages, shell
4. Display, DE, WM, theme, icons, font
5. Terminal, CPU, GPU
6. Memory, swap, disk
7. Color palette

## Usage

```bash
fastfetch              # Run with default config
fastfetch --help       # Show all options
fastfetch --logo none  # No logo, just info
```

## Customization

Edit `config.jsonc` to:
- Add/remove modules
- Change module order
- Adjust formatting

**Available modules:** `fastfetch --list-modules`

**Example - remove a module:**
```jsonc
{
  "modules": [
    "title",
    "os",
    // "gpu",  // Commented out
    "memory"
  ]
}
```

## Installation

The installer automatically:
1. Installs fastfetch via package manager (Arch: yay)
2. Stows the configuration

## Notes

- Much faster than neofetch (written in C)
- Uses JSON configuration (with comments support)
- Can display custom logos and images
- Supports many Linux distributions out of the box
