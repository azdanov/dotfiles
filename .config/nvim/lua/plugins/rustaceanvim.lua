--- https://github.com/mrcjkb/rustaceanvim
---@type LazySpec
return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  init = function()
    ---@module 'rustaceanvim'
    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            files = {
              excludeDirs = {
                ".git",
                ".github",
                "node_modules",
                "target",
              },
            },
          },
        },
      },
    }
  end,
  specs = {
    { "AstroNvim/astrolsp", opts = { handlers = { rust_analyzer = false } } },
  },
}
