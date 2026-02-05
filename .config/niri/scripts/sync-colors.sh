#!/bin/bash

JSON_FILE="$HOME/.config/noctalia/colors.json"
NIRI_COLORS="$HOME/.config/niri/colors.kdl"
KITTY_CACHE="$HOME/.cache/wal/colors-kitty.conf"

# Hardcoded Dark Background
BG="#1e231e"

sync_all() {
    if [ -f "$JSON_FILE" ]; then
        # 1. Get Dynamic Colors
        PRIMARY=$(jq -r '.mPrimary' "$JSON_FILE")
        FG=$(jq -r '.mOnSurface' "$JSON_FILE")
        SEC=$(jq -r '.mSecondary' "$JSON_FILE")

        # 2. Update Niri
        echo "layout { 
            focus-ring { 
                active-color \"$PRIMARY\"; 
            } 
        }" > "$NIRI_COLORS"
        niri msg action load-config-file

        # 3. Rewrite Kitty Config (Sanitized)
        cat <<EOF > "$KITTY_CACHE"
# FORCE CLEAN BACKGROUND
background            $BG
background_opacity    0.7
background_tint       0.0
background_image      none

# ACCENTS
foreground            $FG
cursor                $PRIMARY
selection_background  $PRIMARY
selection_foreground  $BG

# COLORS
color0  $BG
color8  $SEC
color1  $PRIMARY
color9  $PRIMARY
color2  $SEC
color10 $SEC
color3  $PRIMARY
color11 $PRIMARY
color4  $SEC
color12 $SEC
color5  $PRIMARY
color13 $PRIMARY
color6  $SEC
color14 $SEC
color7  $FG
color15 $FG
EOF

        # 4. Force Reload - The Nuclear Option
        # We use --configured to update the persistent state
        kitty @ set-colors -a --configured "$KITTY_CACHE" 2>/dev/null
        
        echo "Synced: $BG background with $PRIMARY accents"
    fi
}

# Run once
sync_all

# Watch directory for changes
while inotifywait -e close_write,create,moved_to "$(dirname "$JSON_FILE")"; do
    sync_all
done
