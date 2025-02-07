-- helper function to setup a plugin without an `ensure_installed` table
local setup_without_ensure_installed = function(main, opts)
  opts = vim.deepcopy(opts)
  opts.ensure_installed = nil
  require(main).setup(opts)
end

---@type LazySpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  cmd = {
    "MasonToolsInstall",
    "MasonToolsInstallSync",
    "MasonToolsUpdate",
    "MasonToolsUpdateSync",
    "MasonToolsClean",
  },
  init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      -- LSP servers
      "basedpyright",
      "bash-language-server",
      "css-lsp",
      "docker-compose-language-service",
      "dockerfile-language-server",
      "eslint-lsp",
      "gopls",
      "html-lsp",
      "json-lsp",
      "lemminx",
      "lua-language-server",
      "marksman",
      "mdx-analyzer",
      "tailwindcss-language-server",
      "taplo",
      "vtsls",
      "vue-language-server",
      "yaml-language-server",
      -- Linters
      "hadolint",
      "selene",
      "shellcheck",
      -- Formatters
      "black",
      "goimports",
      "gomodifytags",
      "gotests",
      "iferr",
      "impl",
      "isort",
      "prettierd",
      "shfmt",
      "stylua",
    },
    integrations = {
      ["mason-lspconfig"] = false,
      ["mason-null-ls"] = false,
      ["mason-nvim-dap"] = false,
    },
  },
  config = function(_, opts)
    local mason_tool_installer = require "mason-tool-installer"
    mason_tool_installer.setup(opts)
    if opts.run_on_start ~= false then mason_tool_installer.run_on_start() end
  end,
  dependencies = {
    "williamboman/mason.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      config = function(_, opts) setup_without_ensure_installed("mason-lspconfig", opts) end,
    },
    { "jay-babu/mason-nvim-dap.nvim", enabled = false, optional = true },
    { "jay-babu/mason-null-ls.nvim", enabled = false, optional = true },
    { "nvimtools/none-ls.nvim", enabled = false, optional = true },
  },
}
