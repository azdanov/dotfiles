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
                "node_modules",
                "target",
              },
            },
            check = { command = "clippy" },
          },
        },
      },
    }
  end,
}
