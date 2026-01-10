# Dircolors Configuration

Color scheme for `ls`, `eza`, and other directory listing tools.

## Structure

```
dircolors/
  .dircolors    # Nord-inspired color scheme
```

## What It Does

Defines colors for:
- File types (directories, executables, archives, images, etc.)
- Permissions and special files
- File extensions

## Platform Compatibility

The `.dircolors` file itself is **cross-platform** and works identically on macOS and Linux.

**Loading differences handled in shell configs:**
- **macOS**: Uses `gdircolors` (GNU coreutils)
- **Linux**: Uses `dircolors` (native)

The bash/zsh configs automatically detect and use the correct command.

## Installation

The installer automatically stows the dircolors directory. Shell configs load it on startup.

## Customization

Edit `.dircolors` to change colors. Format:
```bash
FILE_TYPE COLOR_CODE
```

**Example color codes:**
- `00` - Default
- `01` - Bold
- `34` - Blue
- `01;34` - Bold blue

**File type keywords:**
- `DIR` - Directories
- `EXEC` - Executables
- `LINK` - Symbolic links
- `*.ext` - File extensions

## Testing Colors

```bash
# Reload dircolors
eval "$(dircolors ~/.dircolors)"  # Linux
eval "$(gdircolors ~/.dircolors)" # macOS

# Test with ls or eza
ls --color=auto
eza --color=always
```

## Notes

- Uses Nord color palette for consistency
- Automatically applied via `$LS_COLORS` environment variable
- Works with `ls`, `eza`, and most terminal file browsers
- Requires GNU coreutils on macOS (installed via Homebrew)
