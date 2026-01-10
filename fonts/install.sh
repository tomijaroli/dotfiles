#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
else
    OS_TYPE="unknown"
fi

SUPPORTED_FONTS=(Hack Meslo) # To install more fonts, add the name of the font's folder into this array

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$OS_TYPE" == "macos" ]]; then
    # macOS: Use 'open' command to trigger font installation
    echo "Installing fonts on macOS..."
    for font in ${SUPPORTED_FONTS[@]}; do
        echo "Opening font $font..."
        open "$SCRIPT_DIR/$font"/*.ttf
    done
    echo "✓ Fonts opened in Font Book. Please confirm installation."
    
elif [[ "$OS_TYPE" == "linux" ]]; then
    # Linux: Copy fonts to user fonts directory and update font cache
    echo "Installing fonts on Linux..."
    
    FONTS_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONTS_DIR"
    
    for font in ${SUPPORTED_FONTS[@]}; do
        echo "Installing font $font..."
        FONT_TARGET_DIR="$FONTS_DIR/$font"
        mkdir -p "$FONT_TARGET_DIR"
        
        # Copy all font files
        cp "$SCRIPT_DIR/$font"/*.ttf "$FONT_TARGET_DIR/" 2>/dev/null || {
            echo "⚠️  Warning: Could not copy some fonts from $font"
        }
        
        echo "✓ Copied $font fonts to $FONT_TARGET_DIR"
    done
    
    # Update font cache
    echo "Updating font cache..."
    if command -v fc-cache &> /dev/null; then
        fc-cache -fv "$FONTS_DIR" > /dev/null 2>&1
        echo "✓ Font cache updated"
    else
        echo "⚠️  Warning: fc-cache not found. Fonts may not be available immediately."
        echo "   Install fontconfig package: sudo apt install fontconfig (Ubuntu/Debian)"
    fi
    
    echo "✓ Fonts installed successfully!"
    
else
    echo "❌ Unsupported operating system: $OSTYPE"
    exit 1
fi
