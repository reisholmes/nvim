return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, ps1 = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,

      format_after_save = function(bufnr)
        local enabled_filetypes = { ps1 = true }
        local lsp_format_opt
        if enabled_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'fallback'
          return
        end
        return {
          timeout_ms = 3000,
          lsp_format = lsp_format_opt,
        }
      end,

      -- Get the current

      formatters_by_ft = {
        lua = { 'stylua' },
        markdown = { 'markdownlint-cli2' },
        ps1 = { 'powershell' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        powershell = {
          command = 'pwsh',
          args = {
            '-NoLogo',
            '-NoProfile',
            '-NonInteractive',
            '-Command',
            '(Invoke-Formatter',
            '(Get-Content -Raw -Path',
            '$FILENAME',
            ') -Settings ~/.config/nvim/assets/formatters/CodeFormattingOTBS.psd1 ).Trim()',
          },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
