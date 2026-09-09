# xim (iOS Neovim)

Second Neovim app on top of [`nvim`](../../../nvim/.config/nvim/README.md). Launch with `xim` (`NVIM_APPNAME=xim nvim`).

macOS-only (stowed via `MACOS_STOW_PACKAGES`). Uses `~/.config/xim` and `~/.local/share/xim` so plugins are cloned separately from default `nvim`.

## What it adds

- `sourcekit-lsp` via `xcrun` (`lsp/sourcekit.lua`)
- Swift treesitter, swiftformat, swiftlint
- [xcodebuild.nvim](https://github.com/wojciech-kulik/xcodebuild.nvim)
- nvim-dap + nvim-dap-ui (Xcode 16+ `lldb-dap`)

## Extra tools (Brewfile)

`swiftformat`, `swiftlint`, `xcode-build-server`, `xcbeautify`, `xcp`, `pymobiledevice3`. sourcekit-lsp comes from Xcode.

## Maps

`<leader>X` xcodebuild picker, `<leader>x*` build/test/run/device, `<leader>dd` build & debug, `<leader>b` breakpoint. Same general editor maps as `nvim`.
