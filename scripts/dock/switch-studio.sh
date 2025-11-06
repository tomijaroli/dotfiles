#!/usr/bin/env bash
defaults import com.apple.dock "$HOME/.config/dock/profiles/dock-studio.plist"
killall Dock
