---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          gs = {
            function() require("vtsls").commands.goto_source_definition() end,
            desc = "Goto Source Definition",
            cond = function(client) return client.name == "vtsls" end,
          },
        },
      },
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
