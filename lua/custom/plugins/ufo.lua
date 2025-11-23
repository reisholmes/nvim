-- https://github.com/kevinhwang91/nvim-ufo
return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  event = 'VeryLazy',
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
    { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    {
      'zk',
      function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      desc = 'Peek fold or hover',
    },
  },
  config = function()
    require('ufo').setup({
      preview = {
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
        win_config = {
          maxheight = 20,
        },
      },
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    })
  end,
}
