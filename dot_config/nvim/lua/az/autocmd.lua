local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

local whitespace_group = vim.api.nvim_create_augroup("RemoveWhitespace", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = whitespace_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
