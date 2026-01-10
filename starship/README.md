# Starship Configuration

This directory contains the configuration for **Starship**, a fast, customizable, and cross-platform shell prompt written in Rust. It works with Bash, Zsh, Fish, and other shells.

## Structure

```
starship/
  .config/
    starship.toml    # Main Starship configuration
```

## How It Works

Starship is configured via a TOML file that defines the prompt format, modules to display, and their styling. The configuration is **cross-platform compatible**, working identically on macOS and Linux.

### Prompt Format

The prompt displays information in this order:
1. **Username** - Your current user (optional, shown when configured)
2. **Hostname** - Machine name (optional, typically SSH-only)
3. **Directory** - Current working directory (truncated to 1 level)
4. **Git Status** - Repository status indicators
5. **Git Branch** - Current branch name
6. **Character** - Prompt symbol (`%` in white, red on error)

### Configuration Highlights

**Character (Prompt Symbol):**
- Success: `%` in white
- Error: `%` in red

**Username:**
- Style: White bold
- Format: `[username]` in blue brackets
- Default: Only shown when needed (uncomment `show_always` to always display)

**Hostname:**
- Style: White bold
- Format: `[@hostname]` with red `@` symbol
- Default: SSH-only (uncomment `ssh_only = false` to always display)

**Directory:**
- Style: Cyan bold
- Icon: Green arrow `➜`
- Truncation: Shows only the current directory name (depth = 1)

**Git Status:**
- Color: Red status indicators
- Format: Status symbols wrapped in yellow/blue brackets

**Git Branch:**
- Style: Blue
- Format: Branch name in blue brackets

### Example Prompt

```
[user@hostname] ➜ dotfiles (main ✗)%
```

## Cross-Platform Compatibility

Starship is **fully cross-platform compatible**. The same `starship.toml` configuration works identically on:
- macOS
- Linux
- Windows (WSL)

No platform-specific adjustments are needed.

## Usage

Starship is initialized in your shell configuration:

**Bash:** `.bashrc` includes `eval "$(starship init bash)"`  
**Zsh:** `.zshrc` includes `eval "$(starship init zsh)"`

## Customization

- **Prompt Format**: Modify the `format` line to reorder or add/remove modules.
- **Colors**: Change the `style` values for each module (e.g., `"cyan bold"`, `"green"`, `"red bold"`).
- **Icons**: Update the symbols/icons in each module's `format` string.
- **Truncation**: Adjust `truncation_length` in the `[directory]` section.
- **Additional Modules**: Add more modules like `[time]`, `[battery]`, `[cmd_duration]`, etc.

For a full list of available modules and options, see the [Starship documentation](https://starship.rs/config/).
