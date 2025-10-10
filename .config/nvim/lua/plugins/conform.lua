--- https://github.com/stevearc/conform.nvim
---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = "User AstroFile",
  cmd = "ConformInfo",
  dependencies = {
    "williamboman/mason.nvim",
    { "nvimtools/none-ls.nvim", optional = true, enabled = false },
  },
  ---@param opts conform.setupOpts
  opts = function(_, opts)
    local buf_utils = require "astrocore.buffer"
    opts.default_format_opts = { lsp_format = "fallback" }

    opts.format_on_save = function(bufnr)
      if vim.g.autoformat == nil then vim.g.autoformat = true end
      local autoformat = vim.b[bufnr].autoformat
      if autoformat == nil then autoformat = vim.g.autoformat end
      if autoformat then return { timeout_ms = 2000 } end
    end

    opts.formatters_by_ft = {
      -- ["*"] = function(bufnr)
      --   return buf_utils.is_valid(bufnr) and buf_utils.has_filetype(bufnr) and { "injected" } or {}
      -- end,
      dockerfile = { "dockerfmt" },
      fish = { "fish_indent" },
      java = { "google-java-format" },
      python = { "ruff" },
      rust = { "rustfmt" },
      sh = { "shfmt", "shellcheck" },
      sql = { "sqruff" },
      toml = { "taplo" },
      zsh = { "shfmt", "shellcheck" },
      ["_"] = function(bufnr)
        if #vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/formatting" } then
          return { lsp_format = "last" }
        elseif buf_utils.is_valid(bufnr) and buf_utils.has_filetype(bufnr) then
          return { "trim_whitespace", "trim_newlines", "squeeze_blanks" }
        end
        return {}
      end,
    }

    vim.tbl_map(function(ft) opts.formatters_by_ft[ft] = { "prettier" } end, {
      "astro",
      "css",
      "graphql",
      "handlebars",
      "html",
      "htmlangular",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "less",
      "less",
      "markdown",
      "markdown.mdx",
      "scss",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
      "yaml",
      "yaml.docker-compose",
    })
  end,
  specs = {
    { "AstroNvim/astrolsp", opts = { formatting = { disabled = true } } },
    {
      "AstroNvim/astrocore",
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
}
