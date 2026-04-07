-- Neovim config (forked from kickstart-modular.nvim)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require('options')
require('lazy-bootstrap')
require('lazy-plugins')
require('keymaps')
require('autocommands')
