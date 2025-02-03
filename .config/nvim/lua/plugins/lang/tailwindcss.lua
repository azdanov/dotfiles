---@type LazySpec
return {
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
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "tailwindcss-language-server" })
    end,
  },
}
