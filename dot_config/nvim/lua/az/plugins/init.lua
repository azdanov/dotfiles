return {
  "tpope/vim-sleuth",
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  { "echasnovski/mini.comment", version = false, opts = {} },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
    },
  },
}
