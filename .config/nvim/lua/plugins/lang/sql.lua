---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "sqruff")
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        sqruff = {
          cmd = {
            "sqruff",
            "lsp",
          },
          filetypes = { "sql" },
          root_dir = require("lspconfig.util").root_pattern ".sqruff",
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sql" })
      end
    end,
  },
  -- Not available yet
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sqruff" })
  --   end,
  -- },
}
