# Upstream Sync Plan

Working document for keeping this fork in sync with `upstream` (dam9000/kickstart-modular.nvim).
Audited: 2026-11-10, `dev`@484df0a vs `upstream/dev`@af4c513, merge-base f0b4c3d.
Branch state: 72 ahead, 43 behind.
Verified: commit set with `git rev-list f0b4c3d..upstream/dev`, custom specs with `lazy.core.util.lsmod('custom.plugins')`, merge conflicts with `git merge-tree --write-tree HEAD upstream/dev`.

## Decisions

- Do not `git merge upstream/dev`. Both sides rewrote the same plugin files in incompatible formats (our lazy.nvim specs vs upstream's vim.pack modules). A test merge conflicts in 21 paths, and `autopairs.lua`, `todo-comments.lua`, and `custom/plugins/init.lua` merge silently to upstream's side. Merging mixes the two plugin managers and forces the full migration.
- Backported fixes 1-5 on `dev`: code in 0182593, `lazy-lock.json` refresh in 484df0a.
- Defer the vim.pack migration as its own project (see [Migration plan](#migration-plan-deferred-project)).

## The 43 commits, grouped

### Backport now: 5 fixes (16 commits)

| # | Fix | Our file(s) | Upstream commits |
|---|-----|-------------|------------------|
| 1 | treesitter indent fallback | `lua/kickstart/plugins/treesitter.lua:29` | c7f05a0, c0cc054, f27810d, bd8189a, 3174e05 |
| 2 | diagnostic jump `on_jump` | `lua/keymaps.lua:47` | a5d4d12, cfdc17b |
| 3 | mini.ai incremental-selection conflict | `lua/kickstart/plugins/mini.lua:11` | 9b4fbc5, b30e683, 4b065ad, 2ea6bf6 |
| 4 | devicons → mini.icons | `mini.lua:31`, `telescope.lua:18`, `neo-tree.lua:11` | ec3f448, 1f32074, f3bb34b |
| 5 | config picker follows symlinks (optional) | `telescope.lua:106` | f660e1f, ae8a27b |

### Defer with the migration (10 commits)

c460542, cd7adee, 716d746, a42ed30, 2e8d5b1, 2fccee4, 174b5fa, 5802ce5, f0a2108, af4c513.
The vim.pack migration itself (PR #2005) plus the custom-loader symlink follow. The loader only exists in the vim.pack world.

### Skip: conform refactor (4 commits)

ce353a9, 459b868, 9cf1323, f5b0e49 (PR #1991).
Upstream switches `format_on_save` from blacklist to whitelist and runs stylua as the LSP formatter.
This conflicts with our ps1 blacklist and our gofmt/nix/jq external formatters.
Port by hand only if we want it.

### Skip: repo tooling (9 commits)

- 97b3cbb, ac51593, 4e6bf94, 44e29de, a8f3b10: `.github` issue-template changes (discussions, checkhealth step). Upstream's template, not ours.
- 821b80c, 3e691bc, 3fc3639: `scripts/split_init.py`. Monolith-to-modular conversion tool. We are already modular.
- f26595a: blank line before vim modeline. Cosmetic, post-migration files only.

### Already in our fork (4 commits + 1 partial pick-up)

- 7031a09, adbaaaf: foundation split into `options` and `keymaps`. We already have `lua/options.lua` and `lua/keymaps.lua`. (`mapleader`/`have_nerd_font` sit in `init.lua:3,5`.)
- 648471c, 3fadba5: gitsigns mapping descs. Our `hQ`/`hq`/`tw` already carry descs in our own wording.
- Partial pick-up: our commit 6e3eb34 already sets `jump.on_jump = vim.diagnostic.open_float` in `lua/keymaps.lua`, but it passes `open_float` directly. Backport 2 refines it. The `health.lua` 0.11→0.12 bump is still unapplied and rides with c460542.

## Backport details

### 1. treesitter indent fallback — `lua/kickstart/plugins/treesitter.lua:29`

Our `treesitter_try_attach` sets `vim.bo.indentexpr` unconditionally. If the language has no TS indent query, the expr does not error, but it overrides the builtin fallback with a TS-computed value.
Replace lines 28-29 (comment + assignment) with:

```lua
        -- check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

        -- enables treesitter based indentation
        if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
```

Use the plural `'indents'`. c7f05a0 introduced the guard with the typo `'indent'`, and f27810d fixed it. Do not copy the older commit.

### 2. diagnostic jump — `lua/keymaps.lua:47`

Our line: `jump = { on_jump = vim.diagnostic.open_float },`
Nvim calls `on_jump(diag, bufnr)`. Passing `open_float` bare puts the diag table in the `opts` slot. The diag table already carries `bufnr`, so the buffer is right, but the float uses the default `scope = 'line'` instead of `'cursor'`.
Replace with:

```lua
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
```

### 3. mini.ai keymaps — `lua/kickstart/plugins/mini.lua:11`

Default `an`/`in` clash with the builtin treesitter incremental selection added in nvim 0.12.
Replace `require('mini.ai').setup({ n_lines = 500 })` with:

```lua
      require('mini.ai').setup({
        -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
        mappings = {
          around_next = 'aa',
          inside_next = 'ii',
        },
        n_lines = 500,
      })
```

### 4. devicons → mini.icons

Drop nvim-web-devicons entirely. mini.icons mocks it for back-compat.

- `mini.lua:31` — replace `require('mini.icons').setup()` with:

```lua
      -- If a nerd font is available, load the icons module for pretty icons in various plugins.
      if vim.g.have_nerd_font then
        require('mini.icons').setup()
        -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
        MiniIcons.mock_nvim_web_devicons()
      end
```

- `telescope.lua:18` — delete `{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },`
- `neo-tree.lua:11` — delete `'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended`

Only these two spec files reference nvim-web-devicons. `lazy-lock.json:23` still lists it, so run `:Lazy clean` after the edit to drop the install and lock entry. The `MiniIcons` global exists because mini.nvim loads eagerly before telescope/neo-tree configure.

### 5. Config picker follows symlinks (optional)

`telescope.lua:106` — add `follow = true` to the `find_files` opts behind `<leader>sn`.
Our `~/.config/nvim` is a real directory, so this is a safety net only.

## Test the backports (nvim 0.12.6, real session)

1. `:lua print(vim.bo.indentexpr)` in a lua file prints the TS expr. In a `.diff` file it prints empty (fallback to builtin).
2. With a file containing diagnostics, `[d`/`]d` open the float at cursor scope in the right buffer. (Headless float tests hang; do this in a real session.)
3. `vaa`/`vai` select around/inside next via mini.ai, and the builtin 0.12 incremental selection still works on its own keys.
4. Telescope and neo-tree still render file icons. `:lua print(pcall(require, 'nvim-web-devicons'))` returns `true, table` via the mock.
5. Clean startup: `:messages` shows no errors after reload. If `have_nerd_font` is ever false, confirm the tabline (unconditional `use_icons = true` in our `mini.lua:32`) does not error with mini.icons unset.

## Migration plan (deferred project)

### Why a merge cannot work

Both trees rewrote the same plugin files in incompatible forms:

- Ours: each `lua/kickstart/plugins/*.lua` returns a lazy.nvim spec table, wired through `lua/lazy-plugins.lua` (13 kickstart specs + `{ import = 'custom.plugins' }`, 12 custom plugin specs).
- Upstream: each file is a side-effect module that calls `vim.pack.add` directly, loaded by ordered `require` lines.

The 2 files under `lua/custom/plugins/lsp/` are not imported: `{ import = 'custom.plugins' }` and upstream's fs-dir loop are both non-recursive, so `copilot.lua` and `terraformls.lua` stay unloaded until we require them explicitly.

A test merge (`git merge-tree --write-tree HEAD upstream/dev`) conflicts in 21 paths: 12 kickstart plugin files, 5 non-plugin files (`.gitignore`, `README.md`, `init.lua`, `keymaps.lua`, `options.lua`), and 4 delete/modify conflicts (`indent_line.lua`, `tokyonight.lua`, `lazy-bootstrap.lua`, `lazy-plugins.lua`). `autopairs.lua`, `todo-comments.lua`, and `custom/plugins/init.lua` do not conflict and would silently become upstream's vim.pack versions. The fs-dir loop would require our spec-returning modules without running their setups. Taking either side wholesale means adopting the other's plugin manager.

### Upstream tip architecture (target state of the migration)

- `init.lua` — banner, foundation (`options`/`keymaps`, plus our `autocommands`), then `require 'pack'` and `require 'plugins'`. Upstream has no `autocommands` module, so keep `require 'autocommands'` in ours.
- `lua/pack.lua` — a `PackChanged` autocmd runs build steps after install/update: `make` for telescope-fzf-native, `make install_jsregexp` for LuaSnip, `:TSUpdate` for nvim-treesitter.
- `lua/plugins.lua` — ordered `require 'kickstart.plugins.X'` for the 11 core modules.
- `lua/kickstart/plugins/*.lua` — each calls `vim.pack.add { ... }` then sets up. Eager load, no lazy triggers.
- `lua/custom/plugins/init.lua` — `vim.fs.dir(plugins_dir, { follow = true })` require loop over our modules.
- Version pinning via spec `version` fields, but only LuaSnip, blink.cmp, neo-tree, and nvim-treesitter use them. The rest track default branches. `lazy-lock.json` goes away.

### What we lose without extra work

- Lazy-load triggers (`event`/`cmd`/`keys`/`ft`). trouble, sidekick, flash, git-blame, quicker, tiny-inline-diagnostic, render-markdown, diffview, goto-preview and neoclip would load eagerly. Snacks is already eager (`lazy = false`), and copilot is an LSP config, not a plugin spec. Needs hand-rolled `opt` specs + `:packadd` autocommands.
- lazy.nvim UI and `:checkhealth` integration.
- `{ import = 'custom.plugins' }` discovery (replaced by the fs-dir loop).
- `lazy-lock.json` reproducibility (only partly replaced: 4 upstream specs carry `version`, so exact commits need manual pins).

### Migration steps (sketch)

1. Add `lua/pack.lua` (build hooks) and `lua/plugins.lua` (ordered requires).
2. Convert each kickstart plugin file from `return { LazySpec }` to a side-effect module (`vim.pack.add` + direct setup), preserving our customizations.
3. Convert the 12 imported `lua/custom/plugins` modules the same way. Require `lsp/*.lua` explicitly, then point `custom/plugins/init.lua` at the fs-dir loop.
4. Recreate lazy-load behavior for the heavy plugins as `opt` specs + `:packadd` autocommands.
5. Pin `version` on every spec if we want lazy-lock-level reproducibility, delete `lazy-lock.json`, test startup and every keymap.

### When to do it

When we want to drop the lazy.nvim bootstrap dependency, or when vim.pack matures further. It is not a sync necessity. All 5 backports applied cleanly on our lazy.nvim layout.

## Next actions

- [x] Applied backports 1-5 on `dev` as 0182593, with the lockfile refresh in 484df0a.
- [x] Ran the 5 test checks above in a real nvim 0.12.6 session.
- [x] Updated the audited-against SHAs at the top of this doc.
- [x] Decided the migration: stay on lazy.nvim and defer the vim.pack project.
