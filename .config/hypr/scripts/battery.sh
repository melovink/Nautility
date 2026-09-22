batStatus=$(cat /sys/class/power_supply/BAT0/status)

if [[ $batStatus == "Discharging" ]]; then
  killall -9 qs 2>/dev/null
  waybar &

else
  killall -9 waybar 2>/dev/null
  qs -c pill &

fi

exit 0

disown
