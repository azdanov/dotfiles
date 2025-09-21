--- https://github.com/mfussenegger/nvim-jdtls
---@type LazySpec
return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  opts = function(_, opts)
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
    vim.fn.mkdir(workspace_dir, "p")

    local extendedClientCapabilities = require("astrocore").extend_tbl(require "jdtls.capabilities", {
      onCompletionItemSelectedCommand = "editor.action.triggerParameterHints",
      resolveAdditionalTextEditsSupport = true,
      workspace = { configuration = true },
      textDocument = { completion = { completionItem = { snippetSupport = true } } },
    })

    return require("astrocore").extend_tbl(opts, {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-XX:+UseTransparentHugePages",
        "-XX:+AlwaysPreTouch",
        "-Xmx2g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. vim.fn.expand "$MASON/share/jdtls/lombok.jar",
        "-jar",
        vim.fn.expand "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
        "-configuration",
        vim.fn.expand "$MASON/share/jdtls/config",
        "-data",
        workspace_dir,
      },
      root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
      flags = { allow_incremental_sync = true, server_side_fuzzy_completion = true },
      capabilities = require("astrolsp").config.config["*"].capabilities,
      settings = {
        java = {
          format = { enabled = false },
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          codeGeneration = {
            toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
            hashCodeEquals = { useJava7Objects = true, useInstanceOf = true },
            generateComments = true,
            useBlocks = true,
            addFinalForNewDeclaration = "fields",
          },
          completion = {
            favoriteStaticMembers = {
              "org.assertj.core.api.Assertions.assertThat",
              "org.assertj.core.api.Assertions.assertThatThrownBy",
              "org.assertj.core.api.Assertions.catchThrowable",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.mock",
              "org.mockito.Mockito.when",
            },
          },
          eclipse = { downloadSources = true },
          configuration = { updateBuildConfiguration = "interactive" },
          maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          inlayHints = { parameterNames = { enabled = "all" } },
          sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
        },
      },
      initOptions = {
        workspace = workspace_dir,
        bundles = {
          vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
          unpack(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
        },
        extendedClientCapabilities = extendedClientCapabilities,
      },
      handlers = {
        ["language/status"] = function() end,
      },
      filetypes = { "java" },
      on_attach = function(...)
        require("jdtls").setup_dap { hotcodereplace = "auto", config_overrides = {} }
        require("astrolsp").on_attach(...)
      end,
    })
  end,
  config = function(_, opts)
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "java",
      callback = function() require("jdtls").start_or_attach(opts) end,
    })
    vim.api.nvim_create_autocmd("LspAttach", {
      pattern = "java",
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "jdtls" then require("jdtls.dap").setup_dap_main_class_configs() end
      end,
    })
  end,
}
