function theme_light
    yes | fish_config theme save "Catppuccin Latte"
    sed -i s/macchiato/latte/g ~/.config/alacritty/alacritty.toml
    sed -i s/macchiato/latte/g ~/.config/btop/btop.conf
    sed -i s/catppuccin-macchiato/catppuccin-latte/g ~/.config/nvim/lua/plugins/theme.lua
    sed -i s/macchiato/latte/g ~/.config/tmux/tmux.conf
    sed -i s/macchiato/latte/g ~/.config/zellij/config.kdl
    sed -i s/macchiato/latte/g ~/.config/fish/config.fish
    sed -i s/\ Dark\.profile/\.profile/g ~/.config/konsolerc
    kitty +kitten themes --reload-in=all Catppuccin-Latte
    # plasma-apply-lookandfeel --apply org.kde.breeze.desktop
    # plasma-apply-colorscheme BreezeLight
    # plasma-apply-desktoptheme breeze-light
    plasma-apply-cursortheme Breeze_Light
    # systemctl --user restart plasma-plasmashell
end
