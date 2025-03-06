#!/usr/bin/env bash

# Simple App Launcher
# Dependencies: rofi, jq, awk

# Configuration
ROFI_THEME="-theme-str 'window {width: 30%; border-radius: 10px;}' -theme-str 'element {padding: 10px;}' -theme-str 'element-icon {size: 32px;}'"
ROFI_OPTIONS="-show-icons -i -p 'Apps' -no-custom"

# Get all .desktop files
get_desktop_files() {
    find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null
}

# Parse .desktop files and extract name, icon, and exec command
parse_desktop_files() {
    local files=$(get_desktop_files)
    
    for file in $files; do
        # Skip hidden desktop entries
        if grep -q "NoDisplay=true" "$file" 2>/dev/null; then
            continue
        fi
        
        local name=$(grep "^Name=" "$file" | head -1 | cut -d= -f2)
        local icon=$(grep "^Icon=" "$file" | head -1 | cut -d= -f2)
        local exec=$(grep "^Exec=" "$file" | head -1 | cut -d= -f2- | sed 's/%[a-zA-Z]//g')
        
        if [[ -n "$name" && -n "$exec" ]]; then
            echo "$name|$icon|$exec"
        fi
    done
}

# Launch the application
launch_app() {
    local exec_command="$1"
    eval "$exec_command &" > /dev/null 2>&1
}

# Main
main() {
    local apps=$(parse_desktop_files | sort)
    
    if [ -z "$apps" ]; then
        echo "No applications found."
        exit 1
    fi
    
    local selection=$(echo "$apps" | awk -F'|' '{print $1 "\0icon\x1f" $2}' | \
        eval "rofi $ROFI_OPTIONS $ROFI_THEME -dmenu")
    
    if [ -n "$selection" ]; then
        local exec_command=$(echo "$apps" | grep "^$selection|" | awk -F'|' '{print $3}')
        if [ -n "$exec_command" ]; then
            launch_app "$exec_command"
        fi
    fi
}

main
