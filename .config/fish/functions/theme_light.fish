function theme_light
    yes | fish_config theme save "Catppuccin Latte"
    sed -i s/macchiato/latte/g ~/.config/alacritty/alacritty.toml
    sed -i s/macchiato/latte/g ~/.config/btop/btop.conf
    sed -i s/macchiato/latte/g ~/.config/nvim/lua/plugins/astroui.lua
    sed -i s/macchiato/latte/g ~/.config/tmux/tmux.conf
    sed -i s/macchiato/latte/g ~/.config/zellij/config.kdl
    # plasma-apply-lookandfeel --apply org.kde.breeze.desktop
    # plasma-apply-colorscheme BreezeLight >/dev/null
    # plasma-apply-desktoptheme breeze-light
    plasma-apply-cursortheme Breeze_Light >/dev/null
    # systemctl --user restart plasma-plasmashell
end
