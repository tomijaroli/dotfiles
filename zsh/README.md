# zsh config

Lightweight zsh config without using oh-my-zsh.

## Secrets

If you want to use credentials as environment variables for apps (e.g. xcode-install), create a `.secrets.zsh` file under `.config/zsh` folder, and the config will automatically load it.

## Installing plugins

You can install more plugins by adding the plugin's github repository name to the `.zshrc` plugin section

```
plug "<repository-owner>/<repository-name>"
```
