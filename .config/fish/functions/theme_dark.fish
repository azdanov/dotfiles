function theme_dark
    yes | fish_config theme save tokyonight_moon
    sed -i s/adwaita/tokyo-night/g ~/.config/btop/btop.conf
    sed -i s/day/moon/g ~/.config/nvim/lua/plugins/theme.lua
    sed -i s/day/moon/g ~/.config/fish/config.fish
    sed -i s/\.profile/\ Dark\.profile/g ~/.config/konsolerc
    set -Ux LS_COLORS (vivid generate tokyonight-moon)
    kitty +kitten themes --reload-in=all "Tokyo Night Moon"
    plasma-apply-cursortheme breeze_cursors
    # plasma-apply-lookandfeel --apply com.endeavouros.breezedarkeos.desktop
    # plasma-apply-colorscheme BreezeDark
    # plasma-apply-desktoptheme breeze-dark
    # systemctl --user restart plasma-plasmashell
end
