return {
  'AckslD/nvim-neoclip.lua',
  dependencies = {
    -- you'll need at least one of these
    { 'nvim-telescope/telescope.nvim' },
    -- {'ibhagwan/fzf-lua'},
  },
  keys = {
    { '<leader>o', '<cmd>Telescope neoclip<cr>', desc = 'Ne[O]clip' },
  },
  config = function()
    require('neoclip').setup({
      keys = {
        telescope = {
          i = {
            paste = false, --restore telescope default <c-p> action to prev item
          },
        },
      },
    })
  end,
}
