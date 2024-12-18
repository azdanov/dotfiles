function theme_dark
    yes | fish_config theme save "Catppuccin Macchiato"
    sed -i s/latte/macchiato/g ~/.config/alacritty/alacritty.toml
    sed -i s/latte/macchiato/g ~/.config/btop/btop.conf
    sed -i s/catppuccin-latte/catppuccin-macchiato/g ~/.config/nvim/lua/plugins/theme.lua
    sed -i s/latte/macchiato/g ~/.config/tmux/tmux.conf
    sed -i s/latte/macchiato/g ~/.config/zellij/config.kdl
    sed -i s/latte/macchiato/g ~/.config/fish/config.fish
    sed -i s/\.profile/\ Dark\.profile/g ~/.config/konsolerc
    kitty +kitten themes --reload-in=all Catppuccin-Macchiato
    # plasma-apply-lookandfeel --apply com.endeavouros.breezedarkeos.desktop
    # plasma-apply-colorscheme BreezeDark
    # plasma-apply-desktoptheme breeze-dark
    plasma-apply-cursortheme breeze_cursors
    # systemctl --user restart plasma-plasmashell
end
