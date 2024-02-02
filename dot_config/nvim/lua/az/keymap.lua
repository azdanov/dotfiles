vim.g.mapleader = " "

vim.keymap.set("n", "<leader>fe", ":Explore<CR>", { desc = "Explore" })

vim.keymap.set({ "n", "x" }, "<leader>rp", [["_dP]], { desc = "Paste over selected text" })
vim.keymap.set({ "n", "x" }, "<leader>ry", [["+y]], { desc = "Yank into the clipboard" })
vim.keymap.set("n", "<leader>rY", [["+Y]], { desc = "Yank whole line into the clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>rd", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected block down" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected block up" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>", { desc = "Next item in the quickfix list" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>", { desc = "Previous item in the quickfix list" })

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>", { desc = "Next item in the location list" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>", { desc = "Previous item in the location list" })
