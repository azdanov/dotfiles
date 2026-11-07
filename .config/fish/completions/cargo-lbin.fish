# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_cargo_lbin_global_optspecs
    string join \n prefix= h/help V/version
end

function __fish_cargo_lbin_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_cargo_lbin_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_cargo_lbin_using_subcommand
    set -l cmd (__fish_cargo_lbin_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -s V -l version -d 'Print version'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "install" -d 'Build crates from crates.io and install their binaries. `NAME@VERSION` installs exactly that version and pins it'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "remove" -d 'Remove previously installed binaries'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "pin" -d 'Hold crates at their installed version: excluded from `update --all`, refused by `update NAME` and `install NAME` until unpinned'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "unpin" -d 'Release a pin'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "list" -d 'List installed crates and their binaries'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "tui" -d 'Interactive front end over the same commands (starts from disk; nothing runs unprompted)'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "info" -d 'Show one or more crates exactly by name: latest versions and whether they are installed under the prefix'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "search" -d 'Find crates on crates.io by keyword; marks the ones installed under the prefix'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "checkupdate" -d 'Check crates.io for newer versions (read-only, no sudo). Exit codes: 0 updates available, 2 none, 1 error'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "downgrade" -d 'Pick an older version of an installed crate from crates.io, install it and pin it'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "completions" -d 'Print a shell completion script for cargo-lbin\'s commands and flags to stdout'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "update" -d 'Update installed crates to their newest crates.io versions'
complete -c cargo-lbin -n "__fish_cargo_lbin_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand install" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand install" -l locked -d 'Build with the crate\'s committed Cargo.lock (reproducible; skips newer dependency releases until the crate itself releases)'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand install" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand remove" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand remove" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand pin" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand pin" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand unpin" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand unpin" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand list" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand list" -l json -d 'Machine-readable output (schema documented in README)'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand list" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand tui" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand tui" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand info" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand info" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand search" -l limit -d 'Maximum number of results (1-100)' -r
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand search" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand search" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand checkupdate" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand checkupdate" -l json -d 'Machine-readable output (schema documented in README)'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand checkupdate" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand downgrade" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand downgrade" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand completions" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand completions" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand update" -l prefix -d 'Installation prefix; binaries land in <prefix>/bin' -r -F
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand update" -l all -d 'Update every installed crate that has a newer version'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand update" -s y -l yes -d 'Skip the confirmation prompt'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand update" -s h -l help -d 'Print help'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "install" -d 'Build crates from crates.io and install their binaries. `NAME@VERSION` installs exactly that version and pins it'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "remove" -d 'Remove previously installed binaries'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "pin" -d 'Hold crates at their installed version: excluded from `update --all`, refused by `update NAME` and `install NAME` until unpinned'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "unpin" -d 'Release a pin'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "list" -d 'List installed crates and their binaries'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "tui" -d 'Interactive front end over the same commands (starts from disk; nothing runs unprompted)'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "info" -d 'Show one or more crates exactly by name: latest versions and whether they are installed under the prefix'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "search" -d 'Find crates on crates.io by keyword; marks the ones installed under the prefix'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "checkupdate" -d 'Check crates.io for newer versions (read-only, no sudo). Exit codes: 0 updates available, 2 none, 1 error'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "downgrade" -d 'Pick an older version of an installed crate from crates.io, install it and pin it'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "completions" -d 'Print a shell completion script for cargo-lbin\'s commands and flags to stdout'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "update" -d 'Update installed crates to their newest crates.io versions'
complete -c cargo-lbin -n "__fish_cargo_lbin_using_subcommand help; and not __fish_seen_subcommand_from install remove pin unpin list tui info search checkupdate downgrade completions update help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
