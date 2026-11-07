function pbpaste
    switch (echo $XDG_SESSION_TYPE)
        case wayland
            if command -v wl-paste &>/dev/null
                wl-paste $argv
            end
        case '*'
            if command -v xclip &>/dev/null
                xclip -selection clipboard -o $argv
            else if command -v xsel &>/dev/null
                xsel --clipboard --output $argv
            else if command -v termux-clipboard-get &>/dev/null
                termux-clipboard-get $argv
            else if command -v pbpaste &>/dev/null
                /usr/bin/pbpaste $argv
            end
    end
end
