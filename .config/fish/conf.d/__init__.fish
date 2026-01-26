#
# __init__: Anything that needs to be first.
#

# Ensure manpath is set to something so we can add to it.
set -q MANPATH || set -gx MANPATH ''

# Add more man page paths.
for manpath in (path filter $__fish_data_dir/man /usr/local/share/man /usr/share/man)
    set -a MANPATH $manpath
end

# Allow subdirs for functions and completions.
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path

# Colorize man pages.
set -gx LESS_TERMCAP_mb (set_color -o blue)
set -gx LESS_TERMCAP_md (set_color -o cyan)
set -gx LESS_TERMCAP_me (set_color normal)
set -gx LESS_TERMCAP_so (set_color -b white black)
set -gx LESS_TERMCAP_se (set_color normal)
set -gx LESS_TERMCAP_us (set_color -u magenta)
set -gx LESS_TERMCAP_ue (set_color normal)

# Set editor variables.
set -gx PAGER less
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'

set -gx fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

# Abbreviations
abbr -a -- gg lazygit
