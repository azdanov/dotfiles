local shared = require('shared')

local lsp_rooter, prettierrc_rooter

local function has_prettier(bufnr)
  if type(bufnr) ~= "number" then bufnr = vim.api.nvim_get_current_buf() end

  local rooter = require "astrocore.rooter"
  local astrocore = require "astrocore"

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

  for _, root in ipairs(astrocore.list_insert_unique(lsp_rooter(bufnr), { vim.fn.getcwd() })) do
    local package_json = shared.decode_json_file(root .. "/package.json")
    if
      package_json
      and (
        shared.has_nested_key(package_json, "dependencies", "prettier")
        or shared.has_nested_key(package_json, "devDependencies", "prettier")
      )
    then
      return true
    end
  end

  return next(prettierrc_rooter(bufnr)) ~= nil
end

local conform_formatter = function(bufnr) return has_prettier(bufnr) and { "prettierd" } or {} end

---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = "User AstroFile",
  cmd = "ConformInfo",
  dependencies = {
    "williamboman/mason.nvim",
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        formatting = {
          disabled = true,
        },
      },
    },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = { opt = { formatexpr = "v:lua.require'conform'.formatexpr()" } },
        commands = {
          Format = {
            function(args)
              local range = nil
              if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                  start = { args.line1, 0 },
                  ["end"] = { args.line2, end_line:len() },
                }
              end
              require("conform").format { async = true, range = range }
            end,
            desc = "Format buffer",
            range = true,
          },
        },
        mappings = {
          n = {
            ["<Leader>lf"] = { function() vim.cmd.Format() end, desc = "Format buffer" },
            ["<Leader>lI"] = { function() vim.cmd.ConformInfo() end, desc = "Conform information" },
            ["<Leader>uf"] = {
              function()
                if vim.b.autoformat == nil then
                  if vim.g.autoformat == nil then vim.g.autoformat = true end
                  vim.b.autoformat = vim.g.autoformat
                end
                vim.b.autoformat = not vim.b.autoformat
                require("astrocore").notify(
                  string.format("Buffer autoformatting %s", vim.b.autoformat and "on" or "off")
                )
              end,
              desc = "Toggle autoformatting (buffer)",
            },
            ["<Leader>uF"] = {
              function()
                if vim.g.autoformat == nil then vim.g.autoformat = true end
                vim.g.autoformat = not vim.g.autoformat
                vim.b.autoformat = nil
                require("astrocore").notify(
                  string.format("Global autoformatting %s", vim.g.autoformat and "on" or "off")
                )
              end,
              desc = "Toggle autoformatting (global)",
            },
          },
        },
      },
    },
  },
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt", "shellcheck" },
      fish = { "fish_indent" },
      css = { "prettierd" },
      scss = { "prettierd" },
      less = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      python = { "isort", "black" },
      go = { "goimports", lsp_format = "last" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      ["markdown.mdx"] = { "prettierd" },
      ["yaml.docker-compose"] = { "prettierd" },
      javascript = conform_formatter,
      javascriptreact = conform_formatter,
      typescript = conform_formatter,
      typescriptreact = conform_formatter,
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function(bufnr)
      if vim.g.autoformat == nil then vim.g.autoformat = true end
      local autoformat = vim.b[bufnr].autoformat
      if autoformat == nil then autoformat = vim.g.autoformat end
      if autoformat then return { timeout_ms = 2000 } end
    end,
  },
}
