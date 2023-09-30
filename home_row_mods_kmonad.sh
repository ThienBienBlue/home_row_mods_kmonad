#!/bin/bash

[[ -d /dev/input/by-id ]] && keyboards="$(find /dev/input/by-id -print | grep -E '(kbd|usb-Logitech_USB_Receiver-if02-event-mouse)') "
keyboards+=$(find /dev/input/by-path -name '*kbd*' -print)

if [[ -n "$keyboards" ]]; then
    readarray -t keyboards < <(echo "$keyboards")
    i=0

    echo "Please select one of the following keyboards to apply home row mods to:"
    echo
    for keyboard in $keyboards; do
        i=$((i + 1))
        echo "[$i] $keyboard"
    done

    echo
    read -p "Select one of [1-$i]: " selected_idx
    i=1
    for keyboard in $keyboards; do
        if [[ "$i" == "$selected_idx" ]]; then
            echo "Enabling home row mods for keyboard: $keyboard"
            export KEYBOARD=$keyboard
            kmonad <(envsubst < "$HOME/.config/home_row_mods_kmonad/home_row_mods.kbd")
            exit 0
        fi
        i=$((i+1))
    done

    echo "Unrecognized input \`$selected_idx'"
    exit 1
fi
