# Custom Neovim Plugins

## Color Schemes

### catppuccin
Pastel color scheme with Mocha flavour.
- **URL**: https://github.com/catppuccin/nvim
- **Keymaps**: None

---

## Development Tools

### diffview
Git diff viewer with file history browser.
- **URL**: https://github.com/sindrets/diffview.nvim
- **Keymaps**:
  - `<leader>gd` - Open git diff view
  - `<leader>gh` - Open git file history

### git-blame
Inline git blame annotations showing author, date, and summary.
- **URL**: https://github.com/f-person/git-blame.nvim
- **Keymaps**: `<leader>g` - Toggle git blame

### goto-preview
Preview LSP definitions, implementations, and references in floating windows.
- **URL**: https://github.com/rmagatti/goto-preview
- **Keymaps**:
  - `gpd` - Preview definition
  - `gpt` - Preview type definition
  - `gpi` - Preview implementation
  - `gpD` - Preview declaration
  - `gpr` - Preview references
  - `gP` - Close all previews

### lazygit (via snacks.nvim)
Terminal UI for git commands in a floating window, integrated through snacks.nvim.
- **URL**: https://github.com/folke/snacks.nvim (lazygit module)
- **Keymaps**: `<leader>lg` - Open LazyGit
- **Note**: Configured to use Nix-managed lazygit config

### sidekick
AI-powered coding assistant with Next Edit Suggestions and CLI tools integration.
- **URL**: https://github.com/folke/sidekick.nvim
- **Conditional Loading**: Only loads for user `reis.holmes` on host `reisholmes`
- **Keymaps**:
  - `<Tab>` / `<leader>an` - NES jump or apply suggestion
  - `<leader>aa` - Toggle AI CLI terminal
  - `<leader>as` - Select AI CLI tool
  - `<leader>ac` - Close AI CLI session
  - `<leader>at` - Send selection/context to AI
  - `<leader>af` - Send file to AI
  - `<leader>ad` - Send diagnostics to AI
  - `<leader>ap` - Select prompt template

### tiny-inline-diagnostic
Modern inline LSP diagnostics with customizable appearance.
- **URL**: https://github.com/rachartier/tiny-inline-diagnostic.nvim
- **Keymaps**: `<leader>td` - Toggle inline diagnostics

### trouble
Pretty list for diagnostics, references, quickfix, and location lists.
- **URL**: https://github.com/folke/trouble.nvim
- **Keymaps**:
  - `<leader>Txx` - Toggle diagnostics
  - `<leader>TxX` - Toggle buffer diagnostics
  - `<leader>Tcs` - Toggle symbols
  - `<leader>Tcl` - Toggle LSP definitions/references
  - `<leader>TxL` - Toggle location list
  - `<leader>TxQ` - Toggle quickfix list

---

## File/Search Management

### auto-session
Automatic session management with directory suppression.
- **URL**: https://github.com/rmagatti/auto-session
- **Keymaps**: None (automatic)

### flash
Fast navigation with labeled jumps and enhanced search.
- **URL**: https://github.com/folke/flash.nvim
- **Keymaps**:
  - `S` - Flash jump (normal/visual/operator)
  - `r` - Remote flash (operator)
  - `R` - Treesitter search (visual/operator)
  - `<c-s>` - Toggle flash search (command mode)

### gx
Smart URI/URL opener for links under cursor.
- **URL**: https://github.com/chrishrb/gx.nvim
- **Keymaps**: `<space>u` - Open URI/URL

### neoclip
Clipboard manager with Telescope integration.
- **URL**: https://github.com/AckslD/nvim-neoclip.lua
- **Keymaps**: `<leader>o` - Open neoclip

---

## Language Server Configuration

Located in `lua/custom/plugins/lsp/` directory.

### copilot
GitHub Copilot LSP with Next Edit Suggestions support for sidekick.nvim.
- **Location**: `lua/custom/plugins/lsp/copilot.lua`
- **Keymaps**: None (LSP features)

### terraformls & tflint
LSP configurations for Terraform and tflint linting.
- **Location**: `lua/custom/plugins/lsp/terraformls.lua`
- **Keymaps**: None (LSP features)

---

## Quickfix Enhancement

### bqf (Better Quickfix)
Enhanced quickfix with fuzzy search, filtering, custom formatting, and syntax highlighting.
- **URL**: https://github.com/kevinhwang91/nvim-bqf
- **Features**:
  - Custom quickfix text formatting with proper alignment
  - Syntax highlighting with Catppuccin Mocha diagnostic colors
  - Treesitter-optimized preview window
  - FZF integration with delimiter support
  - Spell checking disabled in quickfix windows
- **Keymaps** (in quickfix):
  - `<Tab>` - Select items
  - `zn` - Keep selected items
  - `zN` - Filter selected items
  - `zf` - Fuzzy search items
  - `<Ctrl-f>` - Scroll down
  - `<Ctrl-b>` - Scroll up
  - `<Ctrl-s>` - Open in split (fzf mode)
  - `<Ctrl-o>` - Toggle all selections (fzf mode)

---

## Utilities

### fzy-lua-native
Native Lua implementation of fzy fuzzy finder algorithm.
- **URL**: https://github.com/romgrk/fzy-lua-native
- **Keymaps**: None (dependency)

### render-markdown
Real-time markdown rendering with treesitter and mini.icons integration.
- **URL**: https://github.com/MeanderingProgrammer/render-markdown.nvim
- **Keymaps**: None (automatic)
- **Dependencies**: Uses mini.icons for icon rendering

### snacks
Collection of small utilities: bigfile, dashboard, indent, input, lazygit, notifier, quickfile, terminal.
- **URL**: https://github.com/folke/snacks.nvim
- **Enabled Modules**:
  - `bigfile` - Performance optimizations for large files
  - `dashboard` - Startup dashboard
  - `indent` - Indent guides and scope visualization
  - `input` - Enhanced vim.ui.input
  - `lazygit` - LazyGit integration
  - `notifier` - Notification system
  - `quickfile` - Fast file loading
  - `terminal` - Floating terminal
- **Disabled Modules**:
  - `words` - Disabled to avoid conflict with mini.cursorword
- **Keymaps**:
  - `<leader>n` - Show notifier history
  - `<leader>lg` - Open LazyGit

### ufo (Ultra Fold)
Modern code folding with treesitter and LSP support.
- **URL**: https://github.com/kevinhwang91/nvim-ufo
- **Keymaps**:
  - `zR` - Open all folds
  - `zM` - Close all folds
  - `zk` - Peek fold or show hover
