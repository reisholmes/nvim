-- https://github.com/f-person/git-blame.nvim
return {
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>gb', '<cmd>GitBlameToggle<cr>', desc = '[G]it [B]lame' },
  },
  opts = {
    enabled = false, -- Start disabled, toggle on with <leader>gb
    -- Keep virtual text enabled for toggle functionality
    -- Priority set lower than diagnostics (diagnostics use 100)
    message_template = ' <author> • <date> • <summary>',
    date_format = '%r',
    virtual_text_column = nil, -- Display at end of line
    highlight_group = 'Comment',
    delay = 200,
    -- Set extmark priority lower than diagnostics (diagnostics use 100)
    set_extmark_options = {
      priority = 50,
    },
  },
}
