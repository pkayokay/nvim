-- Core editor settings. Loaded from init.lua BEFORE any plugin, because mapleader
-- has to exist before the plugin files register their <leader> mappings.

vim.cmd("set expandtab")     -- pressing Tab inserts spaces, never a literal tab character
vim.cmd("set tabstop=2")     -- an existing tab character renders 2 columns wide
vim.cmd("set softtabstop=2") -- Tab/Backspace move by 2 spaces, so they feel like one unit
vim.cmd("set shiftwidth=2")  -- auto-indent and the >> / << commands shift by 2

-- <leader> is a prefix key you press before a shortcut. Space is the convention.
-- Every "<leader>x" mapping in lua/plugins/ therefore means: press Space, then x.
vim.g.mapleader = " "
