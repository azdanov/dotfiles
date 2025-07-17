---@see https://github.com/p00f/clangd_extensions.nvim
---@type LazySpec
return {
  "p00f/clangd_extensions.nvim",
  lazy = true,
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        clangd_extensions = {
          {
            event = "LspAttach",
            desc = "Load clangd_extensions with clangd",
            callback = function(args)
              if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                require "clangd_extensions"
                vim.api.nvim_del_augroup_by_name "clangd_extensions"
              end
            end,
          },
        },
        clangd_extension_mappings = {
          {
            event = "LspAttach",
            desc = "Load clangd_extensions with clangd",
            callback = function(args)
              if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                require("astrocore").set_mappings({
                  n = {
                    ["<Leader>lw"] = { "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch source/header file" },
                  },
                }, { buffer = args.buf })
              end
            end,
          },
        },
      },
    },
  },
}
