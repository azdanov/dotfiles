local function get_mason_bundles()
  local function jars(path, pattern) return vim.split(vim.fn.glob(vim.fn.expand(path) .. "/" .. pattern), "\n") end

  local bundles = {}
  vim.list_extend(bundles, jars("$MASON/share/java-test", "*.jar"))
  vim.list_extend(bundles, jars("$MASON/share/java-debug-adapter", "com.microsoft.java.debug.plugin-*.jar"))
  vim.list_extend(bundles, jars("$MASON/share/vscode-spring-boot-tools", "jdtls/*.jar"))

  local excluded = {
    -- java-test
    "com.microsoft.java.test.runner-jar-with-dependencies.jar",
    "jacocoagent.jar",
    -- spring-boot
    "commons-lsp-extensions.jar",
    "xml-ls-extension.jar",
  }

  bundles = vim.tbl_filter(function(bundle)
    if not bundle then return false end
    local filename = vim.fn.fnamemodify(bundle, ":t")
    for _, ex in ipairs(excluded) do
      if filename == ex then return false end
    end
    return true
  end, bundles)

  return bundles
end

return {
  settings = {
    java = {
      codeGeneration = { generateComments = false, useBlocks = true },
      configuration = { updateBuildConfiguration = "automatic" },
      contentProvider = { preferred = "fernflower" },
      eclipse = { downloadSources = true },
      format = { enabled = false },
      implementationsCodeLens = { enabled = true },
      inlayHints = { parameterNames = { enabled = "all" } },
      maven = { downloadSources = true },
      referencesCodeLens = { enabled = true },
      signatureHelp = { enabled = true },
      sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
    },
  },

  init_options = {
    bundles = get_mason_bundles(),
  },
}
