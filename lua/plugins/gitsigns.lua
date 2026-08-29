-- Git signs in the gutter (the column left of the line numbers): added,
-- changed, and deleted lines vs HEAD.
--
-- Colors come from afterglow-monokai (GitSignsAdd / Change / Delete).
-- signs_staged_enable = false: only unstaged hunks in the gutter (no second
-- sign set for staged).
--
-- Not the same as lualine's branch/diff counts (that's a summary in the bar)
-- or visual Ctrl-b blame (that's in vim-options.lua).
--
-- Signs only: no on_attach keymaps. Use :Gitsigns for hunk actions, or visual
-- Ctrl-b for blame. Plugin-suggested ]c / <leader>hs / … are not enabled.

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- Defaults are all ┃ except delete.
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~_" },
    },
    signs_staged_enable = false,
  },
  config = function(_, opts)
    vim.opt.signcolumn = "yes" -- always show the gutter column (default auto hides until signs exist)
    require("gitsigns").setup(opts)
  end,
}
