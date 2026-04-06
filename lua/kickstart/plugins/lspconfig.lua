-- LSP Plugins
---@module 'lazy'
---@type LazySpec
return {
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      {
        'mason-org/mason.nvim',
        ---@module 'mason.settings'
        ---@type MasonSettings
        ---@diagnostic disable-next-line: missing-fields
        opts = {},
      },
      -- Maps LSP server names between nvim-lspconfig and Mason package names.
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- We redefine the internal hover/signature functions to ALWAYS use rounded borders
      local _hover = vim.lsp.buf.hover
      vim.lsp.buf.hover = function(config)
        config = config or {}
        config.border = 'rounded'
        _hover(config)
      end

      local _signature_help = vim.lsp.buf.signature_help
      vim.lsp.buf.signature_help = function(config)
        config = config or {}
        config.border = 'rounded'
        _signature_help(config)
      end

      -- KEYMAPS
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local float_options = {
        border = 'rounded',
        focusable = false,
        max_width = 80,
        max_height = 20,
      }

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = vim.tbl_extend('force', float_options, { source = 'if_many' }),
        underline = { severity = { min = vim.diagnostic.severity.ERROR } },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      })

      local handlers = {
        ['textDocument/hover'] = vim.lsp.handlers.hover,
        ['textDocument/signatureHelp'] = vim.lsp.handlers.signature_help,
      }

      for method, handler in pairs(handlers) do
        vim.lsp.handlers[method] = function(err, result, ctx, config)
          -- Merge our centralized float_options with any server-specific config
          local merged_config = vim.tbl_extend('force', float_options, config or {})
          return handler(err, result, ctx, merged_config)
        end
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- ## NIXPKGS NATIVE METHOD ##
      -- Enable here when you have already got the language server installed on your system
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
      vim.lsp.enable({
        'copilot',
        'gopls',
        'golangci_lint_ls',
        'lua_ls',
        'nixd',
        'powershell_es',
        'stylua',
        'terraformls',
        'tflint',
      })

      -- Add the LSP configs below
      -- Some more complex configs have been exported out to lua/custom/plugins/lsp
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      })

      -- Functions for nixd
      -- Function to get the correct flake path based on system name
      local system_name = vim.uv.os_gethostname()
      local function get_sysname()
        if system_name == 'reis-new' then
          return 'reis@reis-new'
        elseif system_name == 'rh-sb3' then
          return 'reis@rh-sb3'
        elseif system_name == 'reisholmes' then
          return 'reis.holmes@reis-work'
        else
          -- Default fallback - you can adjust this as needed
          return 'reis@' .. system_name
        end
      end
      local sysname = get_sysname()

      -- Function to get the correct nix flake path
      local function get_nix_path()
        -- List of potential flake paths to check
        local paths = {
          '/home/reis/Documents/repos/nixCombined/flake.nix',
          '/Users/reis.holmes/Documents/code/personal_repos/nix-darwin/flake.nix',
        }

        -- Return the first path that exists
        for _, path in ipairs(paths) do
          if vim.uv.fs_stat(path) then
            return path
          end
        end

        -- Default fallback if none exist
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
              command = { 'alejandra' }, -- or nixfmt or nixpkgs-fmt
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

      -- Function to get the location of powershell editor services
      local function get_pwsh_es_bundle_path()
        local handle = io.popen('which powershell-editor-services')
        if handle then
          local result = handle:read('*a')
          handle:close()
          if result then
            -- strip out any whitespace
            result = result:gsub('^%s*(.-)%s*$', '%1')
            -- point it to the /lib/folder as that's where it's extracted
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
            codeFormatting = {
              Preset = 'OTBS',
            },
          },
        },
      })

      -- ## MASON INSTALL METHOD ##
      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --  See `:help lsp-config` for information about keys and how to configure
      ---@type table<string, vim.lsp.Config>
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --
        -- terraformls = {},
        -- tflint = {},
        --powershell_es = {
        --  bundle_path = bundle_path,
        --  on_attach = on_attach,
        --  settings = {
        --    powershell = {
        --      codeFormatting = {
        --        Preset = 'OTBS',
        --      },
        --    },
        --  },
        --},

        --lua_ls = {
        --  -- cmd = { ... },
        --  -- filetypes = { ... },
        --  -- capabilities = {},
        --  settings = {
        --    Lua = {
        --      completion = {
        --        callSnippet = 'Replace',
        --      },
        --      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        --      -- diagnostics = { disable = { 'missing-fields' } },
        --    },
        --  },
        --},
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- You can add other tools here that you want Mason to install
      })

      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
