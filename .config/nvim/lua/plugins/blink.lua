---@type LazySpec
return {
  "saghen/blink.cmp",
  ---@module "blink-cmp"
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = {
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
}
