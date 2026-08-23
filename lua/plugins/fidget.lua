-- Corner overlay for LSP progress (e.g. "ruby_lsp: indexing…").
--
--   fidget.nvim   -- its own window; does not need airline/lualine
--
-- vim.notify() is Neovim's built-in toast function (used by git blame in
-- vim-options.lua). Fidget can also become that backend, but only if
-- notification.override_vim_notify is true — default is false, same as here,
-- so vim.notify still goes to the echo area / :messages.
--
-- winblend = 0 makes the overlay fully opaque. Fidget's default is 100
-- (transparent), which on a see-through terminal can make the text vanish.
return {
  "j-hui/fidget.nvim",
  opts = {
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
}
