require('lazy').setup({
  -- Code quality
  require('kickstart.plugins.conform'),
  require('kickstart.plugins.lint'),

  -- Core editing
  require('kickstart.plugins.autopairs'),
  require('kickstart.plugins.guess-indent'),
  require('kickstart.plugins.treesitter'),

  -- Git
  require('kickstart.plugins.gitsigns'),

  -- LSP and completion
  require('kickstart.plugins.blink-cmp'),
  require('kickstart.plugins.lspconfig'),

  -- UI and navigation
  require('kickstart.plugins.mini'),
  require('kickstart.plugins.neo-tree'),
  require('kickstart.plugins.telescope'),
  require('kickstart.plugins.todo-comments'),
  require('kickstart.plugins.which-key'),

  -- Custom plugins
  { import = 'custom.plugins' },
}, {
  ui = {
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
