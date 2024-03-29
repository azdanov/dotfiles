return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },
  { "tpope/vim-sleuth", event = "VeryLazy" },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "j-hui/fidget.nvim",
    lazy = true,
    opts = {},
  },
  {
    "echasnovski/mini.files",
    version = false,
    lazy = false,
    keys = {
      { "<leader>fm", "<cmd>:lua MiniFiles.open()<cr>", desc = "Files" },
    },
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
    },
  },
}
