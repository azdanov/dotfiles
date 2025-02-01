local function decode_json(filename)
  local file = io.open(filename, "r")
  if not file then
    return false -- File doesn't exist or cannot be opened
  end

  local content = file:read "*all"
  file:close()

  local json_parsed, json = pcall(vim.fn.json_decode, content)
  if not json_parsed or type(json) ~= "table" then return false end
  return json
end

local format_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

local function check_json_key_exists(json, ...) return vim.tbl_get(json, ...) ~= nil end
local lsp_rooter, prettierrc_rooter
local has_prettier = function(bufnr)
  if type(bufnr) ~= "number" then bufnr = vim.api.nvim_get_current_buf() end
  local rooter = require "astrocore.rooter"
  if not lsp_rooter then
    lsp_rooter = rooter.resolve("lsp", {
      ignore = {
        servers = function(client)
          return not vim.tbl_contains({ "eslint", "ts_ls", "typescript-tools", "volar", "vtsls" }, client.name)
        end,
      },
    })
  end
  if not prettierrc_rooter then
    prettierrc_rooter = rooter.resolve {
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.yml",
      ".prettierrc.yaml",
      ".prettierrc.json5",
      ".prettierrc.js",
      ".prettierrc.cjs",
      "prettier.config.js",
      ".prettierrc.mjs",
      "prettier.config.mjs",
      "prettier.config.cjs",
      ".prettierrc.toml",
    }
  end
  local prettier_dependency = false
  for _, root in ipairs(require("astrocore").list_insert_unique(lsp_rooter(bufnr), { vim.fn.getcwd() })) do
    local package_json = decode_json(root .. "/package.json")
    if
      package_json
      and (
        check_json_key_exists(package_json, "dependencies", "prettier")
        or check_json_key_exists(package_json, "devDependencies", "prettier")
      )
    then
      prettier_dependency = true
      break
    end
  end
  return prettier_dependency or next(prettierrc_rooter(bufnr))
end

local conform_formatter = function(bufnr) return has_prettier(bufnr) and { "prettierd" } or {} end

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "javascript", "typescript", "tsx", "jsdoc" })
      end
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      autocmds = {
        eslint_fix_on_save = {
          cond = function(client) return client.name == "eslint" and vim.fn.exists ":EslintFixAll" > 0 end,
          {
            event = "BufWritePost",
            desc = "Fix all eslint errors",
            callback = function() vim.cmd.EslintFixAll() end,
          },
        },
      },
      ---@diagnostic disable: missing-fields
      config = {
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
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      if not opts.formatters_by_ft then opts.formatters_by_ft = {} end
      for _, filetype in ipairs(format_filetypes) do
        opts.formatters_by_ft[filetype] = conform_formatter
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "vtsls", "eslint-lsp", "prettierd", "js-debug-adapter" }
      )
    end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  },
  {
    "yioneko/nvim-vtsls",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
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
    config = function(_, opts) require("vtsls").config(opts) end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { { "nvim-neotest/neotest-jest", config = function() end } },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-jest"(require("astrocore").plugin_opts "neotest-jest"))
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require "dap"
      if not dap.adapters["pwa-node"] then
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      if not dap.adapters.node then
        dap.adapters.node = function(cb, config)
          if config.type == "node" then config.type = "pwa-node" end
          local pwa_adapter = dap.adapters["pwa-node"]
          if type(pwa_adapter) == "function" then
            pwa_adapter(cb, config)
          else
            cb(pwa_adapter)
          end
        end
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then dap.configurations[language] = js_config end
      end

      local vscode_filetypes = require("dap.ext.vscode").type_to_filetypes
      vscode_filetypes["node"] = js_filetypes
      vscode_filetypes["pwa-node"] = js_filetypes
    end,
  },
}
