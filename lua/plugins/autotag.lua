-- HTML / JSX / TSX tags. No new keys: it hooks insert and InsertLeave.
--
--   nvim-ts-autotag
--
--   Close:  type <div> then >           <div></div>  (cursor in the middle)
--   Rename: ciwspan then Esc on <div>   <span></span> (both ends)
--
-- Needs a treesitter parser for that filetype. html / javascript / tsx
-- are in treesitter.lua. Stock Vim does neither. surround `cst` is the
-- manual rename if you want to type the new tag yourself.

return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true, -- <div> then > -> <div></div>
        enable_rename = true, -- rename opener, closer follows
        enable_close_on_slash = false, -- </ then tag name; off (noisy)
      },
    })
  end,
}
