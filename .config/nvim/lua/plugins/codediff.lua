--- https://github.com/esmuellert/codediff.nvim
---@type LazySpec
return {
  "esmuellert/codediff.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>gD"] = { "<Cmd>CodeDiff<CR>", desc = "View Git Codediff" },
          },
        },
      },
    },
  },
  cmd = "CodeDiff",
  opts = {},
}
