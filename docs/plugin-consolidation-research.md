# Plugin Consolidation Research

## Current Plugin Analysis for Mini.nvim Replacement

This document tracks research on consolidating Neovim plugins using either mini.nvim or snacks.nvim alternatives.

---

## Mini.nvim Replacement Candidates

### Low Risk Replacements (Recommended)

#### 1. nvim-autopairs → mini.pairs

**Current:** `windwp/nvim-autopairs` (lua/kickstart/plugins/autopairs.lua:5)
**Replacement:** `mini.pairs`

**Benefits:**
- Lighter weight and faster
- Part of existing mini.nvim dependency
- Simpler configuration with sensible defaults
- Well-integrated with the mini.nvim ecosystem

**Risks:**
- Slightly fewer advanced features (though core functionality is the same)
- Less customization for complex autopair rules
- May need to adjust if using advanced autopair patterns

**Recommendation:** ✅ Low risk, good candidate for replacement

---

#### 2. indent-blankline.nvim → Already covered by snacks.indent

**Current:** `lukas-reineke/indent-blankline.nvim` (lua/kickstart/plugins/indent_line.lua:3)
**Note:** `snacks.indent` is already enabled (lua/custom/plugins/snacks.lua:16-18)

**Benefits:**
- Already have snacks.indent providing this functionality
- Reduces duplicate functionality
- Cleaner plugin list

**Risks:**
- None - already have replacement active

**Recommendation:** ✅ Remove indent-blankline.nvim to avoid duplication

---

### Medium Risk Replacements (Consider Carefully)

#### 3. which-key.nvim → mini.clue

**Current:** `folke/which-key.nvim` (lua/kickstart/plugins/which-key.lua:17)
**Replacement:** `mini.clue`

**Benefits:**
- Lighter weight
- Part of mini.nvim ecosystem
- Shows upcoming key combinations

**Risks:**
- which-key is more mature and feature-complete
- Different UI/UX approach
- which-key has better documentation integration
- May lack some advanced which-key features (groups, nested descriptions)

**Recommendation:** ⚠️ Medium risk - which-key is quite polished, but mini.clue is viable

---

#### 4. flash.nvim → mini.jump2d

**Current:** `folke/flash.nvim` (lua/custom/plugins/flash.lua:3)
**Replacement:** `mini.jump` or `mini.jump2d`

**Benefits:**
- Part of mini.nvim ecosystem
- `mini.jump2d` provides 2D jumping similar to flash
- Lighter weight

**Risks:**
- flash.nvim is very feature-rich with treesitter integration
- Current config uses flash's treesitter features (lua/custom/plugins/flash.lua:21)
- mini.jump is simpler (single-char jumps only)
- mini.jump2d may not have all flash features

**Recommendation:** ⚠️ Medium-high risk - flash.nvim has unique features that mini may not fully replace

---

### High Risk Replacements (Keep Current Plugin)

#### 5. gitsigns.nvim → mini.git + mini.diff

**Current:** `lewis6991/gitsigns.nvim` (lua/kickstart/plugins/gitsigns.lua:18)
**Replacement:** `mini.git` + `mini.diff`

**Benefits:**
- Part of mini.nvim ecosystem
- Lighter weight combination
- `mini.diff` handles diff visualization
- `mini.git` provides git command integration

**Risks:**
- ❌ HIGH RISK: gitsigns.nvim is very mature and feature-rich
- Extensive keybindings configured (lua/kickstart/plugins/gitsigns.lua:27-76)
- mini.git/mini.diff may lack some advanced features like inline blame, preview hunks, etc.
- Would require significant configuration migration

**Recommendation:** ❌ High risk, keep gitsigns.nvim unless wanting to significantly simplify

---

#### 6. trouble.nvim → No suitable replacement

**Current:** `folke/trouble.nvim` (lua/custom/plugins/trouble.lua:3)
**Potential Replacement:** `mini.pick` with custom views (not recommended)

**Risks:**
- ❌ HIGH RISK: trouble.nvim is specialized for diagnostics/quickfix display
- mini.pick is a general picker, not a dedicated diagnostics UI
- Would lose specialized features and polished UI

