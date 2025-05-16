function theme_light
    yes | fish_config theme save "Catppuccin Latte"

    sed -i s/macchiato/latte/g ~/.config/btop/btop.conf
    sed -i s/macchiato/latte/g ~/.config/nvim/lua/plugins/astroui.lua
    sed -i s/macchiato/latte/g ~/.config/fish/config.fish

    set -Ux LS_COLORS (vivid generate catppuccin-latte)
    set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
    --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
    --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
    --color=selected-bg:#BCC0CC \
    --color=border:#CCD0DA,label:#4C4F69"
    set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/catppuccin_latte.yml"
    set -Ux BAT_THEME "Catppuccin Latte"

    kitty +kitten themes --reload-in=all Catppuccin-Latte
    plasma-apply-cursortheme Breeze_Light &>/dev/null
    # plasma-apply-lookandfeel --apply org.kde.breeze.desktop
    # plasma-apply-colorscheme BreezeLight
    # plasma-apply-desktoptheme breeze-light
    # systemctl --user restart plasma-plasmashell
end
