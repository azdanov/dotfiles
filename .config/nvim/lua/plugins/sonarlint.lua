local analyzers_path = vim.fn.stdpath "data" .. "/mason/packages/sonarlint-language-server/extension/analyzers/"
local filetypes = {
  "c",
  "cpp",
  "dockerfile",
  "java",
  "javascript",
  "javascriptreact",
  "php",
  "python",
  "typescript",
  "typescriptreact",
  "vue",
}

--- https://gitlab.com/schrieveslaach/sonarlint.nvim
---@type LazySpec
return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  ft = filetypes,
  opts = {
    server = {
      capabilities = vim.lsp.config["*"].capabilities,
      cmd = {
        "sonarlint-language-server",
        "-stdio",
        "-analyzers",
        -- Need manual installation for cfamily: https://docs.sonarsource.com/sonarqube-for-vs-code/getting-started/offline-installation#performing-the-offline-installation
        analyzers_path .. "sonarcfamily.jar",
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
      settings = {
        sonarlint = {
          rules = {
            ["typescript:S6759"] = { level = "off" },
          },
        },
      },
    },
    filetypes = filetypes,
  },
}
