---@type LazySpec
return {
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "google-java-format" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      local astrocore = require "astrocore"
      opts.ensure_installed = astrocore.list_insert_unique(opts.ensure_installed, { "google-java-format" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
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
        },
      },
    },
  },
}
