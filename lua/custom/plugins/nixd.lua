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

local function get_nix_path()
  if string.find(sysname, 'reis-new') or string.find(sysname, 'rh-sb3') then
    return '/home/reis/Documents/repos/nixCombined/flake.nix'
  elseif string.find(sysname, 'reisholmes') then
    return '/Users/reis.holmes/Documents/code/personal_repos/nix-darwin/flake.nix'
  else
    -- Default fallback
    return '/Users/reis/Documents/repos/nixCombined/flake.nix'
  end
end

local nix_path = get_nix_path()

return {
  {
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
    }),
    vim.lsp.enable 'nixd',
  },
}
