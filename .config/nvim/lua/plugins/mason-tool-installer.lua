--- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/mason-tool-installer.lua
---@type LazySpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      -- Language Servers
      "astro-language-server",
      "bash-language-server",
      "clangd",
      "css-lsp",
      "docker-compose-language-service",
      "dockerfile-language-server",
      "eslint-lsp",
      "fish-lsp",
      "gopls",
      "html-lsp",
      "jdtls",
      "json-lsp",
      "kotlin-language-server",
      "lemminx",
      "lua-language-server",
      "marksman",
      "mdx-analyzer",
      "ruff",
      "sonarlint-language-server",
      "svelte-language-server",
      "sqruff",
      "tailwindcss-language-server",
      "taplo",
      "typos-lsp",
      "vtsls",
      "vue-language-server",
      "yaml-language-server",

      -- Linters
      "hadolint",
      "ktlint",
      "selene",
      "shellcheck",

      -- Formatters
      "google-java-format",
      "prettierd",
      "shfmt",
      "stylua",

      -- Debuggers
      "bash-debug-adapter",
      "codelldb",
      "debugpy",
      "delve",
      "java-debug-adapter",
      "js-debug-adapter",
      "kotlin-debug-adapter",

      -- Other Tools
      "java-test",
      "tree-sitter-cli",
    },
    integrations = {
      ["mason-lspconfig"] = false,
      ["mason-nvim-dap"] = false,
    },
  },
}
