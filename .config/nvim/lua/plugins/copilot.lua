--- https://github.com/zbirenbaum/copilot.lua
---@type LazySpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "User AstroFile",
  opts = {
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = "off",
        },
      },
    },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
