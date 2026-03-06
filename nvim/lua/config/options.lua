local opt = vim.opt

opt.cursorline = true
opt.number = true
opt.termguicolors = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Display
vim.wo.wrap = false

-- Set Leader before anything else loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "
