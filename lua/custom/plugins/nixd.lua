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
