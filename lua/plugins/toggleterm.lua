-- Persistent terminal. <leader>it toggles it.
--
--   toggleterm.nvim
--
-- Floating window, rounded border. First press opens a shell; again hides
-- it; again shows the same session still running. Esc leaves the shell
-- (vim-options.lua).

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    start_in_insert = true,
  },
  keys = {
    { "<leader>it", "<cmd>ToggleTerm<CR>" },
  },
}
