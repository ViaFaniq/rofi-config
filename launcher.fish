#!/usr/bin/env fish

if pgrep -x rofi > /dev/null
    pkill -x rofi
    exit 0
end

rofi -show drun &
wait