-- https://github.com/stevearc/quicker.nvim
return {
  'stevearc/quicker.nvim',
  event = 'VeryLazy',
  opts = {
    -- Quickfix buffer keymaps
    keys = {
      {
        '>',
        function()
          require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse quickfix context',
      },
    },
  },
  keys = {
    {
      '<leader>q',
      function()
        require('quicker').toggle()
      end,
      desc = 'Toggle [Q]uickfix',
    },
    {
      '<leader>l',
      function()
        require('quicker').toggle({ loclist = true })
      end,
      desc = 'Toggle [L]oclist',
    },
  },
}
