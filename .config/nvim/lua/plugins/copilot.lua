--- https://github.com/zbirenbaum/copilot.lua
---@type LazySpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "User AstroFile",
  opts = {
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
