function theme_light
    yes | fish_config theme save astrolight
    sed -i s/Default/TTY/g ~/.config/btop/btop.conf
    sed -i s/dark/light/g ~/.config/nvim/lua/plugins/astroui.lua
    sed -i s/dark/light/g ~/.config/fish/config.fish
    sed -i s/\ Dark\.profile/\.profile/g ~/.config/konsolerc
    set -Ux LS_COLORS (vivid generate astrolight)
    set -Ux FZF_DEFAULT_OPTS "--highlight-line --info=inline-right --ansi --layout=reverse --border=none --color=bg+:#EAEBEB --color=bg:#F7F8F8 --color=border:#671FF0 --color=fg:#4F4F4F --color=gutter:#F7F8F8 --color=header:#671FF0 --color=hl+:#00508A --color=hl:#00508A --color=info:#B5B9BD --color=marker:#00508A --color=pointer:#00508A --color=prompt:#00508A --color=query:#4F4F4F:regular --color=scrollbar:#671FF0 --color=separator:#671FF0 --color=spinner:#00508A"
    plasma-apply-cursortheme Breeze_Light
end
