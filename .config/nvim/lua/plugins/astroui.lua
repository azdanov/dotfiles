--- https://github.com/AstroNvim/astroui
---@type LazySpec
return {
  "AstroNvim/astroui",
  dependencies = {
    {
      "thesimonho/kanagawa-paper.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        overrides = function()
          return {
            LazyButtonActive = { link = "Visual" },
          }
        end,
      },
    },
  },
  ---@type AstroUIOpts
  opts = {
    colorscheme = "kanagawa-paper-ink",
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
