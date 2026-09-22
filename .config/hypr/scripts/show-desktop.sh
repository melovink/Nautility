#!/usr/bin/env bash

# Count the number of windows on the currently active workspace
WINDOW_COUNT=$(hyprctl activeworkspace -j | jq '.windows')

if [ "$WINDOW_COUNT" -gt 0 ]; then
    # We are on a workspace with windows. Jump to an empty one.
    hyprctl dispatch '"workspace", "empty"'
else
    # We are already on an empty workspace. Toggle back!
    hyprctl dispatch '"workspace", "previous"'
fi
