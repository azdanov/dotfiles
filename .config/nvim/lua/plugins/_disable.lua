local disable = {
  "jay-babu/mason-null-ls.nvim",
  "nvimtools/none-ls.nvim",
  "max397574/better-escape.nvim",
}

return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, disable)
