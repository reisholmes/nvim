-- https://github.com/kevinhwang91/nvim-ufo
return {
  {
    'kevinhwang91/nvim-ufo',

    dependencies = {
      { 'kevinhwang91/promise-async' },
    },

    init = function()
      -- Options required from Docs
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Keymaps required from docs
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      vim.keymap.set('n', 'zk', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = 'Peek Fold' })

      require('ufo').setup({

        preview = {
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']',
          },
          win_config = {
            maxheight = {
              description = [[The max height of the preview window]],
              default = 20,
            },
          },
        },

        -- Specifies what kind of folding options to use
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })
    end,
  },
}
