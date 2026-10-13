#!/usr/bin/env fish

if pgrep -f "rofi.*Clipboard" > /dev/null
    pkill -f "rofi.*Clipboard"
    exit 0
end

set clear_opt "󰩹 Clear History"

set chosen (begin
    echo "$clear_opt"
    cliphist list
end | rofi -dmenu -i -p "Clipboard" -theme ~/.config/rofi/clipboard.rasi)

if test -n "$chosen"
    if string match -q "$clear_opt" "$chosen"
        set confirm (begin
            echo "No"
            echo "Yes"
        end | rofi -dmenu -i -p "Clear all history?" -theme ~/.config/rofi/power-menu.rasi)
        
        if test "$confirm" = "Yes"
            cliphist wipe
            wl-copy -c
            rm -rf ~/.cache/cliphist
        end
    else
        echo "$chosen" | cliphist decode | wl-copy
    end
end