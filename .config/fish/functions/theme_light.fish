function theme_light
    yes | fish_config theme save tokyonight_day
    sed -i s/tokyo-night/adwaita/g ~/.config/btop/btop.conf
    sed -i s/moon/day/g ~/.config/nvim/lua/plugins/theme.lua
    sed -i s/moon/day/g ~/.config/fish/config.fish
    sed -i s/\ Dark\.profile/\.profile/g ~/.config/konsolerc
    set -Ux LS_COLORS (vivid generate tokyonight-day)
    plasma-apply-cursortheme Breeze_Light
    # kitty +kitten themes --reload-in=all "Tokyo Night Day"
    # plasma-apply-lookandfeel --apply org.kde.breeze.desktop
    # plasma-apply-colorscheme BreezeLight
    # plasma-apply-desktoptheme breeze-light
    # systemctl --user restart plasma-plasmashell
end
