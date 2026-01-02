--- https://github.com/esmuellert/vscode-diff.nvim
---@type LazySpec
return {
  "esmuellert/vscode-diff.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>gD"] = { "<Cmd>CodeDiff<CR>", desc = "View Git VSCode diff" },
          },
        },
      },
    },
  },
  cmd = "CodeDiff",
  opts = {},
}
