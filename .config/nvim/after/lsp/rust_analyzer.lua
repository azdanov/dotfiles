---@type vim.lsp.Config
return {
  ---@type lsp.rust_analyzer
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
      cargo = { features = "all" },
      interpret = { tests = true },
      rustfmt = {
        extraArgs = { "+nightly" },
      },
    },
  },
}
