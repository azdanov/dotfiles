--- https://github.com/yioneko/nvim-vtsls
---@type LazySpec
return {
  "yioneko/nvim-vtsls",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        autocmds = {
          nvim_vtsls = {
            {
              event = "LspAttach",
              desc = "Load nvim-vtsls with vtsls",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "vtsls" then
                  require("vtsls")._on_attach(args.data.client_id, args.buf)
                  vim.api.nvim_del_augroup_by_name "nvim_vtsls"
                end
              end,
            },
          },
        },
      },
    },
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        mappings = {
          n = {
            gs = {
              function() require("vtsls").commands.goto_source_definition() end,
              desc = "Goto Source Definition (vtsls)",
              cond = function(client) return client.name == "vtsls" end,
            },
          },
        },
      },
    },
  },
  config = function(_, opts) require("vtsls").config(opts) end,
}
