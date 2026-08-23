-- Core editor settings. Loaded from init.lua BEFORE any plugin, because mapleader
-- has to exist before the plugin files register their <leader> mappings.

-- <leader> is a prefix key you press before a shortcut. Space is the convention.
-- Every "<leader>x" mapping in lua/plugins/ therefore means: press Space, then x.
vim.g.mapleader = " "

-- Indentation
vim.opt.expandtab = true     -- pressing Tab inserts spaces, never a literal tab character
vim.opt.tabstop = 2          -- an existing tab character renders 2 columns wide
vim.opt.softtabstop = 2      -- Tab/Backspace move by 2 spaces, so they feel like one unit
vim.opt.shiftwidth = 2       -- auto-indent and the >> / << commands shift by 2

-- Print the diagnostic message inline, to the right of the offending line.
-- Neovim 0.11+ ships this off by default: errors show only as a gutter sign,
-- which reads like the LSP is doing nothing. Use ]d / [d to jump between them.
vim.diagnostic.config({ virtual_text = true })
