function theme --on-variable fish_terminal_color_theme
    set -l theme
    set -l btop_old
    set -l btop_new
    set -l nvim_old
    set -l nvim_new
    set -l bat
    set -l cursor
    set -l fzf_opts

    switch "$fish_terminal_color_theme"
        case light
            set theme kanagawa-paper-canvas
            set btop_old "adwaita-dark.theme"
            set btop_new "adwaita.theme"
            set nvim_old kanagawa-paper-ink
            set nvim_new kanagawa-paper-canvas
            set bat gruvbox-light
            set cursor Breeze_Light
            set fzf_opts " \
--color=bg:-1,bg+:#d8d8d2,fg:-1,fg+:#73787d,hl:#9e7e98,hl+:#c27672 \
--color=header:#b28d77,info:#809ba7,pointer:#516e7d \
--color=marker:#516e7d,prompt:#c27672,spinner:#7e8faf
"
        case dark
            set theme kanagawa-paper-ink
            set btop_old "adwaita.theme"
            set btop_new "adwaita-dark.theme"
            set nvim_old kanagawa-paper-canvas
            set nvim_new kanagawa-paper-ink
            set bat gruvbox-dark
            set cursor breeze_cursors
            set fzf_opts " \
--color=bg:-1,bg+:#2A2A37,fg:-1,fg+:#DCD7BA,hl:#938AA9,hl+:#c4746e \
--color=header:#b6927b,info:#658594,pointer:#7AA89F \
--color=marker:#7AA89F,prompt:#c4746e,spinner:#8ea49e
"
        case '*'
            return
    end

    set -gx LS_COLORS (vivid generate $theme)
    set -gx FZF_DEFAULT_OPTS "$fzf_opts"
    set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/$theme.yml"
    set -gx BAT_THEME $bat

    rg -q "$btop_old" ~/.config/btop/btop.conf; and sed -i "s/$btop_old/$btop_new/g" ~/.config/btop/btop.conf
    rg -q "$nvim_old" ~/.config/nvim/lua/plugins/astroui.lua; and sed -i "s/$nvim_old/$nvim_new/g" ~/.config/nvim/lua/plugins/astroui.lua

    set -l current_cursor (kreadconfig6 --file kcminputrc --group Mouse --key cursorTheme)
    if test "$current_cursor" != "$cursor"
        plasma-apply-cursortheme "$cursor" &>/dev/null
    end
end
