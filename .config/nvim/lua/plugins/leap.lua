--- https://github.com/ggandor/leap.nvim
---@type LazySpec
return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
            ["gs"] = { "<Plug>(leap-from-window)", desc = "Leap from Window" },
          },
          x = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
          },
          o = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
          },
        },
      },
    },
  },
  opts = {},
}
