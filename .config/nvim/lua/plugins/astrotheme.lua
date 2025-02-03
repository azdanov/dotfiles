---@type LazySpec
return {
  "AstroNvim/astrotheme",
  ---@type AstroThemeOpts
  opts = {
    highlights = {
      global = {
        modify_hl_groups = function(hl, c)
          hl.FzfLuaHeaderBind = {
            fg = c.ui.cyan,
          }
          hl.FzfLuaPathLineNr = {
            fg = c.ui.green,
          }
          hl.FzfLuaHeaderText = {
            fg = c.ui.red,
          }
        end,
      },
    },
  },
}
