# Zsh Configuration

Cross-platform Zsh shell configuration supporting both macOS and Linux. Lightweight setup using Zap plugin manager (no oh-my-zsh dependency).

## Structure

```
zsh/
  .zshrc                         # Main Zsh config (OS detection, plugin loading)
  .zprofile                      # Zsh profile (login shell setup)
  .config/zsh/
    aliases.common.zsh           # Shared aliases
    aliases.macos.zsh            # macOS-specific aliases
    aliases.linux.zsh            # Linux-specific aliases
    exports.common.zsh           # Shared environment variables
    exports.macos.zsh            # macOS-specific environment variables
    exports.linux.zsh            # Linux-specific environment variables
    prompt.zsh                   # Prompt configuration (if not using Starship)
    .secrets.zsh                 # (Optional) Local secrets, gitignored
```

## How It Works

1.  **OS Detection**: Both `.zshrc` and `.zprofile` detect the operating system (`$OSTYPE`).
2.  **Conditional Sourcing**: Based on the detected OS, the scripts source the appropriate platform-specific `exports` and `aliases` files, in addition to the common ones.
3.  **Plugin Management**: Uses **Zap** plugin manager for lightweight plugin loading.
4.  **XDG Base Directory**: Adheres to the XDG Base Directory Specification for config, cache, and data paths.

## Key Features

-   **Shared Settings**: Common aliases, environment variables, and shell options are defined once.
-   **Platform-Specific Overrides**:
    -   **macOS**: Homebrew paths, NVM paths (Homebrew version), Android SDK path, Maestro, OrbStack, Secretive SSH agent, `open` command for Google search, iOS development aliases.
    -   **Linux**: NVM paths (`~/.nvm` version), Android SDK path, `xdg-open` for Google search.
-   **Tool Integration**: `bat` for colored `cat`, `eza` for `ls` (with `ls` fallback), `zoxide` for directory jumping, `lazygit` integration.
-   **Starship**: Integrated for a modern, customizable prompt.
-   **Zap Plugins**: 
    -   `zsh-autosuggestions` - Fish-like autosuggestions
    -   `zsh-autopair` - Auto-close brackets and quotes
    -   `supercharge` - Enhanced features
    -   `fzf` - Fuzzy finder integration
    -   `zsh-syntax-highlighting` - Syntax highlighting
-   **Dock Plugin** (macOS only): Custom dock profile manager plugin loaded conditionally.

## Customization

-   **Shared settings**: Edit `aliases.common.zsh` and `exports.common.zsh`.
-   **macOS-specific**: Edit `aliases.macos.zsh` and `exports.macos.zsh`.
-   **Linux-specific**: Edit `aliases.linux.zsh` and `exports.linux.zsh`.
-   **Secrets**: Create a `.secrets.zsh` file (it's gitignored) for sensitive environment variables.
-   **Prompt**: Customize `prompt.zsh` or use Starship (configured in `starship.toml`).
-   **Plugins**: Add more plugins by adding `plug "<owner>/<repo>"` in `.zshrc`.

## Installing Plugins

Zap automatically handles plugin installation. To add a new plugin:

1. Edit `.zshrc`
2. Add a new `plug` line in the plugins section:
   ```zsh
   plug "owner/repository-name"
   ```
3. Restart your shell or run `source ~/.zshrc`

## Usage

After installation, your Zsh environment will automatically load the correct configurations based on your operating system.

## Secrets

If you need to store credentials or sensitive environment variables (e.g., API tokens, passwords), create a `.secrets.zsh` file in `.config/zsh/`:

```zsh
# Example: .config/zsh/.secrets.zsh
export MY_API_TOKEN="your-token-here"
export DATABASE_PASSWORD="your-password"
```

This file is gitignored and will be automatically sourced if it exists.

## Cross-Platform Compatibility

This Zsh configuration is **fully cross-platform compatible**. It works identically on:
- macOS
- Linux
- WSL (Windows Subsystem for Linux)

Platform-specific settings (paths, tools, aliases) are automatically applied based on OS detection.
