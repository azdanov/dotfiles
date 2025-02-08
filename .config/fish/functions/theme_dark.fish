function theme_dark
    yes | fish_config theme save tokyonight_moon

    sed -i s/adwaita/tokyo-night/g ~/.config/btop/btop.conf
    sed -i s/tokyonight-day/tokyonight-moon/g ~/.config/nvim/lua/plugins/theme.lua
    sed -i s/tokyonight_day/tokyonight_moon/g ~/.config/fish/config.fish
    sed -i s/\.profile/\ Dark\.profile/g ~/.config/konsolerc

    set -Ux LS_COLORS (vivid generate tokyonight-moon)
    set -Ux FZF_DEFAULT_OPTS "--highlight-line --info=inline-right --ansi --layout=reverse --border=none --color=bg+:#2d3f76 --color=bg:#1e2030 --color=border:#589ed7 --color=fg:#c8d3f5 --color=gutter:#1e2030 --color=header:#ff966c --color=hl+:#65bcff --color=hl:#65bcff --color=info:#545c7e --color=marker:#ff007c --color=pointer:#ff007c --color=prompt:#65bcff --color=query:#c8d3f5:regular --color=scrollbar:#589ed7 --color=separator:#ff966c --color=spinner:#ff007c"
    set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/tokyonight_moon.yml"
    set -Ux BAT_THEME tokyonight_moon

    kitty +kitten themes --reload-in=all 'Tokyo Night Moon'
    plasma-apply-cursortheme breeze_cursors &>/dev/null
    # plasma-apply-lookandfeel --apply com.endeavouros.breezedarkeos.desktop
    # plasma-apply-colorscheme BreezeDark
    # plasma-apply-desktoptheme breeze-dark
    # systemctl --user restart plasma-plasmashell
end
