return {
  require('lspconfig').terraformls.setup {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'tf' },
    settings = {},
  },
  require('lspconfig').tflint.setup {},
}
