---@see https://github.com/mfussenegger/nvim-jdtls
---@type LazySpec
return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "AstroNvim/astrolsp",
      optional = true,
      ---@type AstroLSPOpts
      opts = {
        handlers = { jdtls = false },
      },
    },
  },
  opts = function(_, opts)
    local utils = require "astrocore"

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
    vim.fn.mkdir(workspace_dir, "p")

    if not (vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1 or vim.fn.has "win32" == 1) then
      utils.notify("jdtls: Could not detect valid OS", vim.log.levels.ERROR)
    end

    return utils.extend_tbl({
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. vim.fn.expand "$MASON/share/jdtls/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.expand "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
        "-configuration",
        vim.fn.expand "$MASON/share/jdtls/config",
        "-data",
        workspace_dir,
      },
      root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
      flags = {
        allow_incremental_sync = true,
        server_side_fuzzy_completion = true,
      },
      settings = {
        java = {
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            hashCodeEquals = {
              useJava7Objects = true,
              useInstanceOf = true,
            },
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
          signatureHelp = { enabled = true },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      },
      init_options = {
        bundles = {
          vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
          -- unpack remaining bundles
          (table.unpack or unpack)(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
        },
      },
      handlers = {
        ["$/progress"] = function() end, -- disable progress updates.
      },
      filetypes = { "java" },
      on_attach = function(...)
        require("jdtls").setup_dap { hotcodereplace = "auto" }
        local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
        if astrolsp_avail then astrolsp.on_attach(...) end
      end,
    }, opts)
  end,
  config = function(_, opts)
    -- setup autocmd on filetype detect java
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "java", -- autocmd to start jdtls
      callback = function()
        if opts.root_dir and opts.root_dir ~= "" then
          require("jdtls").start_or_attach(opts)
        else
          require("astrocore").notify("jdtls: root_dir not found. Please specify a root marker", vim.log.levels.ERROR)
        end
      end,
    })
    -- create autocmd to load main class configs on LspAttach.
    -- This ensures that the LSP is fully attached.
    -- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
    vim.api.nvim_create_autocmd("LspAttach", {
      pattern = "*.java",
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- ensure that only the jdtls client is activated
        if client.name == "jdtls" then require("jdtls.dap").setup_dap_main_class_configs() end
      end,
    })
  end,
}
