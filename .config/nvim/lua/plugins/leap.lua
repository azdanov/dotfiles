--- https://github.com/ggandor/leap.nvim
---@type LazySpec
return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },
  config = function() require("leap").set_default_mappings() end,
}
