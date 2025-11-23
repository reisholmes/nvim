-- https://github.com/rmagatti/goto-preview
return {
  'rmagatti/goto-preview',
  opts = {
    width = 120,
    height = 15,
    border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' },
    default_mappings = false,
    resizing_mappings = false,
  },
  keys = {
    { 'gpd', "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", desc = 'Definition', mode = 'n' },
    {
      'gpt',
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>",
      desc = 'Type Definition',
      mode = 'n',
    },
    {
      'gpi',
      "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
      desc = 'Implementation',
      mode = 'n',
    },
    { 'gpD', "<cmd>lua require('goto-preview').goto_preview_declaration()<cr>", desc = 'Declaration', mode = 'n' },
    { 'gpr', "<cmd>lua require('goto-preview').goto_preview_references()<cr>", desc = 'References', mode = 'n' },
    { 'gP', "<cmd>lua require('goto-preview').close_all_win()<cr>", desc = 'Close all previews', mode = 'n' },
  },
}
