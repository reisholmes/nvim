-- Basic Keymaps
local kmset = vim.keymap.set

-- Which-key group definitions
local wk = require('which-key')
wk.add({
  { '<leader>b', group = '[B]uffers' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>l', group = '[L]azy[G]it' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>T', group = '[T]rouble' },
  { 'gp', group = '[G]oto [P]review' },
  -- 0.12 built-in LSP mappings (for which-key discoverability)
  { 'grn', desc = 'LSP: Rename' },
  { 'gra', desc = 'LSP: Code Action' },
  { 'grx', desc = 'LSP: Code Lens' },
})

kmset('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Built-in undotree (0.12)
vim.cmd.packadd('nvim.undotree')
kmset('n', '<leader>tu', '<cmd>Undotree<CR>', { desc = '[T]oggle [U]ndotree' })

-- Diagnostic Config (single source of truth)
-- tiny-inline-diagnostic.lua overrides virtual_text = false on LspAttach
vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.ERROR } },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = true,
  virtual_lines = false,
  jump = { float = true },
})

-- Terminal
kmset('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
kmset('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
kmset('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
kmset('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
kmset('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Clipboard
kmset('n', '<leader>Y', '"+yg_', { desc = '[Y]ank to last non-blank char into clipboard' })
kmset('n', '<leader>y', '"+y', { desc = '[Y]ank into clipboard' })
kmset('n', '<leader>yy', '"+yy', { desc = '[Y]ank line into clipboard' })
kmset('v', '<leader>y', '"+y', { desc = '[Y]ank into clipboard' })
kmset('n', '<leader>P', '"+P', { desc = '[P]aste from clipboard' })
kmset('x', '<leader>p', [["_dP]], { desc = '[P]aste but keep word in buffer' })
kmset({ 'n', 'v' }, '<leader>D', [["_d]], { desc = "[D]elete to void register" })

-- Move selected lines in visual mode
kmset('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'move selection up' })
kmset('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection down' })

-- Keep cursor centered
kmset('n', '<C-d>', '<C-d>zz')
kmset('n', '<C-u>', '<C-u>zz')
kmset('n', 'n', 'nzzzv')
kmset('n', 'N', 'Nzzzv')

-- Buffer manipulation
kmset('n', '<leader>bd', '<cmd>bd<cr>', { desc = '[B]uffer Delete' })
kmset('n', '<leader>b0', '<cmd>bfirst<cr>', { desc = '[B]uffer First' })
kmset('n', '<leader>b$', '<cmd>blast<cr>', { desc = '[B]uffer Last' })
kmset('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer Next' })
kmset('n', '<leader>bN', '<cmd>bprevious<cr>', { desc = '[B]uffer Previous' })

-- Mini.files
kmset('n', '<leader>f', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>', { desc = '[F]ile tree' })
