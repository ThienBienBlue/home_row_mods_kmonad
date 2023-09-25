#!/bin/bash

my_keyboard=$(find /dev/input/by-id -name '*kbd*' -print)
[[ -z "$my_keyboard" ]] && my_keyboard=$(find /dev/input/by-path -name '*kbd*' -print)

if [[ -n "$my_keyboard" ]]; then
    export KEYBOARD=$my_keyboard
    kmonad <(envsubst < "$HOME/.config/home_row_mods_kmonad/home_row_mods.kbd")
fi
