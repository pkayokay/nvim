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

-- Display
vim.opt.number = true            -- gutter shows absolute line numbers
vim.opt.relativenumber = false   -- off: no distance-from-cursor numbers (for 5j / d3k)
vim.opt.cursorline = true        -- highlight the row the cursor is on
vim.opt.termguicolors = true     -- 24-bit colour; required by most Lua themes
vim.opt.background = "dark"      -- hint for default highlights; does not paint the UI
vim.opt.guicursor = "a:hor20-Cursor" -- horizontal bar cursor in every mode
vim.opt.wrap = false             -- long lines scroll sideways instead of wrapping

-- Splits / scrolling
vim.opt.splitbelow = true    -- :split opens the new window below, not above
vim.opt.splitright = true    -- :vsplit opens the new window to the right, not left
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>")  -- vertical split; opens right because of splitright
vim.keymap.set("n", "<leader>d\\", ":split<CR>")  -- horizontal split; opens below because of splitbelow
vim.opt.scroll = 10          -- Ctrl-d / Ctrl-u jump 10 lines (Neovim may reset this on resize)
vim.opt.scrolloff = 10       -- keep 10 lines visible above and below the cursor
vim.opt.sidescrolloff = 10   -- keep 10 columns visible beside the cursor (wrap is off)

-- Search / clipboard
vim.opt.ignorecase = true         -- /foo matches foo, Foo, FOO
vim.opt.smartcase = true          -- ignorecase unless the search contains a capital
vim.opt.clipboard = "unnamedplus" -- yank/delete/put use the OS clipboard (same as unnamed on macOS)

-- Print the diagnostic message inline, to the right of the offending line.
-- Neovim 0.11+ ships this off by default: errors show only as a gutter sign,
-- which reads like the LSP is doing nothing. Use ]d / [d to jump between them.
vim.diagnostic.config({ virtual_text = true })

-- Plugin-independent mappings, ported from reference/init.vim.

vim.keymap.set("i", "jj", "<Esc>") -- escape insert mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- :terminal: Esc leaves the shell; without this, press Ctrl-\ then Ctrl-n

-- Split navigation (stock is Ctrl-w then h/j/k/l)
vim.keymap.set("n", "<C-h>", "<C-w>h") -- left
vim.keymap.set("n", "<C-j>", "<C-w>j") -- down
vim.keymap.set("n", "<C-k>", "<C-w>k") -- up
vim.keymap.set("n", "<C-l>", "<C-w>l") -- right

-- Tabs (stock is :tabnew, gt/gT, {count}gt)
vim.keymap.set("n", "<leader><S-t>", ":tabnew<CR>") -- new tab
vim.keymap.set("n", "<leader>1", ":tabn 1<CR>") -- jump to tab 1
vim.keymap.set("n", "<leader>2", ":tabn 2<CR>") -- jump to tab 2
vim.keymap.set("n", "<leader>3", ":tabn 3<CR>") -- jump to tab 3
vim.keymap.set("n", "<leader>4", ":tabn 4<CR>") -- jump to tab 4

-- Delete the line without clobbering the yank register
vim.keymap.set("n", "<leader>D", '"_dd')
