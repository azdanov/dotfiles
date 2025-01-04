function theme_light
    yes | fish_config theme save astrolight
    sed -i s/tokyo-night/adwaita/g ~/.config/btop/btop.conf
    sed -i s/dark/light/g ~/.config/nvim/lua/plugins/astroui.lua
    sed -i s/dark/light/g ~/.config/fish/config.fish
    sed -i s/\ Dark\.profile/\.profile/g ~/.config/konsolerc
    plasma-apply-cursortheme Breeze_Light
end
