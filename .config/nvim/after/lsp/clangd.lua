local uv = require "luv"

local cpus = uv.available_parallelism()

return {
  cmd = {
    "clangd",
    "--all-scopes-completion",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--cross-file-rename",
    "--enable-config",
    "--fallback-style=llvm",
    "--folding-ranges",
    "--function-arg-placeholders",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--log=error",
    "--pch-storage=memory",
    "--pretty",
    "--suggest-missing-includes",
    "-j=" .. cpus,
  },
  init_options = {
    clangdFileStatus = true,
    completeUnimported = true,
    fallbackFlags = { "-std=c++23" },
    semanticHighlighting = true,
    usePlaceholders = true,
  },
}
