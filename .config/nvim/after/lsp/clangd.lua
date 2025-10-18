local uv = require "luv"

local threads = uv.available_parallelism and uv.available_parallelism() - 1 or 1

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
    "-j=" .. threads,
  },
  init_options = {
    clangdFileStatus = true,
    completeUnimported = true,
    fallbackFlags = { "-std=c++23" },
    semanticHighlighting = true,
    usePlaceholders = true,
  },
}
