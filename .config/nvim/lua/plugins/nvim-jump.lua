--- https://github.com/yorickpeterse/nvim-jump
---@type LazySpec
return {
  "yorickpeterse/nvim-jump",
  event = "User AstroFile",
  opts = {},
  dependencies = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local jump_start = require("jump").start
        for _, mode in ipairs { "n", "o", "x" } do
          maps[mode]["s"] = { jump_start, desc = "Jump" }
        end
      end,
    },
  },
}
