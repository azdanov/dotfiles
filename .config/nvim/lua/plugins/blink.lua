--- https://github.com/Saghen/blink.cmp
--- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/blink.lua
---@type LazySpec
return {
  "saghen/blink.cmp",
  ---@module "blink-cmp"
  ---@type blink.cmp.Config
  opts = {
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