**Recommendation:** ❌ Keep trouble.nvim - it's a specialized tool worth keeping

---

#### 7. diffview.nvim → mini.diff

**Current:** `sindrets/diffview.nvim` (lua/custom/plugins/diffview.lua:3)
**Replacement:** `mini.diff`

**Benefits:**
- Simpler, lighter weight
- Part of mini.nvim ecosystem

**Risks:**
- ❌ HIGH RISK: diffview.nvim has sophisticated split-view interface
- mini.diff is more basic (inline diff display)
- Would lose file history view and interactive diff features
- diffview is specifically designed for complex git workflows

**Recommendation:** ❌ High risk - diffview.nvim offers specialized features worth keeping

---

#### 8. nvim-neoclip.lua → No direct replacement

**Current:** `AckslD/nvim-neoclip.lua` (lua/custom/plugins/neoclip.lua:2)
**Note:** Could potentially use `mini.pick` with custom picker, but not practical

**Recommendation:** ❌ Keep neoclip - no suitable mini.nvim alternative

---

## Snacks.nvim Overlap with Mini.nvim

**Current snacks.nvim enabled features** (lua/custom/plugins/snacks.lua):
- `bigfile` - No mini.nvim equivalent
- `dashboard` - Overlaps with `mini.starter`
- `indent` - Overlaps with `mini.indentscope`
- `input` - No mini.nvim equivalent
- `notifier` - Overlaps with `mini.notify`
- `terminal` - No mini.nvim equivalent
- `quickfile` - No mini.nvim equivalent
- `words` - Similar to `mini.cursorword` (already enabled)

**Action Items:**
- Consider consolidating overlapping features between snacks and mini
- Currently using both `snacks.words` and `mini.cursorword` for similar purposes
- Both `snacks.indent` and considering `mini.indentscope` for indent visualization

---

## Summary

### Recommended Actions:
1. ✅ Replace `nvim-autopairs` with `mini.pairs` (low risk)
2. ✅ Remove `indent-blankline.nvim` (already have snacks.indent)
3. ⚠️ Consider `which-key.nvim` → `mini.clue` (only if wanting simpler approach)
4. ⚠️ Consider `flash.nvim` → `mini.jump2d` (only if not needing treesitter features)

### Keep As-Is:
- ❌ gitsigns.nvim (too complex to migrate)
- ❌ trouble.nvim (specialized tool)
- ❌ diffview.nvim (complex git workflows)
- ❌ neoclip (no suitable replacement)

### Investigate:
- Consolidate snacks.nvim and mini.nvim overlapping features
- Decide on unified approach for similar functionality

---

## Snacks.nvim Replacement Candidates

### Plugins That Can Be Replaced by Snacks.nvim

#### 1. lazygit.nvim → snacks.lazygit

**Current:** `kdheepak/lazygit.nvim` (lua/custom/plugins/lazygit.lua:5)
**Replacement:** `snacks.lazygit`

**Benefits:**
- Already have snacks.nvim installed
- Integrated floating git interface with better Neovim integration
- One less dependency to manage
- Snacks provides additional git utilities (gitbrowse, gh)

**Risks:**
- Low risk - snacks.lazygit provides same core functionality
- May have slightly different keybindings or behavior

**Recommendation:** ✅ Low risk replacement - consolidate to snacks.lazygit

---

#### 2. auto-session → snacks.sessions (mini.sessions alternative)

**Current:** `rmagatti/auto-session` (lua/custom/plugins/auto-session.lua:2)
**Replacement Options:** `mini.sessions` or session management via snacks utilities

**Benefits:**
- Reduce plugin count
- Both mini.sessions and potential snacks approach are lighter weight

**Risks:**
- Medium risk - auto-session has specific directory suppression config
- Would need to verify feature parity
- Session management is workflow-critical

**Recommendation:** ⚠️ Medium risk - investigate mini.sessions first before replacing

---

#### 3. telescope.nvim → snacks.picker

