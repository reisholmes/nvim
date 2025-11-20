-- https://github.com/rachartier/tiny-inline-diagnostic.nvim
return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'LspAttach', -- Load when LSP attaches
  config = function()
    -- Disable built-in virtual_text diagnostics
    -- Set high priority so diagnostics appear above other virtual text (like git-blame)
    vim.diagnostic.config {
      virtual_text = false,
      -- Increase severity so diagnostics are prioritized
      severity_sort = true,
    }

    -- Setup tiny-inline-diagnostic
    require('tiny-inline-diagnostic').setup {
      -- Preset options: 'modern', 'classic', 'minimal', 'powerline', 'ghost', 'simple', 'nonerdfont'
      preset = 'modern',

      -- Options to customize behavior
      options = {
        -- Show diagnostic source
        show_source = true,

        -- Throttle time for diagnostics update (ms)
        throttle = 20,

        -- Multiple diagnostics on same line
        multiple_diag_under_cursor = true,

        -- Overflow behavior: 'wrap' or 'none'
        overflow = {
          mode = 'wrap',
        },

        -- Format function for diagnostic messages
        format = nil, -- nil uses default formatting

        -- Enable/disable on startup
        enable_on_insert = false, -- Don't show in insert mode

        -- Virtual text priority (higher = displayed on top)
        virt_texts = {
          priority = 9999, -- High priority to appear above git-blame
        },
      },

      -- Sign configuration - using your existing nerd font icons
      signs = {
        left = '',
        right = '',
        diag = '●',
        arrow = '   ',
        up_arrow = '   ',
        vertical = ' │',
        vertical_end = ' └',
        -- Severity-specific icons matching your lspconfig
        error = '󰅚',
        warn = '󰀪',
        info = '󰋽',
        hint = '󰌶',
      },

      -- Highlight groups
      hi = {
        error = 'DiagnosticError',
        warn = 'DiagnosticWarn',
        info = 'DiagnosticInfo',
        hint = 'DiagnosticHint',
        arrow = 'NonText',
        background = 'CursorLine',
        mixing_color = 'None',
      },
    }
  end,
  keys = {
    {
      '<leader>td',
      function()
        require('tiny-inline-diagnostic').toggle()
      end,
      desc = 'Toggle Inline Diagnostics',
    },
  },
}
