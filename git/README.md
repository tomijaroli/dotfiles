# Git Configuration

Global Git configuration and ignore patterns.

## Structure

```
git/
  .gitconfig          # Global Git settings
  .gitignore_global   # Global ignore patterns
```

## Configuration Highlights

**User:**
- Email: hi@tomijaroli.me
- Name: Tomi Jaroli

**Behavior:**
- Default branch: `main`
- Auto-setup remote on push
- Auto-squash on rebase
- Colorized output

**Git LFS:**
- Large File Storage enabled and configured

## Features

**Auto-squash rebase:**
```bash
git commit --fixup <sha>
git rebase -i --autosquash
```

**Auto-setup remote:**
Push to new branch without `--set-upstream`:
```bash
git push  # Automatically sets up tracking
```

## Global Ignore Patterns

Ignores iOS development artifacts:
- `buildServer.json`
- `app_logs.log`, `original_logs.log`
- `report.json`, `settings.json`
- `xcodebuild.log`
- `**/xcodebuild/*`

## Platform Compatibility

**Fully cross-platform** - Works identically on macOS and Linux.

**Note:** Credential helpers are NOT configured, allowing per-platform setup:
- macOS: Can use `osxkeychain`
- Linux: Can use `libsecret` or `cache`

## Customization

**Add personal info:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

**Add ignore patterns:**
Edit `.gitignore_global` to add more patterns.

**Set credential helper:**
```bash
# macOS
git config --global credential.helper osxkeychain

# Linux
git config --global credential.helper libsecret
```

## Installation

The installer automatically stows the git directory.

## Notes

- Configuration is platform-agnostic by design
- No credential helper configured (set up per-system)
- Git LFS required for repositories using large files
- Color output enabled for better readability
