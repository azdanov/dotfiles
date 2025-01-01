-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.snacks_animate = false
end

vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
    gohtml = "gotmpl",
    gohtmltmpl = "gotmpl",
    gotexttmpl = "gotmpl",
    tmpl = "gotmpl",
  },
})
