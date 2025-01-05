function theme_dark
    yes | fish_config theme save astrodark
    sed -i s/adwaita/tokyo-night/g ~/.config/btop/btop.conf
    sed -i s/light/dark/g ~/.config/nvim/lua/plugins/astroui.lua
    sed -i s/light/dark/g ~/.config/fish/config.fish
    sed -i s/\.profile/\ Dark\.profile/g ~/.config/konsolerc
    set -Ux LS_COLORS (vivid generate one-dark)
    plasma-apply-cursortheme breeze_cursors
end
