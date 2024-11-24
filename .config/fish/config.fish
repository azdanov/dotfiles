if status is-interactive
    ~/.local/bin/mise activate fish | source
else
    ~/.local/bin/mise activate fish --shims | source
end

abbr -a -- vi nvim
abbr -a -- vim nvim
abbr -a -- gg lazygit

set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'

starship init fish | source
zoxide init fish | source
