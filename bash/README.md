# Bash Configuration

Cross-platform Bash configuration with modular platform-specific overrides.

## Structure

```
bash/
  .bashrc                              # Main config with OS detection
  .bash_profile                        # Profile with platform init
  .config/bash/
    exports.common.bash                # Shared environment variables
    exports.macos.bash                 # macOS-specific exports
    exports.linux.bash                 # Linux-specific exports
    aliases.common.bash                # Shared aliases
    aliases.macos.bash                 # macOS-specific aliases
    aliases.linux.bash                 # Linux-specific aliases
    prompt.bash                        # Git-aware prompt
    git-prompt.sh                      # Git prompt helper
```

## Platform Differences

| Category | macOS | Linux |
|----------|-------|-------|
| Browser | Safari | Firefox |
| Homebrew | `/opt/homebrew` | N/A |
| NVM | Homebrew path | `~/.nvm` |
| Android SDK | `/Users/$USER/Library/Android` | `~/Android/Sdk` |
| Extras | Xcode tools, OrbStack, Mint | Standard paths |

## Key Features

**Common (`exports.common.bash` & `aliases.common.bash`):**
- Python (pyenv), Ruby (rbenv), Go, Zoxide
- Git aliases, tmux shortcuts, eza/ls
- Vi mode, custom prompt

**macOS-only (`aliases.macos.bash`):**
- iOS development: `xkill`, `xopen`, `xrl`, `deeplink`
- Uses `open` command

**Linux-only (`aliases.linux.bash`):**
- Uses `xdg-open` command

## Installation

The installer automatically:
1. Backs up existing `.bashrc` and `.bash_profile`
2. Stows the bash directory
3. Bash automatically detects OS and sources correct files

## Customization

**Add environment variables:**
- Common: edit `.config/bash/exports.common.bash`
- Platform-specific: edit `.config/bash/exports.{macos|linux}.bash`

**Add aliases:**
- Common: edit `.config/bash/aliases.common.bash`
- Platform-specific: edit `.config/bash/aliases.{macos|linux}.bash`

**Secrets:**
Create `.config/bash/.secrets.bash` (gitignored) for private variables.

## Key Aliases

**Navigation:**
- `j <path>` - Jump to directory (zoxide)
- `f` - Interactive directory finder

**Git:**
- `gf` - Fetch with prune
- `co` - Checkout
- `gc <msg>` - Commit
- `gp` - Push
- `gl` - Pretty log
- `lg` - LazyGit

**Tmux:**
- `tn <name>` - New session
- `ta <name>` - Attach
- `tls` - List sessions

## Reload Configuration

```bash
source ~/.bashrc
# or
bl  # alias for reload
```

## Notes

- Uses Git-aware prompt with branch and status info
- Automatically checks for `bat`, `eza`, `zoxide` and uses them if available
- Falls back to standard commands if modern tools aren't installed
- Vi mode enabled by default
