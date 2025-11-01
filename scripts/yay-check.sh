#!/bin/bash
updates=$(yay -Qu)
if [ -n "$updates" ]; then
    notify-send "🔔 Mises à jour AUR disponibles" "$updates"
fi
