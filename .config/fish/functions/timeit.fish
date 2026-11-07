function timeit --description 'Timer with notification, requires libnotify for notifications (timeit)'
    if test (count $argv) -eq 0
        echo "Usage: timeit <command>"
        return 1
    end

    # Build command string and extract first token.
    set -l cmd (string join ' ' -- $argv)
    set -l bin $argv[1]
    set -l expanded_flag 0

    # Abbreviations - Binary support.
    if abbr --query $bin
        for line in (abbr)
            set -l tokens (string split " " -- $line)

            # Find matching abbreviation entry.
            if test (count $tokens) -ge 4
                if test $tokens[4] = $bin
                    set -l parts (string split "'" -- $line)
                    set -l expanded $parts[2]

                    # Replace argv with expanded tokens.
                    set -l expanded_tokens (string split " " -- $expanded)
                    set argv $expanded_tokens $argv[2..-1]
                    set bin $argv[1]
                    set cmd (string join ' ' -- $argv)

                    set expanded_flag 1
                    break
                end
            end
        end

        # Abbreviation not found.
        if test $expanded_flag -eq 0
            echo "timeit: abbreviation '$bin' not found."
            return 127
        end
    end

    # Detect shell operators.
    set -l has_operators 0
    if string match -q "*|*" -- "$cmd"
        set has_operators 1
    end
    if string match -q "*;*" -- "$cmd"
        set has_operators 1
    end
    if string match -q "*&&*" -- "$cmd"
        set has_operators 1
    end
    if string match -q "*||*" -- "$cmd"
        set has_operators 1
    end

    # Classify command - builtin, function, external.
    set -l kind (type -t $bin 2>/dev/null)

    if test -z "$kind"
        echo "timeit: '$bin' is not a valid command."
        return 127
    end

    # Start time.
    set -l start (date +%s%N)

    # Run the command.
    if test "$kind" = builtin -o "$kind" = function -o $has_operators -eq 1
        eval "$cmd"
    else
        $argv
    end

    # Exit status.
    set -l exit_status $status

    # End time.
    set -l end (date +%s%N)

    # Elapsed time.
    set -l elapsed_ns (math "$end - $start")
    set -l elapsed_s (math "$elapsed_ns / 1000000000.0")
    set -l mins (math "$elapsed_s / 60.0")

    # Notif status.
    if test $exit_status -eq 0
        set -l title "$cmd succeeded"
    else
        set -l title "$cmd failed (code $exit_status)"
    end

    # Desktop notif, show command run and time.
    # Comment --urgency=critical if you want notifs to countdown instead remaining on screen.
    notify-send \
        --icon=utilities-terminal \
        --urgency=critical \
        "$title" \
        "Command: $cmd\nDuration: $elapsed_s s ($mins m)"

    # Sound, try paplay otherwise canberra.
    # Comment the full sound block for no bell sound.

    # Sound block start.
    if type -q paplay
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null
    else if type -q canberra-gtk-play
        canberra-gtk-play --id=complete 2>/dev/null
    else
        printf "\a"
    end
    # Sound block end.

    # Terminal output.
    echo ""
    echo "[$(date '+%H:%M:%S')] $cmd took $elapsed_s s ($mins m)"
    echo ""

    return $exit_status
end
