-- Luacheck configuration for Neovim
-- Relaxed mode: allow Neovim globals and common patterns

-- Ignore warnings about line length
codes = true

-- Allow defining globals
allow_defined = true

-- Neovim-specific globals
globals = {
  "vim",
  "MiniFiles", -- Your custom plugin global
}

-- Read-only globals (can use but not modify)
read_globals = {
  "describe",
  "it",
  "before_each",
  "after_each",
  "setup",
  "teardown",
}

-- Ignore certain warnings
ignore = {
  "212", -- Unused argument (common in callbacks)
  "213", -- Unused loop variable
  "631", -- Line is too long (handled by stylua)
}

-- Exclude certain directories/files
exclude_files = {
  ".git/",
  "plugin/", -- Ignore auto-generated plugin directory
  "lazy-lock.json",
}

-- Set maximum line length (relaxed)
max_line_length = 120

-- Allow unused arguments starting with underscore
unused_args = false
unused = false
