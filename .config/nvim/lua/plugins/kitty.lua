---@see https://github.com/mikesmithgh/kitty-scrollback.nvim
---@type LazySpec
return {
  "mikesmithgh/kitty-scrollback.nvim",
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth", "KittyScrollbackGenerateCommandLineEditing" },
  event = { "User KittyScrollbackLaunch" },
  version = "*",
  opts = {},
}
