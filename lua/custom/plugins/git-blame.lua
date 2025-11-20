-- https://github.com/f-person/git-blame.nvim
return {
  'f-person/git-blame.nvim',
  -- load the plugin at startup
  event = 'VeryLazy',
  opts = {
    enabled = true,
    -- Display options to avoid conflict with diagnostics
    message_template = ' <author> • <date> • <summary>',
    date_format = '%r',
    virtual_text_column = nil, -- Display at end of line
    -- Lower priority so diagnostics appear above git blame
    highlight_group = 'Comment',
    -- Add delay to avoid flickering
    delay = 200,
  },
}
