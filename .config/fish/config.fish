if status is-interactive
    mise activate fish | source
    theme
else
    mise activate fish --shims | source
end

starship init fish | source
zoxide init fish | source
