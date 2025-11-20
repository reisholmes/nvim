-- https://github.com/folke/trouble.nvim
return {
  'yorickpeterse/nvim-pqf',
  init = function()
    require('pqf').setup()
  end,
}
