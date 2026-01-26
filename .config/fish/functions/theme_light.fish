function theme_light
    sed -i s/adwaita-dark\.theme/adwaita\.theme/g ~/.config/btop/btop.conf
    sed -i s/kanagawa-paper-ink/kanagawa-paper-canvas/g ~/.config/nvim/lua/plugins/astroui.lua

    set -Ux LS_COLORS (vivid generate kanagawa-paper-canvas)
    set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
--color=bg:-1,bg+:#d8d8d2,fg:-1,fg+:#73787d,hl:#9e7e98,hl+:#c27672 \
--color=header:#b28d77,info:#809ba7,pointer:#516e7d \
--color=marker:#516e7d,prompt:#c27672,spinner:#7e8faf
"
    set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/kanagawa-paper-canvas.yml"
    set -Ux BAT_THEME gruvbox-light

    plasma-apply-cursortheme Breeze_Light &>/dev/null
end
