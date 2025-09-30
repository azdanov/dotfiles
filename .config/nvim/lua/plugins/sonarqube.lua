local analyzers_path = vim.fn.stdpath "data" .. "/mason/packages/sonarlint-language-server/extension/analyzers/"

--- https://github.com/iamkarasik/sonarqube.nvim
---@type LazySpec
return {
  "iamkarasik/sonarqube.nvim",
  ft = { "c", "cpp", "css", "dockerfile", "html", "java", "javascript", "php", "python", "typescript" },
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
      capabilities = vim.lsp.config["*"].capabilities,
    },
    rules = {
      -- React props should be read-only
      ["typescript:S6759"] = { enabled = false },
      -- Nullish coalescing should be preferred
      ["typescript:S6606"] = { enabled = false },
      -- Console output should not be used
      ["java:S106"] = { enabled = false },
    },
  },
}
