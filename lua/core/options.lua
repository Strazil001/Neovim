local g = vim.g     -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

g.mapleader = " "

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.netrw_liststyle = 3

opt.cursorline = true
--vim.opt.colorcolumn = "80"

opt.nu = true
opt.relativenumber = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = false

opt.showmode = false

opt.smartindent = true

opt.wrap = false

opt.spell = false

opt.swapfile = false
opt.backup = false

opt.termguicolors = true

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 15
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.foldmethod = "marker"

opt.cmdheight = 1

opt.updatetime = 50
g.tmux_navigator_save_on_switch = 2
