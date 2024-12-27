function change_background --argument mode_setting
    # https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
    # change background to the given mode. If mode is missing,
    # we try to deduct it from the system settings.

    set -l mode light # default value
    if test -z $mode_setting
        set -l val (defaults read -g AppleInterfaceStyle) >/dev/null
        if test $status -eq 0
            set mode dark
        end
    else
        switch $mode_setting
            case light
                osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
                set mode light
            case dark
                osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
                set mode dark
        end
    end

    # change fish theme
    switch $mode
        case dark
            yes | fish_config theme save "Catppuccin Macchiato"
        case light
            yes | fish_config theme save "Catppuccin Latte"
    end

    # change bat theme
    switch $mode
        case dark
            set -Ux BAT_THEME Catppuccin-macchiato
        case light
            set -Ux BAT_THEME Catppuccin-latte
    end

    # change LS_COLORS
    switch $mode
        case dark
            set -Ux LS_COLORS (vivid generate catppuccin-macchiato)
        case light
            set -Ux LS_COLORS (vivid generate catppuccin-latte)
    end

    # change tmux
    switch $mode
        case dark
            sed -i '' 's/fg=#bcc0cc/fg=#363a4f/g' ~/.tmux.conf
            sed -i '' 's/fg=#fe640b/fg=#f5a97f/g' ~/.tmux.conf
            sed -i '' 's/fg=#4c4f69,bg=#dce0e8/fg=#cad3f5,bg=#24273a/g' ~/.tmux.conf
            tmux source-file ~/.tmux.conf
        case light
            sed -i '' 's/fg=#363a4f/fg=#bcc0cc/g' ~/.tmux.conf
            sed -i '' 's/fg=#f5a97f/fg=#fe640b/g' ~/.tmux.conf
            sed -i '' 's/fg=#cad3f5,bg=#24273a/fg=#4c4f69,bg=#dce0e8/g' ~/.tmux.conf
            tmux source-file ~/.tmux.conf
    end

    # change nvim
    switch $mode
        case dark
            sed -i '' s/latte/macchiato/g ~/.config/nvim/lua/plugins/astroui.lua
        case light
            sed -i '' s/macchiato/latte/g ~/.config/nvim/lua/plugins/astroui.lua
    end

    # change delta
    switch $mode
        case dark
            sed -i '' s/latte/macchiato/g ~/.gitconfig
            sed -i '' 's/light = true/light = false/g' ~/.gitconfig
        case light
            sed -i '' s/macchiato/latte/g ~/.gitconfig
            sed -i '' 's/light = false/light = true/g' ~/.gitconfig
    end

    # change alacritty
    switch $mode
        case dark
            sed -i '' s/latte/macchiato/g ~/.config/alacritty/alacritty.toml
        case light
            sed -i '' s/macchiato/latte/g ~/.config/alacritty/alacritty.toml
    end
end
