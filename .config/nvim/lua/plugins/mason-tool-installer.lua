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
      "biome",
      "clangd",
      "css-lsp",
      "docker-language-server",
      "eslint-lsp",
      -- "fish-lsp",
      "gh-actions-language-server",
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
      "sqruff",
      "svelte-language-server",
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
      "prettier",
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
      "vscode-spring-boot-tools",
    },
  },
}
