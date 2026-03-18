vim.cmd("set expandtab")

vim.cmd("set tabstop=2")

vim.cmd("set softtabstop=2")

vim.cmd("set shiftwidth=2")

vim.g.mapleader= " "

-- Lazy Vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local opts = {}
require("lazy").setup("plugins")

-- Theme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Treesitter
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "ruby", "elixir"},
  highlight = { enable = true },
  indent = { enable = true }
})

--keymap for Neotree
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal float<CR>')