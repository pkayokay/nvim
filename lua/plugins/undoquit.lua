-- Reopen the last window you closed with :quit (like restore-tab in a browser).
--
--   undoquit.vim   -- stacks each :quit and puts the window back
--
-- Use: two splits, :q one by accident, then _u. The split comes back with the
-- same buffer (same file), in the same place — not an empty window.
-- Close several splits, _u restores them one at a time (a stack). That includes
-- windows you closed in another tab, not only the current one.
-- Whole tab: Ctrl-w U restores a tab's worth of closed windows (plugin default).
-- :tabclose is not always on that stack; :UndoableTabclose is the plugin's
-- tab-close that can be undone.
--
-- Not: Vim's u (undo typing). Not :bd (buffer still in the window).
-- Not neo-tree / quickfix / unlisted buffers. Not :q on the last window
-- (that quits Neovim, so there is nothing left to restore).
--
-- lazy = false so it can hook QuitPre from startup. If it only loaded on _u,
-- it would have no history to restore.
-- Mapping is underscore then u (not <leader>u). Plugin default is Ctrl-w u.

return {
  "andrewradev/undoquit.vim",
  lazy = false,
  init = function()
    vim.g.undoquit_mapping = "_u"
  end,
}
