-- Project search + edit (Sublime-style). Uses ripgrep if installed.
--
--   ctrlsf.vim
--
--   <leader>se  prompt :CtrlSF  (type a query, Enter)
--   <leader>st  hide/show the results panel
--
-- Results are a buffer: edit match lines, :w writes them back to the files.
-- Then :%s in that buffer + :w is project replace on the search you just ran.
--
-- Try grug-far later for the same search-then-replace flow (not added yet).
--
-- regex_pattern: query is a regex (same as old init.vim).
-- auto_focus at start: jump into the results when the search finishes.
-- Bottom panel, normal view (context around matches). Don't auto-close
-- when you open a file. compact_winsize only applies if you switch to
-- compact view (M in the results).

return {
  "dyng/ctrlsf.vim",
  cmd = { "CtrlSF", "CtrlSFToggle", "CtrlSFOpen", "CtrlSFUpdate" },
  init = function()
    vim.g.ctrlsf_regex_pattern = 1
    vim.g.ctrlsf_auto_focus = { at = "start" }
    vim.g.ctrlsf_compact_winsize = "80%"
    vim.g.ctrlsf_auto_close = { normal = 0, compact = 0 }
    vim.g.ctrlsf_default_view_mode = "normal"
    vim.g.ctrlsf_position = "bottom"
  end,
  keys = {
    { "<leader>se", ":CtrlSF ", silent = false }, -- type a query after this
    { "<leader>st", "<cmd>CtrlSFToggle<CR>" },
  },
}
