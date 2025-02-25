local shared = require "shared"

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    servers = {
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectories = { mode = "auto" },
        },
      },
    },
    autocmds = {
      eslint_fix_on_save = {
        cond = function(client) return client.name == "eslint" and vim.fn.exists ":EslintFixAll" > 0 end,
        {
          event = "BufWritePost",
          desc = "Fix all eslint errors",
          callback = function(args)
            if vim.F.if_nil(vim.b[args.buf].autoformat, vim.g.autoformat, true) then vim.cmd.EslintFixAll() end
          end,
        },
      },
    },
    ---@diagnostic disable: missing-fields
    config = {
      html = {
        init_options = {
          provideFormatter = false,
        },
      },
      cssls = {
        init_options = {
          provideFormatter = false,
        },
      },
      docker_compose_language_service = {
        init_options = {
          provideFormatter = false,
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = true,
              arrayIndex = "Disable",
            },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            analyses = {
              ST1003 = true,
              fillreturns = true,
              nilness = true,
              nonewvars = true,
              shadow = true,
              undeclaredname = true,
              unreachable = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            buildFlags = { "-tags", "integration" },
            completeUnimported = true,
            diagnosticsDelay = "500ms",
            gofumpt = true,
            matcher = "Fuzzy",
            semanticTokens = true,
            staticcheck = true,
            symbolMatcher = "fuzzy",
            usePlaceholders = true,
          },
        },
      },
      vtsls = {
        settings = {
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
          javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
          vtsls = {
            enableMoveToFileCodeAction = true,
          },
        },
      },
      basedpyright = {
        before_init = function(_, c)
          if not c.settings then c.settings = {} end
          if not c.settings.python then c.settings.python = {} end
          c.settings.python.pythonPath = vim.fn.exepath "python"
        end,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
              diagnosticSeverityOverrides = {
                reportUnusedImport = "information",
                reportUnusedFunction = "information",
                reportUnusedVariable = "information",
                reportGeneralTypeIssues = "none",
                reportOptionalMemberAccess = "none",
                reportOptionalSubscript = "none",
                reportPrivateImportUsage = "none",
              },
            },
          },
        },
      },
      tailwindcss = {
        root_dir = function(fname)
          local root_pattern = require("lspconfig").util.root_pattern

          local root = root_pattern(
            "tailwind.config.mjs",
            "tailwind.config.cjs",
            "tailwind.config.js",
            "tailwind.config.ts",
            "postcss.config.js",
            "config/tailwind.config.js",
            "assets/tailwind.config.js"
          )(fname)

          if not root then
            local package_root = root_pattern "package.json"(fname)
            if package_root then
              local package_data = shared.decode_json_file(package_root .. "/package.json")
              if
                package_data
                and (
                  shared.has_nested_key(package_data, "dependencies", "tailwindcss")
                  or shared.has_nested_key(package_data, "devDependencies", "tailwindcss")
                )
              then
                root = package_root
              end
            end
          end

          return root
        end,
      },
    },
  },
}
