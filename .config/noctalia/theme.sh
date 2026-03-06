#!/bin/sh

niri msg action do-screen-transition

darkMode=$(qs -c noctalia-shell ipc call state all | jq '.settings.colorSchemes.darkMode')

if [ "$darkMode" = "true" ]; then
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
else
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
fi
