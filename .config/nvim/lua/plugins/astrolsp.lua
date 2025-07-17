---@see https://github.com/AstroNvim/astrolsp
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    handlers = { rust_analyzer = false, jdtls = false }, -- disable automated setup
    ---@diagnostic disable: missing-fields
    config = {
      bashls = { filetypes = { "sh", "bash", "zsh" } },
      lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      taplo = { evenBetterToml = { schema = { catalogs = { "https://www.schemastore.org/api/json/catalog.json" } } } },
      typos_lsp = { single_file_support = true, workspace_required = true },
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
            enableMoveToFileCodeAction = true,
          },
          typescript = {
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
            },
            updateImportsOnFileMove = { enabled = "always" },
          },
          javascript = {
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
            },
            updateImportsOnFileMove = { enabled = "always" },
          },
        },
      },
    },
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              "target",
            },
          },
          check = {
            command = "clippy",
            extraArgs = {
              "--no-deps",
            },
          },
        },
      },
    },
    autocmds = {
      killall_daemons_on_exit = {
        {
          event = "VimLeavePre",
          desc = "Kill daemons on exit",
          callback = function() vim.fn.jobstart("killall prettierd", { detach = true }) end,
        },
      },
      no_insert_inlay_hints = {
        cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
        {
          event = "InsertEnter",
          desc = "disable inlay hints on insert",
          callback = function(args)
            local filter = { bufnr = args.buf }
            if vim.lsp.inlay_hint.is_enabled(filter) then
              vim.lsp.inlay_hint.enable(false, filter)
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = args.buf,
                once = true,
                callback = function() vim.lsp.inlay_hint.enable(true, filter) end,
              })
            end
          end,
        },
      },
    },
  },
}
