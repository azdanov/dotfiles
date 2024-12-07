if status is-interactive
    $HOME/.local/bin/mise activate fish | source
else
    $HOME/.local/bin/mise activate fish --shims | source
end

abbr -a -- vi nvim
abbr -a -- vim nvim
abbr -a -- nvide neovide
abbr -a -- gg lazygit

set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/latte-blue.yml"

starship init fish | source
zoxide init fish | source
