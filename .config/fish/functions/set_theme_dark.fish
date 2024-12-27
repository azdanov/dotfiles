function set_theme_dark
    yes | fish_config theme save "Catppuccin Macchiato"
    sed -i s/latte/macchiato/g ~/.config/alacritty/alacritty.toml
    sed -i s/latte/macchiato/g ~/.config/nvim/lua/plugins/astroui.lua
end
