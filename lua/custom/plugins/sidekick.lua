-- https://github.com/folke/sidekick.nvim
return {
  'folke/sidekick.nvim',
  event = 'VeryLazy',
  -- Only load if user is reis.holmes on reisholmes
  cond = function()
    local username = vim.loop.os_get_passwd().username
    local hostname = vim.loop.os_gethostname()
    return username == 'reis.holmes' and hostname == 'reisholmes'
  end,
  dependencies = {
    'folke/snacks.nvim', -- already installed
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    -- Next Edit Suggestions configuration
    nes = {
      enabled = true,
      -- Automatically show suggestions
      auto = {
        enabled = true,
      },
      -- Inline diff display
      diff = {
        inline = 'words', -- can be 'words', 'chars', or false
      },
    },
    -- CLI terminal configuration for AI tools
    cli = {
      watch = true, -- auto-reload files modified by AI
      win = {
        layout = 'right', -- vertical split on the right side
        split = {
          width = 80, -- width in columns for vertical split
        },
      },
      -- Keep default tools (claude, copilot, aider, etc.)
      -- Note: GitHub Copilot chat via gh CLI doesn't support interactive chat mode
      -- Use the default 'copilot' tool if you have the standalone Copilot CLI installed
      tools = {},
    },
  },
  keys = {
    -- Next Edit Suggestions keybindings
    {
      '<tab>',
      function()
        require('sidekick').nes_jump_or_apply()
      end,
      desc = 'NES: Jump or apply suggestion',
    },
    {
      '<leader>an',
      function()
        require('sidekick').nes_jump_or_apply()
      end,
      desc = '[A]I: [N]ES jump/apply',
    },
    -- CLI Terminal keybindings
    {
      '<leader>aa',
      function()
        require('sidekick.cli').toggle()
      end,
      desc = '[A]I: Toggle CLI terminal',
    },
    {
      '<leader>as',
      function()
        require('sidekick.cli').select()
      end,
      desc = '[A]I: [S]elect CLI tool',
    },
    {
      '<leader>ac',
      function()
        require('sidekick.cli').close()
      end,
      desc = '[A]I: [C]lose CLI session',
    },
    -- Send context to AI
    {
      '<leader>at',
      function()
        require('sidekick.cli').send({ msg = '{this}' })
      end,
      mode = { 'n', 'v' },
      desc = '[A]I: Send [t]his (selection/context)',
    },
    {
      '<leader>af',
      function()
        require('sidekick.cli').send({ msg = '{file}' })
      end,
      desc = '[A]I: Send [f]ile',
    },
    {
      '<leader>ad',
      function()
        require('sidekick.cli').send({ msg = '{diagnostics}' })
      end,
      desc = '[A]I: Send [d]iagnostics',
    },
    -- Prompt templates
    {
      '<leader>ap',
      function()
        require('sidekick.cli').prompt()
      end,
      desc = '[A]I: Select [p]rompt template',
    },
  },
}
