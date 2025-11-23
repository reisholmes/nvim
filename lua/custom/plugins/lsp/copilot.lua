-- GitHub Copilot LSP configuration
-- Required for sidekick.nvim Next Edit Suggestions feature
return {
  vim.lsp.config('copilot', {
    filetypes = {
      'bash',
      'c',
      'clojure',
      'cpp',
      'css',
      'dart',
      'elixir',
      'erlang',
      'fish',
      'go',
      'haskell',
      'html',
      'java',
      'javascript',
      'javascriptreact',
      'json',
      'kotlin',
      'lua',
      'markdown',
      'nix',
      'php',
      'python',
      'ruby',
      'rust',
      'scala',
      'scss',
      'sh',
      'swift',
      'toml',
      'typescript',
      'typescriptreact',
      'vim',
      'yaml',
      'zsh',
    },
    settings = {
      ['copilot'] = {
        -- Enable Next Edit Suggestions for sidekick.nvim
        ['enableNextEditSuggestions'] = true,
      },
    },
  }),
}
