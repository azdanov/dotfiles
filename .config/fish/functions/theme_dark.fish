function theme_dark
    sed -i s/adwaita\.theme/adwaita-dark\.theme/g ~/.config/btop/btop.conf
    sed -i s/kanagawa-paper-canvas/kanagawa-paper-ink/g ~/.config/nvim/lua/plugins/astroui.lua

    set -Ux LS_COLORS (vivid generate kanagawa-paper-ink)
    set -Ux FZF_DEFAULT_OPTS " \
--color=bg:-1,bg+:#2A2A37,fg:-1,fg+:#DCD7BA,hl:#938AA9,hl+:#c4746e \
--color=header:#b6927b,info:#658594,pointer:#7AA89F \
--color=marker:#7AA89F,prompt:#c4746e,spinner:#8ea49e
"
    set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/kanagawa-paper-ink.yml"
    set -Ux BAT_THEME gruvbox-dark

    plasma-apply-cursortheme breeze_cursors &>/dev/null
end
