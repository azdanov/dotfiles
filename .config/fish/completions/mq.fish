# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_mq_global_optspecs
    string join \n A/aggregate f/from-file I/input-format= csv-delimiter= no-header L/directory= M/module-names= m/import-module-names= args= argjson= rawfile= slurpfile= stream watch eval-all allow-http-import allowed-domain= refresh-modules clear-cache no-lockfile frozen lockfile= N/allow-net= R/allow-read= W/allow-write= allow-run= E/allow-env= a/allow-all F/output-format= U/update diff unbuffered list-style= link-title-style= link-url-style= S/separator= o/output= atomic-output= C/color-output B/before-context= after-context= context= e/exit-status c/count skip= limit= no-position compact indent= tab T/format= list P= argv= O/optimize-level= timeout= h/help V/version
end

function __fish_mq_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_mq_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_mq_using_subcommand
    set -l cmd (__fish_mq_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c mq -n "__fish_mq_needs_command" -s I -l input-format -d 'Set input format' -r -f -a "markdown\t''
mdx\t''
html\t''
text\t''
null\t''
raw\t''
bytes\t''
cbor\t''
csv\t''
gron\t''
json\t''
psv\t''
toml\t''
toon\t''
tsv\t''
xml\t''
yaml\t''"
complete -c mq -n "__fish_mq_needs_command" -l csv-delimiter -d 'Custom delimiter for `-I csv` input (a single ASCII character). Has no effect on `-I tsv`/`-I psv`, which use a fixed tab/pipe delimiter by design; pass `-I csv` with this flag instead if you need a different delimiter (e.g. `;`)' -r
complete -c mq -n "__fish_mq_needs_command" -s L -l directory -d 'Search modules from the directory' -r -F
complete -c mq -n "__fish_mq_needs_command" -s M -l module-names -d 'Load additional modules from specified files' -r
complete -c mq -n "__fish_mq_needs_command" -s m -l import-module-names -d 'Import modules by name, making them available as `name::fn()` in queries' -r
complete -c mq -n "__fish_mq_needs_command" -l args -d 'Sets a named string argument. NAME is accessible directly in queries, and also via ARGS."named" when --args or --argv is given' -r
complete -c mq -n "__fish_mq_needs_command" -l argjson -d 'Sets a named JSON argument. NAME is accessible directly in queries' -r
complete -c mq -n "__fish_mq_needs_command" -l rawfile -d 'Sets file contents that can be referenced at runtime' -r
complete -c mq -n "__fish_mq_needs_command" -l slurpfile -d 'Sets a named argument from a JSON file. NAME is bound to an array of every JSON value found in FILE (jq --slurpfile compatible), so a file containing a single JSON value becomes a one-element array' -r
complete -c mq -n "__fish_mq_needs_command" -l allowed-domain -d 'Allow HTTP imports from additional domain(s) beyond the default. Has no effect unless `--allow-http-import` (or `--allow-all`) is also passed. Use `github.com/{user}/{repo}` to allow a specific repository (expanded automatically), or a plain domain like `example.com` to allow any path under that host. Repeat to allow multiple extra domains' -r
complete -c mq -n "__fish_mq_needs_command" -l lockfile -d 'Path to the mq.lock file used for HTTP import integrity checks. Defaults to ./mq.lock (relative to the current directory)' -r -F
complete -c mq -n "__fish_mq_needs_command" -s N -l allow-net -d 'Allow the `http` function to make outbound HTTPS requests. Disabled by default; requests are HTTPS-only and blocked from reaching loopback/private/link-local addresses regardless of this flag. Pass with no value to allow any domain, or `--allow-net=DOMAIN` (repeat the flag, or comma-separate, to add more) to restrict requests to just those domains (and any path under them). The `=` is required so a bare domain after the flag isn\'t swallowed as a query/file positional instead' -r
complete -c mq -n "__fish_mq_needs_command" -s R -l allow-read -d 'Allow the `read_file`/`read_file_bytes`/`collection`/`file_exists`/`embed_images` functions to read from the filesystem. Disabled by default. Pass with no value to allow reading anywhere, or `--allow-read=PATH` (files or directories; repeat the flag, or comma-separate, to add more) to restrict reads to just those paths and their descendants. The `=` is required so a bare path after the flag isn\'t swallowed as a query/file positional instead' -r -F
complete -c mq -n "__fish_mq_needs_command" -s W -l allow-write -d 'Allow the `write_file`/`extract_images` functions to write to the filesystem. Disabled by default. Pass with no value to allow writing anywhere, or `--allow-write=PATH` (files or directories; repeat the flag, or comma-separate, to add more) to restrict writes to just those paths and their descendants. The `=` is required so a bare path after the flag isn\'t swallowed as a query/file positional instead' -r -F
complete -c mq -n "__fish_mq_needs_command" -l allow-run -d 'Allow the `system` function to execute external commands. Disabled by default. Commands run directly (never through a shell), so shell metacharacters in arguments are never interpreted. Pass with no value to allow any command, or `--allow-run=COMMAND` (repeat the flag, or comma-separate, to add more) to restrict execution to just those commands. The `=` is required so a bare command after the flag isn\'t swallowed as a query/file positional instead' -r
complete -c mq -n "__fish_mq_needs_command" -s E -l allow-env -d 'Allow `$VAR`/`${$VAR}` interpolation and debugger logpoints to read environment variables. Disabled by default. Pass with no value to allow reading any variable, or `--allow-env=NAME` (repeat the flag, or comma-separate, to add more) to restrict access to just those names. The `=` is required so a bare name after the flag isn\'t swallowed as a query/file positional instead' -r
complete -c mq -n "__fish_mq_needs_command" -s F -l output-format -d 'Set output format. When omitted, inferred from the `-o`/`--output` file extension if given (e.g. `.json` -> json, `.csv` -> csv), else defaults to markdown' -r -f -a "markdown\t''
html\t''
text\t''
json\t''
table\t''
grep\t''
gron\t''
raw\t''
csv\t''
toml\t''
toon\t''
xml\t''
yaml\t''
shell\t''
none\t''"
complete -c mq -n "__fish_mq_needs_command" -l list-style -d 'Set the list style for markdown output' -r -f -a "dash\t''
plus\t''
star\t''"
complete -c mq -n "__fish_mq_needs_command" -l link-title-style -d 'Set the link title surround style for markdown output' -r -f -a "double\t''
single\t''
paren\t''"
complete -c mq -n "__fish_mq_needs_command" -l link-url-style -d 'Set the link URL surround style for markdown links' -r -f -a "none\t''
angle\t''"
complete -c mq -n "__fish_mq_needs_command" -s S -l separator -d 'Specify a query to insert between files as a separator' -r
complete -c mq -n "__fish_mq_needs_command" -s o -l output -d 'Output to the specified file' -r -F
complete -c mq -n "__fish_mq_needs_command" -l atomic-output -d 'Write `-o`/`--output` atomically via a same-directory temp file + fsync + rename, so a crash or full disk mid-write can\'t truncate the target' -r -f -a "auto\t'Atomic for a missing or regular-file target; direct write for pipes/devices'
always\t'Always write atomically, even over pipes/devices'
never\t'Always write directly to the target path, truncating it up front'"
complete -c mq -n "__fish_mq_needs_command" -s B -l before-context -d 'Show NUM nodes before each match. Only effective with -F grep' -r
complete -c mq -n "__fish_mq_needs_command" -l after-context -d 'Show NUM nodes after each match. Only effective with -F grep' -r
complete -c mq -n "__fish_mq_needs_command" -l context -d 'Show NUM nodes before and after each match. Only effective with -F grep' -r
complete -c mq -n "__fish_mq_needs_command" -l skip -d 'Skip the first N matching results before outputting' -r
complete -c mq -n "__fish_mq_needs_command" -l limit -d 'Limit output to at most N results' -r
complete -c mq -n "__fish_mq_needs_command" -l indent -d 'Number of spaces per indent level in pretty-printed output (0-7), jq\'s `--indent`. Only valid with -F json or -F xml; default is 2' -r
complete -c mq -n "__fish_mq_needs_command" -s T -l format -d 'Set both input and output format at once (shorthand for `-I FORMAT -F FORMAT`). An explicit `-I`/`-F` overrides this for that side. Only accepts formats valid on both sides; e.g. `-I mdx` or `-F table` still require the dedicated flag' -r -f -a "markdown\t''
html\t''
text\t''
json\t''
gron\t''
raw\t''
csv\t''
toml\t''
toon\t''
xml\t''
yaml\t''"
complete -c mq -n "__fish_mq_needs_command" -s P -d 'Number of files to process before switching to parallel processing' -r
complete -c mq -n "__fish_mq_needs_command" -l argv -d 'Positional string arguments, available as ARGS."positional" in queries' -r
complete -c mq -n "__fish_mq_needs_command" -s O -l optimize-level -d 'Optimization level for AST transformations (none = no changes, basic = constant folding and dead-branch elimination, full = all passes)' -r -f -a "none\t''
basic\t''
full\t''"
complete -c mq -n "__fish_mq_needs_command" -l timeout -d 'Maximum time in seconds allowed for query evaluation before aborting (e.g. 0.5, 5). No timeout by default' -r
complete -c mq -n "__fish_mq_needs_command" -s A -l aggregate -d 'Aggregate all input files/content into a single array'
complete -c mq -n "__fish_mq_needs_command" -s f -l from-file -d 'load filter from the file'
complete -c mq -n "__fish_mq_needs_command" -l no-header -d 'Treat csv/tsv/psv input as headerless: each row becomes an array of values instead of a dict keyed by header names. Applies to `-I csv`, `-I tsv`, and `-I psv`'
complete -c mq -n "__fish_mq_needs_command" -l stream -d 'Enable streaming mode for processing large files line by line'
complete -c mq -n "__fish_mq_needs_command" -l watch -d 'Watch the input file(s) for changes and automatically re-run the query whenever they change. Requires at least one input file (stdin cannot be watched). With --from-file, the query file is watched too. Runs until interrupted (Ctrl-C); a query error is printed to stderr and watching continues rather than exiting'
complete -c mq -n "__fish_mq_needs_command" -l eval-all -d 'Evaluate the query once against all input files combined (like yq\'s `eval-all`), instead of once per file. Enables cross-file aggregation in a single query'
complete -c mq -n "__fish_mq_needs_command" -l allow-http-import -d 'Allow `import`/`include` to fetch modules over HTTP(S). Disabled by default'
complete -c mq -n "__fish_mq_needs_command" -l refresh-modules -d 'Force re-fetch of mutable-ref (HEAD/branch) HTTP-imported modules, ignoring the local cache. Versioned (tagged) modules are never re-fetched regardless of this flag'
complete -c mq -n "__fish_mq_needs_command" -l clear-cache -d 'Remove all HTTP module cache including versioned (tagged) modules and lock files. Use this to fully reset the cache when something goes wrong'
complete -c mq -n "__fish_mq_needs_command" -l no-lockfile -d 'Disable the mq.lock integrity check for HTTP imports. By default a fetched URL\'s content is checked against mq.lock, and a mismatch is rejected unless --refresh-modules is also passed'
complete -c mq -n "__fish_mq_needs_command" -l frozen -d 'Fail instead of recording a new mq.lock entry. `--frozen`; use in CI so a new module\'s content is only ever trusted during a reviewable local run whose mq.lock diff gets committed, not silently during CI'
complete -c mq -n "__fish_mq_needs_command" -s a -l allow-all -d 'Grant every sandboxed permission at once (read/write/net/run/env), and also enable HTTP module imports as if --allow-http-import were passed. Disabled by default. Cannot be combined with the individual --allow-* flags above'
complete -c mq -n "__fish_mq_needs_command" -s U -l update -d 'Update matching Markdown nodes and write the result to stdout'
complete -c mq -n "__fish_mq_needs_command" -l diff -d 'With --update, print a unified diff instead of the transformed content; nothing is written. Multiple files are diffed one at a time with their path in the headers; stdin is labeled `<stdin>`. Exits 1 if anything would change'
complete -c mq -n "__fish_mq_needs_command" -l unbuffered -d 'Unbuffered output'
complete -c mq -n "__fish_mq_needs_command" -s C -l color-output -d 'Colorize markdown output'
complete -c mq -n "__fish_mq_needs_command" -s e -l exit-status -d 'Exit with code 1 if the last output value is false, null, or the output is empty. Mirrors jq\'s --exit-status / -e flag'
complete -c mq -n "__fish_mq_needs_command" -s c -l count -d 'Output only the count of matching (non-None) results. Mirrors grep -c. With multiple files, prints "filename: N" per file and "total: N" at the end'
complete -c mq -n "__fish_mq_needs_command" -l no-position -d 'Omit Markdown node position information from structured output (json, table, gron, csv, toml, toon, xml, yaml). Reduces output size when source line/column spans aren\'t needed'
complete -c mq -n "__fish_mq_needs_command" -l compact -d 'Print JSON on a single line, without pretty-printing. Only valid with -F json'
complete -c mq -n "__fish_mq_needs_command" -l tab -d 'Indent pretty-printed output with tabs instead of spaces, jq\'s `--tab`. Only valid with -F json or -F xml'
complete -c mq -n "__fish_mq_needs_command" -l list -d 'List all available subcommands (built-in and external)'
complete -c mq -n "__fish_mq_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c mq -n "__fish_mq_needs_command" -s V -l version -d 'Print version'
complete -c mq -n "__fish_mq_needs_command" -a "repl" -d 'Start a REPL session for interactive query execution. Optional FILES are combined as the initial input (same file/format handling as `mq QUERY FILES...`)'
complete -c mq -n "__fish_mq_needs_command" -a "completion" -d 'Generate a shell completion script and print it to stdout'
complete -c mq -n "__fish_mq_needs_command" -a "help" -d 'Show documentation for a builtin function, selector, standard module, standard-module function, or the `examples` topic'
complete -c mq -n "__fish_mq_using_subcommand repl" -s h -l help -d 'Print help'
complete -c mq -n "__fish_mq_using_subcommand completion" -s h -l help -d 'Print help'
complete -c mq -n "__fish_mq_using_subcommand help" -l json -d 'Print machine-readable JSON instead of formatted text'
complete -c mq -n "__fish_mq_using_subcommand help" -l markdown -d 'Print Markdown instead of formatted text — e.g. queryable with mq itself: `mq help section --markdown | mq \'select(.code.lang == "mq")\'`'
complete -c mq -n "__fish_mq_using_subcommand help" -s h -l help -d 'Print help'
