return {
  require('lspconfig').nixd.setup {
    cmd = { 'nixd' },
    settings = {
      nixd = {
        nixpkgs = {
          --  expr = 'import <nixpkgs> { }',
          expr = 'import (builtins.getFlake "/home/reis/nixgl/flake.nix").inputs.nixpkgs { }',
        },
        formatting = {
          command = { 'alejandra' }, -- or nixfmt or nixpkgs-fmt
        },
        -- options = {
        --   nixos = {
        --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
        --   },
        --   home_manager = {
        expr = '(builtins.getFlake "/home/reis/nixgl/flake.nix").homeConfigurations.reis.options',
        --   },
        -- },
      },
    },
  },
}
