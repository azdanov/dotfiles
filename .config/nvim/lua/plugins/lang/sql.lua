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
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sql" })
    end,
  },
}
