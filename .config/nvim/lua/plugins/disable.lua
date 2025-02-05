local disable = {
  "jay-babu/mason-null-ls.nvim",
  "nvimtools/none-ls.nvim",
  "NvChad/nvim-colorizer.lua",
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "max397574/better-escape.nvim",
}

---@type LazySpec
return vim.tbl_map(function(plugin)
  return {
    plugin,
    enabled = false,
  }
end, disable)
