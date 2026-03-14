set -gx PAGER less
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'
set -gx fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

if status is-interactive
    $HOME/.local/bin/mise activate fish | source
    theme
else
    $HOME/.local/bin/mise activate fish --shims | source
end

zoxide init fish | source
starship init fish | source
