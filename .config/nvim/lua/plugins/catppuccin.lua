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
      flash = true,
      dap = true,
      dap_ui = true,
      dadbod_ui = true,
      gitsigns = true,
      grug_far = true,
      illuminate = true,
      markdown = true,
      mason = true,
      native_lsp = { enabled = true },
      neotree = true,
      notify = true,
      semantic_tokens = true,
      snacks = { enabled = true, indent_scope_color = "lavender" },
      symbols_outline = true,
      treesitter = true,
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
