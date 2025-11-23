-- https://github.com/yorickpeterse/nvim-pqf
return {
  'yorickpeterse/nvim-pqf',
  ft = 'qf',
  config = function()
    require('pqf').setup()
  end,
}
