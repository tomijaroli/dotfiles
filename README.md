# Dotfiles

This is a simple and minimalistic dotfile setup inspired by [Chris@Machine](https://github.com/ChristianChiarulli/Machfiles)'s setup.

## Preview

![Screenshot 2022-11-26 at 17 59 23](https://user-images.githubusercontent.com/3617451/204097683-cd667925-a3f5-4dda-a18b-6aaa4f1477c6.jpg)

## Installation

```
sh <(curl -sL https://raw.githubusercontent.com/tomijaroli/dotfiles/main/install.sh)
```

## Known issues

- After installing `nix package manager`, the shell needs to be reloaded - you will need to re-run the script afterwards.
- When using `stow */` in the stow folder, it does not take ignore file into account and it also symlinks the git folder's content into the user directory.
