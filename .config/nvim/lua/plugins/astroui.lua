--- https://github.com/AstroNvim/astroui
---@type LazySpec
return {
  "AstroNvim/astroui",
  dependencies = {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
  },
  ---@type AstroUIOpts
  opts = {
    colorscheme = "tokyonight-day",
    status = {
      separators = {
        breadcrumbs = "  ",
        path = "  ",
      },
      providers = {
        lsp_client_names = {
          mappings = {
            ["GitHub Copilot"] = "copilot",
            ["crates.nvim"] = "crates",
            ["lua_ls"] = "lua",
            ["rust-analyzer"] = "rust",
            ["rustfmt"] = "rust",
            ["sonarlint.nvim"] = "sonar",
            ["typos_lsp"] = "typos",
          },
        },
      },
    },
  },
}
