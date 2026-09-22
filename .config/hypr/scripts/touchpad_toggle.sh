TOUCHPAD="ftcs0038:00-2808:0101-touchpad"
STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

# If the status file doesn't exist, assume the touchpad is currently enabled
if [ ! -f "$STATUS_FILE" ]; then
    echo "true" > "$STATUS_FILE"
fi

CURRENT_STATE=$(cat "$STATUS_FILE")

if [ "$CURRENT_STATE" = "true" ]; then
    # Uses the new hl.device() Lua function directly
    hyprctl eval "hl.device({ name = '$TOUCHPAD', enabled = false })"
    echo "false" > "$STATUS_FILE"
    notify-send -u low -i input-touchpad "Touchpad" "Disabled"
else
    hyprctl eval "hl.device({ name = '$TOUCHPAD', enabled = true })"
    echo "true" > "$STATUS_FILE"
    notify-send -u low -i input-touchpad "Touchpad" "Enabled"
fi
