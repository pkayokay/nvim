-- Entry point. See README.md for the tour; each file in lua/plugins/ documents itself.
-- The one ordering rule: vim-options must load before lazy.setup, because it sets
-- mapleader and the plugin files register <leader> mappings as they load.

-- lazy.nvim: package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins", {
  rocks = { enabled = false }, -- no plugins need luarocks; silences hererocks checkhealth error
})
