-- https://github.com/kevinhwang91/nvim-bqf
return {
  -- QUICKFIX IMPROVEMENTS
  --
  -- <Tab> to select items.
  -- zn to keep selected items.
  -- zN to filter selected items.
  -- zf to fuzzy search items.
  --
  -- <Ctrl-f> scroll down
  -- <Ctrl-b> scroll up
  'kevinhwang91/nvim-bqf',
  event = 'VeryLazy', -- Changed from ft = 'qf' to load earlier
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- Optimized preview performance with treesitter
  },
  config = function()
    -- Set up the quickfix text function FIRST, before bqf setup
    local fn = vim.fn

    function _G.qftf(info)
      local items
      local ret = {}
      if info.quickfix == 1 then
        items = fn.getqflist({ id = info.id, items = 0 }).items
      else
        items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
      end
      local limit = 31 -- Filename display limit
      local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
      local validFmt = '%s │%5d:%-3d│%s %s'
      for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
          if e.bufnr > 0 then
            fname = fn.bufname(e.bufnr)
            if fname == '' then
              fname = '[No Name]'
            else
              fname = fname:gsub('^' .. vim.env.HOME, '~')
            end
            -- Truncate filename if too long
            if #fname <= limit then
              fname = fnameFmt1:format(fname)
            else
              fname = fnameFmt2:format(fname:sub(1 - limit))
            end
          end
          local lnum = e.lnum > 99999 and -1 or e.lnum
          local col = e.col > 999 and -1 or e.col
          local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
          str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
          str = e.text
        end
        table.insert(ret, str)
      end
      return ret
    end

    -- Set the quickfix text function
    vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

    -- Now setup bqf
    require('bqf').setup({
      auto_enable = true,
      auto_resize_height = true, -- Automatically resize height based on item count
      preview = {
        auto_preview = true,
        border = 'rounded',
        show_title = true,
        show_scroll_bar = true,
        delay_syntax = 50,
        win_height = 15,
        win_vheight = 15,
        wrap = false, -- No line wrapping in preview
        should_preview_cb = function(bufnr)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          -- Skip preview for large files (>100KB)
          if fsize > 100 * 1024 then
            ret = false
          end
          return ret
        end,
      },
      func_map = {
        -- Default keybindings are good, but documented here for reference
        vsplit = '',
        ptogglemode = 'z,',
        stoggleup = '',
      },
      filter = {
        fzf = {
          action_for = { ['ctrl-s'] = 'split' },
          extra_opts = { '--bind', 'ctrl-o:toggle-all', '--delimiter', '│', '--prompt', '> ' },
        },
      },
    })

    -- Disable spell checking and set up syntax highlighting in quickfix window
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'qf',
      callback = function(event)
        vim.opt_local.spell = false

        -- Set up custom syntax highlighting with proper colors
        vim.cmd([[
          syn clear
          syn match qfError /^.*│.*│ E .*$/
          syn match qfWarning /^.*│.*│ W .*$/
          syn match qfInfo /^.*│.*│ I .*$/
          syn match qfNote /^.*│.*│ [NH] .*$/

          " Force Catppuccin Mocha diagnostic colors
          hi! qfError guifg=#f38ba8 gui=NONE cterm=NONE ctermfg=203
          hi! qfWarning guifg=#fab387 gui=NONE cterm=NONE ctermfg=216
          hi! qfInfo guifg=#89b4fa gui=NONE cterm=NONE ctermfg=111
          hi! qfNote guifg=#94e2d5 gui=NONE cterm=NONE ctermfg=116
        ]])
      end,
    })
  end,
}
