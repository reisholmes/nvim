-- https://github.com/gelguy/wilder.nvim
-- setup copied from https://github.com/folke/lazy.nvim/issues/561
return {
  'gelguy/wilder.nvim',
  --  config = function()
  --    local wilder = require 'wilder'
  --    wilder.setup { modes = { ':', '/', '?' } }

  config = function()
    local wilder = require 'wilder'
    wilder.setup { modes = { ':', '/', '?' } }

    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.python_file_finder_pipeline {
          file_command = function(ctx, arg)
            if string.find(arg, '.') ~= nil then
              return { 'fd', '-tf', '-H' }
            else
              return { 'fd', '-tf' }
            end
          end,
          dir_command = { 'fd', '-td' },
          -- filters = { "cpsm_filter" },
        },
        wilder.substitute_pipeline {
          pipeline = wilder.python_search_pipeline {
            skip_cmdtype_check = 1,
            pattern = wilder.python_fuzzy_pattern {
              start_at_boundary = 0,
            },
          },
        },
        wilder.cmdline_pipeline {
          fuzzy = 2,
          fuzzy_filter = wilder.lua_fzy_filter(),
        },
        {
          wilder.check(function(ctx, x)
            return x == ''
          end),
          wilder.history(),
        },
        wilder.python_search_pipeline {
          pattern = wilder.python_fuzzy_pattern {
            start_at_boundary = 0,
          },
        }
      ),
    })

    -- How the popup looks
    local gradient = {
      '#8bd5ca',
      '#91d7e3',
      '#7dc4e4',
      '#8aadf4',
      '#c6a0f6',
      '#f5bde6',
      '#ee99a0',
      '#ed8796',
    }

    for i, fg in ipairs(gradient) do
      gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = fg } })
    end

    local highlighters = wilder.highlighter_with_gradient {
      wilder.pcre2_highlighter(),
      wilder.lua_fzy_highlighter(),
    }

    local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
      pumblend = 20,
      border = 'rounded',
      empty_message = wilder.popupmenu_empty_message_with_spinner(),
      highlighter = highlighters,
      left = {
        ' ',
        wilder.popupmenu_devicons(),
        wilder.popupmenu_buffer_flags {
          flags = ' a + ',
          icons = { ['+'] = '', a = '', h = '' },
        },
      },
      right = {
        ' ',
        wilder.popupmenu_scrollbar(),
      },
      highlights = {
        --accent = wilder.make_hl('WilderAccent', 'Pmenu', {{a = 1}, {a = 1}, {foreground = '#f4468f'}}),
        gradient = gradient,
      },
    })

    local wildmenu_renderer = wilder.wildmenu_renderer {
      highlighter = highlighters,
      separator = ' · ',
      left = { ' ', wilder.wildmenu_spinner(), ' ' },
      right = { ' ', wilder.wildmenu_index() },
      highlights = {
        -- accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
        gradient = gradient,
      },
      apply_incsearch_fix = true,
    }

    wilder.set_option(
      'renderer',
      wilder.renderer_mux {
        [':'] = popupmenu_renderer,
        ['/'] = popupmenu_renderer,
        substitute = wildmenu_renderer,
      }
    )
  end,
}
