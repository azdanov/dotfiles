function theme_light
    yes | fish_config theme save tokyonight_day

    sed -i s/tokyo-night/adwaita/g ~/.config/btop/btop.conf
    sed -i s/tokyonight-moon/tokyonight-day/g ~/.config/nvim/lua/plugins/astroui.lua

    set -Ux LS_COLORS (vivid generate tokyonight-day)
    set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#b7c1e3 \
  --color=bg:#d0d5e3 \
  --color=border:#4094a3 \
  --color=fg:#3760bf \
  --color=gutter:#d0d5e3 \
  --color=header:#b15c00 \
  --color=hl+:#188092 \
  --color=hl:#188092 \
  --color=info:#8990b3 \
  --color=marker:#d20065 \
  --color=pointer:#d20065 \
  --color=prompt:#188092 \
  --color=query:#3760bf:regular \
  --color=scrollbar:#4094a3 \
  --color=separator:#b15c00 \
  --color=spinner:#d20065 \
"
    set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/tokyonight_day.yml"
    set -Ux BAT_THEME tokyonight_day

    kitty +kitten themes --reload-in=all "Tokyo Night Day"
    plasma-apply-cursortheme Breeze_Light &>/dev/null
    # plasma-apply-lookandfeel --apply org.kde.breeze.desktop
    # plasma-apply-colorscheme BreezeLight
    # plasma-apply-desktoptheme breeze-light
    # systemctl --user restart plasma-plasmashell
end
