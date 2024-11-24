function theme_dark
    yes | fish_config theme save "Catppuccin Macchiato"
    sed -i s/latte/macchiato/g ~/.config/alacritty/alacritty.toml
    sed -i s/latte/macchiato/g ~/.config/btop/btop.conf
    sed -i s/latte/macchiato/g ~/.config/nvim/lua/plugins/astroui.lua
    sed -i s/latte/macchiato/g ~/.config/tmux/tmux.conf
    sed -i s/latte/macchiato/g ~/.config/zellij/config.kdl
    # plasma-apply-lookandfeel --apply com.endeavouros.breezedarkeos.desktop
    # plasma-apply-colorscheme BreezeDark
    # plasma-apply-desktoptheme breeze-dark
    plasma-apply-cursortheme breeze_cursors
    # systemctl --user restart plasma-plasmashell
end
