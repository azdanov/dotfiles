#!/bin/bash

# This script is used by Koi on KDE to change the theme automatically

sleep 1

dbus-update-activation-environment --systemd --all

fish -c "theme"
