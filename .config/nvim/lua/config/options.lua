-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.neovide then
  vim.o.guifont = "MonoLisa Medium,Symbols Nerd Font:h34"
  vim.g.neovide_scale_factor = 0.4
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.snacks_animate = false
end
