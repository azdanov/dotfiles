if vim.g.neovide then vim.g.neovide_hide_mouse_when_typing = true end

vim.treesitter.language.register("scss", "less")
vim.treesitter.language.register("scss", "postcss")
