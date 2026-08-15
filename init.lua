-- Entry point. How the pieces fit together:
--
--   vim-options.lua  -- core settings + mapleader. MUST run before lazy.setup, since the
--                       plugin files below register <leader> mappings at load time.
--   lua/plugins/     -- one file per concern, each returning a lazy.nvim spec:
--                         theme.lua       colorscheme (loads first, priority 1000)
--                         treesitter.lua  parsers -> highlighting + indent
--                         lsp-config.lua  mason installs servers/tools, lspconfig maps them
--                         none-ls.lua     runs mason's stylua/prettier as a formatting LSP
--                         telescope.lua   fuzzy finder; also hosts LSP code-action prompts
--                         neo-tree.lua    file explorer
--
-- Shared plumbing: plenary.nvim (telescope, neo-tree, none-ls) and mason.nvim
-- (lsp-config, and indirectly none-ls, which runs the binaries mason installs).

-- Lazy Vim: Package Manager
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
require("lazy").setup("plugins")
