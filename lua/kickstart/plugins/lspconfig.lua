-- LSP Plugins
---@module 'lazy'
---@type LazySpec
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {},
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Not a 0.12 default; grn, gra, gO, gW, grt are overridden by telescope.lua
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Document highlight
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          -- Toggle inlay hints
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- LSP servers (installed via nixpkgs, not Mason)
      vim.lsp.enable({
        'copilot',
        'gopls',
        'golangci_lint_ls',
        'lua_ls',
        'nixd',
        'powershell_es',
        'terraformls',
        'tflint',
      })

      -- Server configs (complex ones exported to lua/custom/plugins/lsp/)
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      })

      -- nixd config
      local system_name = vim.uv.os_gethostname()
      local function get_sysname()
        if system_name == 'reis-new' then
          return 'reis@reis-new'
        elseif system_name == 'rh-sb3' then
          return 'reis@rh-sb3'
        elseif system_name == 'reisholmes' then
          return 'reis.holmes@reis-work'
        else
          return 'reis@' .. system_name
        end
      end
      local sysname = get_sysname()

      local function get_nix_path()
        local paths = {
          '/home/reis/Documents/repos/nixCombined/flake.nix',
          '/Users/reis.holmes/Documents/code/personal_repos/nix-darwin/flake.nix',
        }
        for _, path in ipairs(paths) do
          if vim.uv.fs_stat(path) then
            return path
          end
        end
        return '/Users/reis.holmes/Documents/code/personal_repos/nix-darwin/flake.nix'
      end
      local nix_path = get_nix_path()

      vim.lsp.config('nixd', {
        cmd = { 'nixd' },
        filetypes = { 'nix' },
        root_markers = { 'flake.nix', '.git' },
        settings = {
          nixd = {
            nixpkgs = {
              expr = 'import (builtins.getFlake "' .. nix_path .. '")inputs.nixpkgs { }',
            },
            formatting = {
              command = { 'alejandra' },
            },
            options = {
              darwin = {
                expr = '(builtins.getFlake "' .. nix_path .. '").darwinConfigurations."reis-work".options',
              },
              home_manager = {
                expr = '(builtins.getFlake "' .. nix_path .. '").homeConfigurations."' .. sysname .. '".options',
              },
            },
          },
        },
      })

      -- powershell_es config
      local function get_pwsh_es_bundle_path()
        local handle = io.popen('which powershell-editor-services')
        if handle then
          local result = handle:read('*a')
          handle:close()
          if result then
            result = result:gsub('^%s*(.-)%s*$', '%1')
            result = result:gsub('/bin/', '/lib/')
            return result
          end
        end
      end
      local pwsh_es_bundle_path = get_pwsh_es_bundle_path()

      vim.lsp.config('powershell_es', {
        bundle_path = pwsh_es_bundle_path,
        settings = {
          powershell = {
            codeFormatting = { Preset = 'OTBS' },
          },
        },
      })
    end,
  },
}
