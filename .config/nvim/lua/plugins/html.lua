return {
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       html = {
  --         "markuplint",
  --         "htmlhint",
  --       },
  --     },
  --   },
  -- },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "html-lsp",
        "emmet-language-server",
        -- "markuplint",
        -- "htmlhint",
      },
    },
  },
}
