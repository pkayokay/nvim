-- Subword motions. Stock w / b / e skip a whole `foo_bar` or `getUserName`.
-- This plugin stops on each piece (and on `.` `-` digits).
--
--   vim-wordmotion
--
--   Cursor on getUserName
--   What     Stock w          wordmotion w
--   Stops    whole identifier get, then User, then Name
--
-- W / B / E are unchanged (whitespace-separated WORDs).
-- Also remaps aw / iw text objects the same way.
-- lazy = false so w/b/e are remapped from startup.

return {
  "chaoren/vim-wordmotion",
  lazy = false,
}
