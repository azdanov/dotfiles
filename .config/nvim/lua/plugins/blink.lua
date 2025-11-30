--- https://github.com/saghen/blink.cmp
--- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/blink.lua
---@type LazySpec
return {
  "Saghen/blink.cmp",
  ---@module "blink-cmp"
  ---@type blink.cmp.Config
  opts = {
    completion = {
      ghost_text = { enabled = true },
      list = {
        selection = { preselect = false, auto_insert = false },
      },
    },
    keymap = {
      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    signature = { enabled = true },
    sources = {
      providers = {
        path = {
          opts = { show_hidden_files_by_default = true, trailing_slash = false },
        },
      },
    },
  },
}
