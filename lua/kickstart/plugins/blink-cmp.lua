---@module 'lazy'
---@type LazySpec
return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',

        -- Tab: snippet forward -> sidekick NES -> fallback
        ['<Tab>'] = {
          'snippet_forward',
          function()
            local ok, sidekick = pcall(require, 'sidekick')
            if ok then
              return sidekick.nes_jump_or_apply()
            end
          end,
          'fallback',
        },
      },

      appearance = { nerd_font_variant = 'mono' },

      completion = {
        menu = { border = 'rounded' },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
          window = {
            border = 'rounded',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'markdown' },
        providers = {
          markdown = { name = 'RenderMarkdown', module = 'render-markdown.integ.blink' },
        },
      },

      snippets = { preset = 'luasnip' },
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'rust' },

      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },
        keymap = { preset = 'cmdline' },
      },
    },
  },
}
