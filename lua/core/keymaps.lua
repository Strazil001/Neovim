local vim = vim

vim.g.mapleader = " "

-- Escape to normal mode the easy way
vim.keymap.set("i", "jk", "<Esc>")

-- Move selected lines in visual mode up or down, awesome!
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Tabline
vim.keymap.set("n", "<A-n>", ":TablineBufferNext<CR>", { silent = true })
vim.keymap.set("n", "<A-m>", ":TablineBufferPrevious<CR>", { silent = true })

-- Window hopping wit Ctrl
vim.keymap.set("n", "<C-h>", "<C-w>h<CR>")
vim.keymap.set("n", "<C-j>", "<C-w>j<CR>")
vim.keymap.set("n", "<C-k>", "<C-w>k<CR>")
vim.keymap.set("n", "<C-l>", "<C-w>l<CR>")

-- split windows
vim.keymap.set("n", "<leader>sv", ":vs<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
vim.keymap.set("n", "<leader>sc", ":wq<CR>")

-- Netrw
vim.keymap.set("n", "<leader>pv", ":Explore<CR>")

-- Inline hints
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })

-- Open horizontal terminal
-- vim.keymap.set("n", "<leader>th", ":below 18 sp<CR>:term<CR>i", { silent = true })
-- vim.keymap.set("t", "<leader>tc", "exit<CR>", { silent = true })

vim.keymap.set("n", "<leader>cn", ":below 18 sp<CR>:term<CR>ig++ std=c++2a -o ", { silent = true })
vim.keymap.set("n", "<leader>cp", ":below 18 sp<CR>:term<CR>ig++ -o ", { silent = true })

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste from clipboard
vim.keymap.set("x", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')

-- Yank from clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Change all occurences using find and replace under cursor.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Set file executable.
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
