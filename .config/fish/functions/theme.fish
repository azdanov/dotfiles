#!/usr/bin/env fish

function theme
    set -l THEME = light

    # For macOS
    if test (uname) = Darwin
        # Check if system is in dark mode
        set THEME (defaults read -g AppleInterfaceStyle 2>/dev/null)
        if test "$THEME" = Dark
            set THEME dark
        else
            set THEME light
        end
        # For Linux with GNOME
    else if type -q gsettings
        set THEME (gsettings get org.gnome.desktop.interface color-scheme)
        if string match -q "*dark*" "$THEME"
            set THEME dark
        else
            set THEME light
        end
        # For Linux with KDE Plasma
    else if type -q kreadconfig6
        set THEME (kreadconfig6 --group "General" --key "ColorScheme")
        if string match -q "*Dark*" "$THEME"
            set THEME dark
        else
            set THEME light
        end
    end

    # Switch between light and dark theme
    if test "$THEME" = light
        set -Ux OS_THEME light
    else
        set -Ux OS_THEME dark
    end
end
