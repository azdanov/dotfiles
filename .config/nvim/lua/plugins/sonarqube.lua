local analyzers_path = vim.fn.stdpath "data" .. "/mason/packages/sonarlint-language-server/extension/analyzers/"

---@type LazySpec
return {
  "iamkarasik/sonarqube.nvim",
  specs = {
    {
      "williamboman/mason-lspconfig.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "sonarlint-language-server" })
      end,
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      optional = true,
      opts = function(_, opts)
        local astrocore = require "astrocore"
        opts.ensure_installed = astrocore.list_insert_unique(opts.ensure_installed, { "sonarlint-language-server" })
      end,
    },
  },
  opts = {
    lsp = {
      cmd = {
        "sonarlint-language-server",
        "-stdio",
        "-analyzers",
        analyzers_path .. "sonargo.jar",
        analyzers_path .. "sonarhtml.jar",
        analyzers_path .. "sonariac.jar",
        analyzers_path .. "sonarjava.jar",
        analyzers_path .. "sonarjavasymbolicexecution.jar",
        analyzers_path .. "sonarjs.jar",
        analyzers_path .. "sonarphp.jar",
        analyzers_path .. "sonarpython.jar",
        analyzers_path .. "sonarxml.jar",
      },
    },
    rules = {
      -- React props should be read-only
      ["typescript:S6759"] = { enabled = false },
    },
  },
}
