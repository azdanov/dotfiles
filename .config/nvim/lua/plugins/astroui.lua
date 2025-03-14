if vim.g.vscode then return {} end

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
    },
  },
}
