--- https://github.com/AstroNvim/astrolsp
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    handlers = { jdtls = false },
    servers = { "rust_analyzer" },
    ---@diagnostic disable: missing-fields
    config = {
      bashls = { filetypes = { "sh", "bash", "zsh" } },
      lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      taplo = { evenBetterToml = { schema = { catalogs = { "https://www.schemastore.org/api/json/catalog.json" } } } },
      typos_lsp = { single_file_support = true, workspace_required = true },
      mdx_analyzer = { filetypes = { "markdown.mdx" } },
      vtsls = {
        settings = {
          vtsls = { autoUseWorkspaceTsdk = true, enableMoveToFileCodeAction = true },
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
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                ".venv",
                "bin",
                "node_modules",
                "target",
                "venv",
              },
            },
            check = { command = "clippy" },
          },
        },
      },
      cssls = {
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
            -- doesn't work
            customData = { vim.fn.expand "~/.config/nvim/misc/tailwind.json" },
          },
        },
      },
    },
    autocmds = {
      eslint_fix_on_save = {
        cond = function(client) return client.name == "eslint" and vim.fn.exists ":LspEslintFixAll" > 0 end,
        {
          event = "BufWritePost",
          desc = "Fix all eslint errors",
          callback = function(args)
            if vim.F.if_nil(vim.b[args.buf].autoformat, vim.g.autoformat, true) then vim.cmd.LspEslintFixAll() end
          end,
        },
      },
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
