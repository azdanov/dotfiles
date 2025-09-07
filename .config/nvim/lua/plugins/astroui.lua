--- https://github.com/AstroNvim/astroui
---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "astrolight",
    status = {
      separators = {
        breadcrumbs = "  ",
        path = "  ",
      },
      providers = {
        lsp_client_names = {
          mappings = {
            ["node"] = "copilot",
            ["crates.nvim"] = "crates",
            ["lua_ls"] = "lua",
            ["rust-analyzer"] = "rust",
            ["rustfmt"] = "rust",
            ["typos_lsp"] = "typos",
          },
        },
      },
    },
  },
}
