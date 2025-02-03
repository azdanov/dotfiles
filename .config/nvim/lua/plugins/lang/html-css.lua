---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        extension = {
          pcss = "postcss",
          postcss = "postcss",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.treesitter.language.register("scss", "less")
      vim.treesitter.language.register("scss", "postcss")
    end,
    opts = {
      ensure_installed = { "html", "css", "scss" },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        html = {
          init_options = {
            provideFormatter = false,
          },
        },
        cssls = {
          init_options = {
            provideFormatter = false,
          },
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "html-lsp", "css-lsp", "emmet-ls", "prettierd" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        less = { "prettierd" },
        postcss = { "prettierd" },
      },
    },
  },
}
