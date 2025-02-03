---@type LazySpec
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          config = {
            jsonls = {
              on_new_config = function(config)
                if not config.settings.json.schemas then config.settings.json.schemas = {} end
                vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
              end,
              settings = {
                json = {
                  validate = {
                    enable = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "json", "jsonc" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "json-lsp", "prettierd" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettierd" },
      },
    },
  },
}
