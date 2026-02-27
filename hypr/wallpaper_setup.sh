#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Combine directory and filename
WALLPAPER="$WALLPAPER_DIR$1"

# Check if argument was provided
if [ -z "$1" ]; then
    echo "Error: No wallpaper specified"
    echo "Usage: $0 wallpaper.jpg"
    exit 1
fi

# Check if file exists
if [ ! -f "$WALLPAPER" ]; then
    echo "Error: Wallpaper file '$WALLPAPER' not found"
    exit 1
fi

# Create hyprpaper config with blank monitor (applies to all)
cat > "$HYPRPAPER_CONF" << EOF
preload = $WALLPAPER

wallpaper {
    monitor = 
    path = $WALLPAPER
    fit_mode = fill
}

splash = false
EOF

echo "Updated hyprpaper with: $1"

# Generate pywal colors
wal -i "$WALLPAPER" --saturate 0.8

# Reload hyprpaper

pkill hyprpaper
hyprpaper &

echo "✓ Wallpaper and colors updated successfully!"
