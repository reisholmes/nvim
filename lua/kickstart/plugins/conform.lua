---@module 'lazy'
---@type LazySpec
return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { 'ps1' }

        if vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype) then
          vim.lsp.buf.format()
          return
        end
        return {
          timeout_ms = 3000,
          lsp_format = 'fallback',
        }
      end,

      formatters_by_ft = {
        go = { 'gofmt' },
        lua = { 'stylua' },
        json = { 'jq' },
        markdown = { 'markdownlint-cli2' },
        nix = { 'alejandra' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },

      formatters = {},
    },
  },
}
