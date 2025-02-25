---@type LazySpec
return {
  {
    "tpope/vim-rsi",
    event = { "CmdlineEnter", "InsertEnter" },
  },
  {
    "johmsalas/text-case.nvim",
    event = "User AstroFile",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      duration_multiplier = 0.5,
    },
  },
  {
    "lewis6991/satellite.nvim",
    event = "User AstroFile",
    opts = {
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "neo-tree",
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    dependencies = {
      { "numToStr/Comment.nvim", enabled = false, optional = true },
      { "JoosepAlviste/nvim-ts-context-commentstring", enabled = false, optional = true },
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "User AstroFile",
    cmd = "HighlightColors",
    dependencies = {
      { "NvChad/nvim-colorizer.lua", enabled = false, optional = true },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = opts.mappings or {}
          maps.n["<Leader>uz"] = {
            function() vim.cmd.HighlightColors "Toggle" end,
            desc = "Toggle color highlight",
          }
          opts.mappings = maps
        end,
      },
    },
    opts = { enabled_named_colors = false },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if not opts.signs then opts.signs = {} end
        opts.signs.BqfSign = { text = " " .. require("astroui").get_icon "Selected", texthl = "BqfSign" }
      end,
    },
    opts = {
      auto_resize_height = true,
      preview = {
        auto_preview = false,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
          },
        },
      },
      window = {
        width = 30,
        mappings = {
          ["z"] = "none",
        },
      },
    },
  },
}
