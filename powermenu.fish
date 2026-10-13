#!/usr/bin/env fish

# Sprawdź, czy rofi z tym motywem jest już uruchomione
if pgrep -x rofi > /dev/null
    # Jeśli działa, zamknij je (zabij proces)
    pkill -x rofi
    exit 0
end

set shutdown "  Shutdown"
set reboot   "  Reboot"
set lock     "  Lock"
set suspend  "󰤄  Suspend"
set logout   "󰍃  Logout"

set options "$shutdown\n$reboot\n$lock\n$suspend\n$logout"

set chosen (echo -e $options | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/power-menu.rasi)

switch $chosen
    case $shutdown
        systemctl poweroff
    case $reboot
        systemctl reboot
    case $lock
        loginctl lock-session
    case $suspend
        systemctl suspend
    case $logout
        pkill -x mangowm || pkill -x niri || mmsg dispatch quit
end