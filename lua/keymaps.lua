-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local kmset = vim.keymap.set -- Variable for keymap setting

-- Which-key group definitions
local wk = require('which-key')
wk.add({
  { '<leader>b', group = '[B]uffers' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>l', group = '[L]ua cmds & [L]azy[G]it' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>T', group = '[T]rouble' },
  { 'gp', group = '[G]oto [P]review' },
})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
kmset('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
kmset('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[Q]uickfix list open' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
kmset('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- kmset('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- kmset('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- kmset('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- kmset('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
kmset('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
kmset('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
kmset('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
kmset('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- kmset("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- kmset("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- kmset("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- kmset("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- vim: ts=2 sts=2 sw=2 et

-- Copy to Clipboard
kmset('n', '<leader>Y', '"+yg_', { desc = '[Y]ank to last non-blank char into clipboard' })
kmset('n', '<leader>y', '"+y', { desc = '[Y]ank into clipboard' })
kmset('n', '<leader>yy', '"+yy', { desc = '[Y]ank line into clipboard' })
kmset('v', '<leader>y', '"+y', { desc = '[Y]ank into clipboard' })

-- Paste from clipboard
kmset('n', '<leader>P', '"+P', { desc = '[P]aste from clipboard' })

-- Keep copied word in buffer when pasting, send overwritten word to void register
kmset('x', '<leader>p', [["_dP]], { desc = '[P]aste but keep word in buffer' })

-- Delete word to void register, don't override buffer
kmset({ 'n', 'v' }, '<leader>D', [["_d]], { desc = "[D]elete word to void register, don't override buffer" })

-- When in visual mode, allows moving highlighted lines
kmset('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'move selection up' })
kmset('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection down' })

-- Keep cursor centered when half page jumping
kmset('n', '<C-d>', '<C-d>zz')
kmset('n', '<C-u>', '<C-u>zz')

-- Keep cursor in the middle when searching
kmset('n', 'n', 'nzzzv')
kmset('n', 'N', 'Nzzzv')

-- Buffer Manipulation
kmset('n', '<leader>bd', '<cmd>bd<cr>', { desc = '[B]uffer Delete' })
kmset('n', '<leader>b0', '<cmd>bfirst<cr>', { desc = '[B]uffer First' })
kmset('n', '<leader>b$', '<cmd>blast<cr>', { desc = '[B]uffer Last' })
kmset('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer Next' })
kmset('n', '<leader>bN', '<cmd>bprevious<cr>', { desc = '[B]uffer Previous' })

-- Mini.files
kmset('n', '<leader>f', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>', { desc = '[F]ile tree' })
