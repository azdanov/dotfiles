if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias l='eza -lbF --git' # list, size, type, git
alias ll='eza -lbGF --git' # long list
alias la='eza -lbhHigmSa --time-style=long-iso --git --color-scale' # all list
alias lt='eza --tree --level=2 --git' # tree'
alias vim='nvim'

# history across fishes
function save_history --on-event fish_preexec
    history --save
end
alias hr 'history --merge' # read and merge history from disk
bind \e\[A 'history --merge ; up-or-search'

# pnpm
set -gx PNPM_HOME ~/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx PATH $PATH $HOME/.krew/bin ~/.local/bin
set -gx EDITOR nvim

starship init fish | source
zoxide init fish | source
