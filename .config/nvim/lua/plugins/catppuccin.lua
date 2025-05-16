return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  ---@module 'catppuccin'
  ---@type CatppuccinOptions
  opts = {
    integrations = {
      blink_cmp = true,
      copilot_vim = true,
      dadbod_ui = true,
      diffview = true,
      flash = true,
      gitsigns = true,
      grug_far = true,
      illuminate = true,
      mason = true,
      snacks = { enabled = true, indent_scope_color = "lavender" },
      which_key = true,
      window_picker = true,
    },
  },
  specs = {
    {
      "akinsho/bufferline.nvim",
      optional = true,
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
        })
      end,
    },
  },
}
