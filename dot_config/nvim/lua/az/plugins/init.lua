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
  { "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
  {
    "j-hui/fidget.nvim",
    event = { "VeryLazy" },
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
