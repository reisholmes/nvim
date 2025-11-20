return {
  vim.lsp.config('terraformls.setup', {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'tf' },
    settings = {},
  }),
  vim.lsp.config('tflint.setup', {}),
}
