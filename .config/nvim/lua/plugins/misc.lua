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
}
