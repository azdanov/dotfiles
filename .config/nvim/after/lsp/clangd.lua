return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--enable-config",
    "--fallback-style=llvm",
    "--function-arg-placeholders",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--log=verbose",
    "--pretty",
    "-j=16",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
    fallbackFlags = { "-std=c++23" },
  },
}
