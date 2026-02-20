--- https://github.com/mcauley-penney/visual-whitespace.nvim
---@type LazySpec
return {
  "mcauley-penney/visual-whitespace.nvim",
  event = "ModeChanged *:[vV\22]",
  opts = {
    enabled = false,
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>uW"] = { require("visual-whitespace").toggle, desc = "Toggle Visual Whitespace" }
      end,
    },
  },
}
