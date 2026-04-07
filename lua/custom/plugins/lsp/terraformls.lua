-- Terraform and TFLint LSP configurations
return {
  vim.lsp.config('terraformls', {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'tf' },
    settings = {},
  }),
  vim.lsp.config('tflint', {
    cmd = { 'tflint', '--langserver' },
    filetypes = { 'terraform', 'tf' },
    settings = {},
  }),
}
