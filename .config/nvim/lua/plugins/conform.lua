--- https://github.com/stevearc/conform.nvim
---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = "User AstroFile",
  cmd = "ConformInfo",
  dependencies = {
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

    local prettier_fts = {
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
      "markdown",
      "scss",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
      "yaml",
    }

    opts.formatters_by_ft = {
      dockerfile = { "dockerfmt" },
      fish = { "fish_indent" },
      java = { "google-java-format" },
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      rust = { "rustfmt" },
      sh = { "shfmt", "shellcheck" },
      sql = { "sqlfluff" },
      toml = { "taplo" },
      zsh = { "shfmt", "shellcheck" },
      ["_"] = function(bufnr)
        local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/formatting" }
        if #clients > 0 then return { lsp_format = "last" } end
        if buf_utils.is_valid(bufnr) and buf_utils.has_filetype(bufnr) then
          return { "trim_whitespace", "trim_newlines", "squeeze_blanks" }
        end
        return {}
      end,
    }

    for _, ft in ipairs(prettier_fts) do
      opts.formatters_by_ft[ft] = { "prettier" }
    end

    opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
      prettier = { require_cwd = false },
    })
  end,
  specs = {
    { "AstroNvim/astrolsp", opts = { formatting = { disabled = true } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local function get_autoformat_global()
          if vim.g.autoformat == nil then vim.g.autoformat = true end
          return vim.g.autoformat
        end

        local function toggle_buffer_autoformat()
          if vim.b.autoformat == nil then vim.b.autoformat = get_autoformat_global() end
          vim.b.autoformat = not vim.b.autoformat
          require("astrocore").notify(string.format("Buffer autoformatting %s", vim.b.autoformat and "on" or "off"))
        end

        local function toggle_global_autoformat()
          vim.g.autoformat = not get_autoformat_global()
          vim.b.autoformat = nil
          require("astrocore").notify(string.format("Global autoformatting %s", vim.g.autoformat and "on" or "off"))
        end

        return vim.tbl_deep_extend("force", opts, {
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
              ["<Leader>uf"] = { toggle_buffer_autoformat, desc = "Toggle autoformatting (buffer)" },
              ["<Leader>uF"] = { toggle_global_autoformat, desc = "Toggle autoformatting (global)" },
            },
          },
        })
      end,
    },
  },
}
