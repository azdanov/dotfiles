if status is-interactive

    function __load_secret --argument-names name file
        test -r $file; or return 0 # missing file: skip silently
        read -l value <$file # first line only, no trailing newline
        test -n "$value"; or return 0 # empty file: skip
        set -gx $name $value
    end

    __load_secret GITHUB_API_KEY ~/.secrets/github
    __load_secret KAGI_API_KEY ~/.secrets/kagi

    functions -e __load_secret # don't leave the helper defined

end
