-- https://github.com/rmagatti/goto-preview
return {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup {
      width = 120,
      height = 15,
      border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
      default_mappings = false,
      resizing_mappings = false,
    }

    -- Register with which-key
    require('which-key').add {
      { 'gp', group = '[G]oto [P]review' },
    }
  end,
  keys = {
    { 'gpd', "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", desc = 'Definition' },
    { 'gpt', "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>", desc = 'Type Definition' },
    { 'gpi', "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", desc = 'Implementation' },
    { 'gpD', "<cmd>lua require('goto-preview').goto_preview_declaration()<cr>", desc = 'Declaration' },
    { 'gpr', "<cmd>lua require('goto-preview').goto_preview_references()<cr>", desc = 'References' },
    { 'gP', "<cmd>lua require('goto-preview').close_all_win()<cr>", desc = 'Close all previews' },
  },
}