**Current:** `nvim-telescope/telescope.nvim` (lua/kickstart/plugins/telescope.lua:10)
**Replacement:** `snacks.picker`

**Benefits:**
- Snacks.picker is a unified picker interface
- Lighter weight
- Already have snacks.nvim installed

**Risks:**
- ❌ HIGH RISK: Telescope is extremely mature and feature-rich
- Extensive keybindings and custom functions (lua/kickstart/plugins/telescope.lua:77-113)
- Telescope has large ecosystem of extensions (fzf, ui-select, neoclip)
- Would lose telescope-ui-select for LSP code actions
- Significant migration effort

**Recommendation:** ❌ High risk - Telescope is central to workflow, keep as-is

---

### Current Snacks.nvim vs Mini.nvim Overlap

Your configuration currently has **overlapping functionality** between snacks.nvim and mini.nvim:

| Feature | Snacks.nvim (Enabled) | Mini.nvim (Enabled) | Recommendation |
|---------|----------------------|---------------------|----------------|
| Dashboard/Starter | `snacks.dashboard` ✅ | `mini.starter` ❌ (not enabled) | Keep snacks.dashboard |
| Indent visualization | `snacks.indent` ✅ | `mini.indentscope` ❌ (not enabled) | Keep snacks.indent |
| Notifications | `snacks.notifier` ✅ | `mini.notify` ❌ (not enabled) | Keep snacks.notifier |
| Word highlighting | `snacks.words` ✅ | `mini.cursorword` ✅ | **CONFLICT**: Disable one |
| Input enhancement | `snacks.input` ✅ | No mini equivalent | Keep snacks.input |
| Terminal | `snacks.terminal` ✅ | No mini equivalent | Keep snacks.terminal |
| Big file optimization | `snacks.bigfile` ✅ | No mini equivalent | Keep snacks.bigfile |
| Quick file loading | `snacks.quickfile` ✅ | No mini equivalent | Keep snacks.quickfile |

**Immediate Action Required:**
- **Disable either `snacks.words` OR `mini.cursorword`** - these provide duplicate functionality

---

## Mini.nvim vs Snacks.nvim: Philosophy Comparison

### Mini.nvim Philosophy

**Design Principles:**
- **Extreme modularity**: 40+ independent modules, each works standalone
- **Zero dependencies**: No module depends on another
- **Consistent API**: All modules follow similar patterns
- **Educational focus**: Code is readable and well-documented
- **Selective adoption**: Pick only what you need
- **Long-term stability**: Author prioritizes backward compatibility

**Best For:**
- Users who want fine-grained control over each feature
- Building a custom configuration from scratch
- Learning Lua/Neovim plugin development
- Minimal configurations with specific needs

**Strengths:**
- Very lightweight individual modules
- Excellent documentation
- Consistent behavior across modules
- Easy to understand and extend

**Weaknesses:**
- Can feel "basic" compared to specialized plugins
- Requires more manual configuration
- Some features less polished than dedicated alternatives
- Need to enable/configure many modules for full experience

---

### Snacks.nvim Philosophy

**Design Principles:**
- **Curated collection**: Quality over quantity - focused set of QoL improvements
- **Modern and opinionated**: Leverages latest Neovim features
- **Integration focus**: Modules work together smoothly
- **Performance obsessed**: Early loading, optimizations (bigfile, quickfile)
- **Rich UI**: Animations, floating windows, polished interfaces
- **Developer workflow**: Git tools, terminal, debugging utilities

**Best For:**
- Users who want a polished, cohesive experience
- Modern Neovim workflows with latest features
- Those who trust Folke's (author of lazy.nvim, noice.nvim, etc.) design choices
- Workflow-focused development (git, terminals, pickers)

**Strengths:**
- Highly polished UI/UX
- Excellent performance optimizations
- Strong integration with modern Neovim ecosystem
- Rich feature set per module (animations, easing functions, etc.)
- Active development by respected author

**Weaknesses:**
- More opinionated - less customizable than alternatives
- Newer project - less battle-tested than some alternatives
- Heavier weight per module than mini.nvim
- Features can overlap with existing plugins

