local analyzers_path = vim.fn.stdpath "data" .. "/mason/packages/sonarlint-language-server/extension/analyzers/"

---@see https://github.com/iamkarasik/sonarqube.nvim
---@type LazySpec
return {
  "iamkarasik/sonarqube.nvim",
  event = "User AstroFile",
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
