---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Core editing and UI enhancements
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.recipes.vscode" },

  -- AI and code assistance
  { import = "astrocommunity.completion.copilot-vim-cmp" },
  { import = "astrocommunity.editing-support.copilotchat-nvim" },

  -- Advanced editing support
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.motion.mini-move" },

  -- Search and navigation
  { import = "astrocommunity.fuzzy-finder.snacks-picker" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.recipes.picker-lsp-mappings" },
  { import = "astrocommunity.search.grug-far-nvim" },

  -- LSP and code quality
  { import = "astrocommunity.lsp.nvim-lint" },

  -- Language packs
  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.golangci-lint" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.yaml" },

  -- Database
  { import = "astrocommunity.pack.full-dadbod" },

  -- Terminal integration
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
}
