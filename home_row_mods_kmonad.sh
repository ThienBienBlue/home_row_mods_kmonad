#!/bin/bash

[[ -d /dev/input/by-id ]] && keyboards=$(find /dev/input/by-id -print | grep -E '(kbd|usb-Logitech_USB_Receiver-if02-event-mouse)')
[[ -z "$keyboards" ]] && keyboards=$(find /dev/input/by-path -name '*kbd*' -print)

echo "Found keyboards $keyboards"
for keyboard in $keyboards; do
    export KEYBOARD=$keyboard
    echo "Enabling home row mods for $keyboard"
    kmonad <(envsubst < "$HOME/.config/home_row_mods_kmonad/home_row_mods.kbd")
done
