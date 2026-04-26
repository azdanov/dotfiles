#!/bin/sh

niri msg action do-screen-transition

darkMode=$(qs -c noctalia-shell ipc call state all | jq -r '.settings.colorSchemes.darkMode')
gtk_settings="$HOME/.config/gtk-4.0/settings.ini"

if [ "$darkMode" = "true" ]; then
  prefer_dark=1
else
  prefer_dark=0
fi

mkdir -p "$(dirname "$gtk_settings")"
if [ ! -f "$gtk_settings" ]; then
  printf "[Settings]\n" >"$gtk_settings"
fi

if grep -q '^gtk-application-prefer-dark-theme=' "$gtk_settings"; then
  sed -i "s/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=$prefer_dark/" "$gtk_settings"
else
  printf "gtk-application-prefer-dark-theme=%s\n" "$prefer_dark" >>"$gtk_settings"
fi
