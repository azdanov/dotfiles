return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("trouble").setup()
    vim.api.nvim_set_keymap(
      "n",
      "<leader>dt",
      "<cmd>Trouble document_diagnostics<cr>",
      { desc = "Open trouble", silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>dT",
      "<cmd>Trouble workspace_diagnostics<cr>",
      { desc = "Open trouble in workspace", silent = true, noremap = true }
    )
  end,
}
