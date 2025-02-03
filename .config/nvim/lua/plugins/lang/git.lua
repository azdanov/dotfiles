---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "gitignore", "gitattributes", "git_config" },
  },
}
