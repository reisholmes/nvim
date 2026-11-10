---@module 'lazy'
---@type LazySpec
return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.files').setup({
        windows = { preview = true, width_preview = 40 },
      })

      require('mini.ai').setup({
        -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
        mappings = {
          around_next = 'aa',
          inside_next = 'ii',
        },
        n_lines = 500,
      })
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
      -- If a nerd font is available, load the icons module for pretty icons in various plugins.
      if vim.g.have_nerd_font then
        require('mini.icons').setup()
        -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
        MiniIcons.mock_nvim_web_devicons()
      end
      require('mini.tabline').setup({ use_icons = true })
      require('mini.align').setup()
      require('mini.operators').setup()
    end,
  },
}
