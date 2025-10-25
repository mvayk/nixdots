#!/usr/bin/env bash

dir="$HOME/.config/rofi/powermenu"
uptime=$(uptime -p | sed -e 's/up //g')
rofi_command="rofi -theme $dir/powermenu.rasi"

# Options
shutdown="󰐥"
reboot="󰜉"
lock="󰌾"
suspend="󰤄"
logout="󰍃"

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2 -me-select-entry '' -me-accept-entry MousePrimary)"

case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        hyprlock
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        hyprctl dispatch exit
        ;;
esac
