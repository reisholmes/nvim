-- Clipboard (deferred to avoid startup cost)
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Display
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

-- Folding (UFO)
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'marker'

-- Indentation
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Mouse
vim.opt.mouse = 'a'

-- Persistence
vim.opt.confirm = true
vim.opt.undofile = true

-- Scrolling
vim.opt.scrolloff = 10

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Timing
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
