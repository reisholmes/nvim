-- https://github.com/folke/trouble.nvim
return {
  'folke/trouble.nvim',
  opts = {
    auto_preview = true, -- Automatically show preview when hovering over items
    auto_refresh = true, -- Auto-update while open
    auto_close = false, -- Keep window open even when empty
    focus = true, -- Focus the Trouble window when opened
    indent_guides = true, -- Show hierarchy indentation
    max_items = 200, -- Limit items shown
    multiline = true, -- Support multi-line messages
  },
  cmd = 'Trouble',
  config = function(_, opts)
    require('trouble').setup(opts)

    -- Auto-open Trouble when quickfix is populated
    vim.api.nvim_create_autocmd('QuickFixCmdPost', {
      group = vim.api.nvim_create_augroup('TroubleQuickfix', { clear = true }),
      callback = function()
        vim.cmd('Trouble qflist open')
      end,
    })
  end,
  keys = {
    {
      '<leader>Txx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>TxX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>Tcs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>Tcl',
      '<cmd>Trouble lsp toggle win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>Tcd',
      '<cmd>Trouble lsp_definitions toggle<cr>',
      desc = 'LSP Definitions (Trouble)',
    },
    {
      '<leader>Tcr',
      '<cmd>Trouble lsp_references toggle<cr>',
      desc = 'LSP References (Trouble)',
    },
    {
      '<leader>Tci',
      '<cmd>Trouble lsp_implementations toggle<cr>',
      desc = 'LSP Implementations (Trouble)',
    },
    {
      '<leader>Tct',
      '<cmd>Trouble lsp_type_definitions toggle<cr>',
      desc = 'LSP Type Definitions (Trouble)',
    },
    {
      '<leader>TcI',
      '<cmd>Trouble lsp_incoming_calls toggle<cr>',
      desc = 'LSP Incoming Calls (Trouble)',
    },
    {
      '<leader>TcO',
      '<cmd>Trouble lsp_outgoing_calls toggle<cr>',
      desc = 'LSP Outgoing Calls (Trouble)',
    },
    {
      '<leader>TxL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>TxQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '<leader>Txt',
      '<cmd>Trouble telescope toggle<cr>',
      desc = 'Telescope Results (Trouble)',
    },
    {
      ']t',
      function()
        require('trouble').next({ skip_groups = true, jump = true })
      end,
      desc = 'Next Trouble Item',
    },
    {
      '[t',
      function()
        require('trouble').prev({ skip_groups = true, jump = true })
      end,
      desc = 'Previous Trouble Item',
    },
  },
}
