---@type LazySpec
return {
  {
    "catppuccin",
    optional = true,
    ---@module 'catppuccin'
    ---@type CatppuccinOptions
    opts = {
      integrations = {
        snacks = {
          enabled = true,
          indent_scope_color = "lavender",
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      scroll = {
        enabled = false,
      },
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        ui_helpers = {
          {
            event = "User",
            pattern = "BlinkCmpMenuOpen",
            group = "ui_helpers",
            desc = "Disable snacks animation when BlinkCmp menu is open",
            callback = function() vim.g.snacks_animate = false end,
          },
          {
            event = "User",
            pattern = "BlinkCmpMenuClose",
            group = "ui_helpers",
            desc = "Enable snacks animation when BlinkCmp menu is closed",
            callback = function() vim.g.snacks_animate = true end,
          },
        },
      },
    },
  },
}
