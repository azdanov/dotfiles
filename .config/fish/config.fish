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

set -Ux EDITOR nvim
set -Ux MANPAGER 'nvim +Man!'
set -Ux LG_CONFIG_FILE "$HOME/.config/lazygit/astrolight.yml"
set -Ux BAT_THEME astrolight

set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

starship init fish | source
zoxide init fish | source