---

## Recommendation: Which Ecosystem to Prefer?

### For Your Configuration: **Hybrid Approach with Snacks.nvim Priority**

Based on your current setup, here's the recommended strategy:

#### Core Philosophy
**Use Snacks.nvim for workflow/UI features, Mini.nvim for editing primitives**

#### Recommended Plugin Structure

**Snacks.nvim (Keep for):**
- ✅ Dashboard/startup (`snacks.dashboard`)
- ✅ Notifications (`snacks.notifier`)
- ✅ Input enhancement (`snacks.input`)
- ✅ Terminal (`snacks.terminal`)
- ✅ Indent visualization (`snacks.indent`)
- ✅ Performance optimizations (`snacks.bigfile`, `snacks.quickfile`)
- ✅ **ADD:** LazyGit integration (`snacks.lazygit`) - replace kdheepak/lazygit.nvim
- ⚠️ **CONSIDER:** Git browsing, GitHub integration if needed
- ❌ **DISABLE:** `snacks.words` (conflicts with mini.cursorword)

**Mini.nvim (Keep for):**
- ✅ Text editing primitives (`mini.ai`, `mini.surround`, `mini.operators`)
- ✅ Statusline/tabline (`mini.statusline`, `mini.tabline`)
- ✅ File navigation (`mini.files`)
- ✅ Word highlighting (`mini.cursorword`)
- ✅ Text alignment (`mini.align`)
- ✅ Icons (`mini.icons`)
- ✅ **ADD:** Autopairs (`mini.pairs`) - replace nvim-autopairs

**Specialized Plugins (Keep):**
- ✅ Telescope (too central to workflow)
- ✅ Gitsigns (mature, feature-rich)
- ✅ Trouble (specialized diagnostics UI)
- ✅ Diffview (complex git workflows)
- ✅ Flash (treesitter integration)
- ✅ Which-key (polished, well-documented)
- ✅ Neoclip (no replacement)

**Remove:**
- ❌ indent-blankline.nvim (duplicate of snacks.indent)
- ❌ nvim-autopairs (replace with mini.pairs)
- ❌ kdheepak/lazygit.nvim (replace with snacks.lazygit)

---

## Summary: Action Plan

### Immediate Changes (Low Risk) - ✅ COMPLETED
1. ✅ **DONE** - ~~Remove `nvim-autopairs` → Add `mini.pairs` to mini.nvim config~~ (Skipped for now)
2. ✅ **DONE** - Removed `indent-blankline.nvim` → Using `snacks.indent`
3. ✅ **DONE** - Removed `kdheepak/lazygit.nvim` → Enabled `snacks.lazygit` with `configure = false` to preserve Nix-managed config
4. ✅ **DONE** - Disabled `snacks.words` in snacks config → Using `mini.cursorword`

### Configuration Audit - ✅ COMPLETED
5. ✅ **DONE** - Reviewed and consolidated overlapping features
6. ✅ **DONE** - Keybindings updated for snacks.lazygit (`<leader>lg`), theme preserved from Nix config

### Future Considerations (Lower Priority)
7. 🔍 Investigate `mini.sessions` as replacement for `auto-session`
8. 🔍 Consider `mini.clue` if wanting lighter which-key alternative

---

## Final Recommendation

**Winner: Hybrid Approach with Snacks.nvim + Mini.nvim**

**Rationale:**
- Snacks.nvim provides better workflow/UI features (terminal, notifications, dashboard, performance)
- Mini.nvim excels at text editing primitives and lightweight utilities
- Both philosophies complement each other well
- Your current config already uses both effectively
- Focus on removing duplicates and specialized plugins with good replacements

**Don't go all-in on either:**
- Don't replace Telescope with snacks.picker (too risky)
- Don't replace specialized plugins (gitsigns, trouble, diffview) with mini alternatives
- Do consolidate where there's clear overlap (autopairs, indent, lazygit, word highlighting)

This gives you the best of both worlds: polished workflow features from snacks, lightweight editing power from mini, and specialized tools where they excel.
