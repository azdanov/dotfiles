if status is-interactive
    $HOME/.local/bin/mise activate fish | source
else
    $HOME/.local/bin/mise activate fish --shims | source
end

abbr -a -- vi nvim
abbr -a -- vim nvim
abbr -a -- nvide neovide
abbr -a -- gg lazygit

alias yl='lazygit --work-tree ~ --git-dir ~/.local/share/yadm/repo.git'

set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'

set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

set -e -g LS_COLORS FZF_DEFAULT_OPTS LG_CONFIG_FILE BAT_THEME
dbus-update-activation-environment --systemd LS_COLORS FZF_DEFAULT_OPTS LG_CONFIG_FILE BAT_THEME

starship init fish | source
zoxide init fish | source
