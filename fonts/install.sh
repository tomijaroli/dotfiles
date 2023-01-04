#!/bin/bash

SUPPORTED_FONTS=(Hack Meslo) # To install more fonts, add the name of the font's folder into this array

for font in ${SUPPORTED_FONTS[@]}; do
    echo "Opening font $font..."
    open fonts/$font/*.ttf
done
