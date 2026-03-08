if status is-interactive
    $HOME/.local/bin/mise activate fish | source
    theme
else
    $HOME/.local/bin/mise activate fish --shims | source
end

starship init fish | source
zoxide init fish | source
