---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "tailwindcss-language-server" })
    end,
    dependencies = {
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          config = {
            tailwindcss = {
              root_dir = function(fname)
                local root_pattern = require("lspconfig").util.root_pattern(
                  "tailwind.config.mjs",
                  "tailwind.config.cjs",
                  "tailwind.config.js",
                  "tailwind.config.ts",
                  "postcss.config.js",
                  "config/tailwind.config.js",
                  "assets/tailwind.config.js"
                )
                return root_pattern(fname)
              end,
            },
          },
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "js-everts/cmp-tailwind-colors", opts = {} },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if item.kind == "Color" then
          item = require("cmp-tailwind-colors").format(entry, item)
          if item.kind == "Color" then return format_kinds(entry, item) end
          return item
        end
        return format_kinds(entry, item)
      end
    end,
  },
}
