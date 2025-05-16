function theme_dark
    yes | fish_config theme save "Catppuccin Macchiato"

    sed -i s/latte/macchiato/g ~/.config/btop/btop.conf
    sed -i s/latte/macchiato/g ~/.config/nvim/lua/plugins/astroui.lua
    sed -i s/latte/macchiato/g ~/.config/fish/config.fish

    set -Ux LS_COLORS (vivid generate catppuccin-macchiato)
    set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#313244,label:#CDD6F4"
    set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/catppuccin_macchiato.yml"
    set -Ux BAT_THEME "Catppuccin Macchiato"

    kitty +kitten themes --reload-in=all Catppuccin-Macchiato
    plasma-apply-cursortheme breeze_cursors &>/dev/null
    # plasma-apply-lookandfeel --apply com.endeavouros.breezedarkeos.desktop
    # plasma-apply-colorscheme BreezeDark
    # plasma-apply-desktoptheme breeze-dark
    # systemctl --user restart plasma-plasmashell
end
