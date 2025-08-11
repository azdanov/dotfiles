--- https://github.com/Saghen/blink.cmp
--- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/blink.lua
---@type LazySpec
return {
  "saghen/blink.cmp",
  ---@module "blink-cmp"
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = false,
      },
      list = {
        selection = {
          auto_insert = false,
          preselect = false,
        },
      },
    },
    sources = {
      providers = {
        path = {
          enabled = function() return vim.bo.filetype ~= "copilot-chat" end,
          opts = {
            show_hidden_files_by_default = true,
            trailing_slash = false,
          },
        },
      },
    },
  },
}
