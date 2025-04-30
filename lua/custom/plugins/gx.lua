-- https://github.com/chrishrb/gx.nvim
return {
  'chrishrb/gx.nvim',
  keys = { { '<space>u', '<cmd>Browse<cr>', mode = { 'n', 'x' }, desc = '[U]ri Open' } },
  cmd = { 'Browse' },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Required for Neovim < 0.10.0
  config = true, -- default settings
  submodules = false, -- not needed, submodules are required only for tests
}
