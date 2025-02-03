---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "sqruff" },
      config = {
        sqruff = {
          cmd = { "sqruff", "lsp" },
          filetypes = { "sql" },
          root_dir = require("lspconfig.util").root_pattern ".sqruff",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "sql" },
    },
  },
}
