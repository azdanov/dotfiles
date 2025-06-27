---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      autocmds = {
        eslint_fix_on_save = false,
        killall_daemons_on_exit = {
          {
            event = "VimLeavePre",
            desc = "Kill daemons on exit",
            callback = function() vim.fn.jobstart("killall prettierd eslint_d", { detach = true }) end,
          },
        },
      },
      ---@diagnostic disable: missing-fields
      config = {
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              buildFlags = { "-tags=unit integration e2e" },
            },
          },
        },
      },
    },
  },
}
