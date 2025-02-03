---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = function(_, opts)
    if not opts.library then
      opts.library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "astrocore", words = { "AstroCore" } },
        { path = "astrolsp", words = { "AstroLSP" } },
        { path = "astroui", words = { "AstroUI" } },
        { path = "astrotheme", words = { "AstroTheme" } },
        { path = "lazy.nvim", words = { "Lazy" } },
      }
    end
  end,
  dependencies = {
    { "folke/neodev.nvim", enabled = false },
    { "Bilal2453/luvit-meta", lazy = true },
    {
      "Saghen/blink.cmp",
      opts = {
        sources = {
          default = { "lazydev" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
      },
    },
  },
}
