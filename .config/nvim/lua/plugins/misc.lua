return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gotmpl",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 80,
      engines = {
        astgrep = {
          path = "ast-grep",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = {
          silent = true,
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                width = 30,
              },
            },
          },
        },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      question_header = " User ",
      auto_insert_mode = false,
    },
  },
  {
    "lewis6991/satellite.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      excluded_filetypes = {
        "Lazy",
        "Outline",
        "bigfile",
        "dashboard",
        "edgy",
        "floaterm",
        "noice",
        "notify",
        "outline",
        "prompt",
        "qf",
        "snacks_picker_list",
        "toggleterm",
        "trouble",
      },
    },
  },
}
