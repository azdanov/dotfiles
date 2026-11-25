set -gx PAGER less
set -gx EDITOR nvim
set -gx fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

if status is-interactive
    # nvim's man viewer needs a terminal; man's default pager is safer in scripts
    if not set -q MANPAGER; and type -q nvim
        set -gx MANPAGER 'nvim +Man!'
    end

    $HOME/.local/bin/mise activate fish | source
    theme
else
    $HOME/.local/bin/mise activate fish --shims | source
end

zoxide init fish | source
starship init fish | source

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"
