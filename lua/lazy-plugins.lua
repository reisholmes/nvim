-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Core editing
  require('kickstart.plugins.autopairs'),
  require('kickstart.plugins.guess-indent'),
  -- require('kickstart.plugins.indent_line'), -- Replaced by snacks.indent
  require('kickstart.plugins.treesitter'),

  -- LSP and completion
  require('kickstart.plugins.blink-cmp'),
  require('kickstart.plugins.lspconfig'),

  -- Code quality
  require('kickstart.plugins.conform'),
  require('kickstart.plugins.lint'),

  -- Git integration
  require('kickstart.plugins.gitsigns'),

  -- UI and navigation
  require('kickstart.plugins.mini'),
  require('kickstart.plugins.telescope'),
  require('kickstart.plugins.todo-comments'),
  require('kickstart.plugins.which-key'),

  -- Optional plugins (uncomment to enable)
  -- require 'kickstart.plugins.debug',      -- DAP debugging support
  require('kickstart.plugins.neo-tree'), -- Alternative file explorer

  -- Custom plugins from lua/custom/plugins/*.lua
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, { ---@diagnostic disable-line: missing-fields
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
