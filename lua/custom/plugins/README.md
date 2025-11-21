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
- **Keymaps**: None

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

### lazygit
Terminal UI for git commands in a floating window.
- **URL**: https://github.com/kdheepak/lazygit.nvim
- **Keymaps**: `<leader>lg` - Open LazyGit

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

### terraformls
LSP configuration for Terraform and tflint.
- **URL**: N/A (LSP configuration)
- **Keymaps**: None (LSP features)

---

## Quickfix Enhancement

### bqf (Better Quickfix)
Enhanced quickfix with fuzzy search and filtering.
- **URL**: https://github.com/kevinhwang91/nvim-bqf
- **Keymaps** (in quickfix):
  - `<Tab>` - Select items
  - `zn` - Keep selected items
  - `zN` - Filter selected items
  - `zf` - Fuzzy search items
  - `<Ctrl-f>` - Scroll down
  - `<Ctrl-b>` - Scroll up

### pqf (Pretty Quickfix)
Prettier quickfix list formatting.
- **URL**: https://github.com/yorickpeterse/nvim-pqf
- **Keymaps**: None

---

## Utilities

### fzy-lua-native
Native Lua implementation of fzy fuzzy finder algorithm.
- **URL**: https://github.com/romgrk/fzy-lua-native
- **Keymaps**: None (dependency)

### render-markdown
Real-time markdown rendering with treesitter.
- **URL**: https://github.com/MeanderingProgrammer/render-markdown.nvim
- **Keymaps**: None (automatic)

### snacks
Collection of small utilities: bigfile, dashboard, indent, notifier, terminal.
- **URL**: https://github.com/folke/snacks.nvim
- **Keymaps**: `<leader>n` - Show notifier history

### ufo (Ultra Fold)
Modern code folding with treesitter and LSP support.
- **URL**: https://github.com/kevinhwang91/nvim-ufo
- **Keymaps**:
  - `zR` - Open all folds
  - `zM` - Close all folds
  - `zk` - Peek fold or show hover
