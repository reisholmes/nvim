-- https://github.com/sindrets/diffview.nvim
return {
  'sindrets/diffview.nvim',
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewRefresh',
    'DiffviewFileHistory',
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff View' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it File [H]istory' },
  },
}
