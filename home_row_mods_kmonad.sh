#!/bin/bash

[[ -d /dev/input/by-id ]] && my_keyboard=$(find /dev/input/by-id -print | grep -E '(kbd|usb-Logitech_USB_Receiver-if02-event-mouse)')
[[ -z "$my_keyboard" ]] && my_keyboard=$(find /dev/input/by-path -name '*kbd*' -print)

for keyboard in $my_keyboard; do
    export KEYBOARD=$keyboard
    echo "Enabling home row mods for keyboard $keyboard"
    kmonad <(envsubst < "$HOME/.config/home_row_mods_kmonad/home_row_mods.kbd")
done
