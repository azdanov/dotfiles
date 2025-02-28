---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Core editing and UI enhancements
  { import = "astrocommunity.color.nvim-highlight-colors" },
  { import = "astrocommunity.comment.ts-comments-nvim" },
  { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.scrolling.satellite-nvim" },

  -- Advanced editing support
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.text-case-nvim" },

  -- Search and navigation
  { import = "astrocommunity.fuzzy-finder.snacks-picker" },
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.quickfix.nvim-bqf" },

  -- LSP and code quality
  { import = "astrocommunity.lsp.nvim-lint" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.programming-language-support.rest-nvim" },

  -- Language packs
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.yaml" },

  -- Database
  { import = "astrocommunity.pack.full-dadbod" },

  -- Media and special file types
  { import = "astrocommunity.media.image-nvim" },

  -- Terminal integration
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
}
