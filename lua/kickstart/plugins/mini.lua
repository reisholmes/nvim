---@module 'lazy'
---@type LazySpec
return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.files').setup({
        windows = { preview = true, width_preview = 40 },
      })

      require('mini.ai').setup({ n_lines = 500 })
      require('mini.surround').setup()

      -- Statusline
      local statusline = require('mini.statusline')
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end

      -- Show LSP progress in statusline (replaces fidget.nvim)
      local orig_section_lsp = statusline.section_lsp
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_lsp = function(args)
        local ok, progress = pcall(vim.ui.progress_status)
        if ok and progress and progress ~= '' then return progress end
        return orig_section_lsp(args)
      end

      require('mini.cursorword').setup()
      require('mini.icons').setup()
      require('mini.tabline').setup({ use_icons = true })
      require('mini.align').setup()
      require('mini.operators').setup()
    end,
  },
}
