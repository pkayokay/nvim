-- Edit the wrappers around text (quotes, parens, tags). Stock Vim already
-- edits the insides; this adds, changes, or deletes the wrappers themselves.
--
--   vim-surround
--   vim-repeat      so `.` repeats cs / ds / ys
--
--   On `"foo"` or `foo`
--   What          Stock                      surround
--   Change word   ciw  foo -> (insert)       (stock, not this plugin)
--   Change inside ci"  "foo" -> "" (insert)  (stock, not this plugin)
--   Delete around da"  "foo" -> (gone)       (stock, not this plugin)
--   Drop wrappers none                       ds"   "foo" -> foo
--   Swap wrappers none                       cs"'  "foo" -> 'foo'
--   Add wrappers  none                       ysiw) foo   -> (foo)
--
--   ciw    change inner word (stock). foo -> word gone, insert mode
--   iw     inner word (stock). same object as ciw / diw / yiw / ysiw
--   ys     you surround + motion + wrapper. ysiw)  foo -> (foo)
--   ysiw)  you surround inner word with (). foo -> (foo)
--   yss"   you surround this line with quotes. foo bar -> "foo bar"
--   cs"'   change surround. "foo" -> 'foo'
--   ds"    delete surround. "foo" -> foo
--   visual S)  wrap the selection with (). foo -> (foo)
--
-- lazy = false so cs / ds / ys exist from startup.

return {
  "tpope/vim-surround",
  dependencies = { "tpope/vim-repeat" },
  lazy = false,
}
