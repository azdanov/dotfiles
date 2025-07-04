function theme_dark
    yes | fish_config theme save astrodark

    sed -i s/adwaita/tokyo-night/g ~/.config/btop/btop.conf
    sed -i s/astrolight/astrodark/g ~/.config/nvim/lua/plugins/astroui.lua

    set -Ux LS_COLORS (vivid generate astrodark)
    set -Ux FZF_DEFAULT_OPTS "--highlight-line --info=inline-right --ansi --layout=reverse --border=none --color=bg+:#1E222A --color=bg:#1A1D23 --color=border:#3A3E47 --color=fg+:#ADB0BB --color=fg:#ADB0BB --color=gutter:#1A1D23 --color=header:#50A4E9 --color=hl+:#5EB7FF --color=hl:#5EB7FF --color=info:#3A3E47 --color=marker:#5EB7FF --color=pointer:#5EB7FF --color=prompt:#5EB7FF --color=query:#ADB0BB:regular --color=scrollbar:#3A3E47 --color=separator:#3A3E47 --color=spinner:#5EB7FF"
    set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/astrodark.yml"
    set -Ux BAT_THEME astrodark

    kitty +kitten themes --reload-in=all AstroDark
    plasma-apply-cursortheme breeze_cursors &>/dev/null
    # plasma-apply-lookandfeel --apply com.endeavouros.breezedarkeos.desktop
    # plasma-apply-colorscheme BreezeDark
    # plasma-apply-desktoptheme breeze-dark
    # systemctl --user restart plasma-plasmashell
end
