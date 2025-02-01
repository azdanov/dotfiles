---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = { filetypes = { filename = { ["docker-compose.yaml"] = "yaml.docker-compose" } } },
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        docker_compose_language_service = { init_options = { provideFormatter = false } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dockerfile" })
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "docker-compose-language-service", "dockerfile-language-server", "hadolint" }
      )
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["yaml.docker-compose"] = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        ["dockerfile"] = { "hadolint" },
      },
    },
  },
}
