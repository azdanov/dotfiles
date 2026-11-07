function open
    switch (uname -o)
        case Android
            termux-open $argv
        case GNU/Linux
            xdg-open $argv
        case Darwin
            /usr/bin/open $argv
    end
end
