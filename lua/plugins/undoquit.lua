-- Restore windows after :quit. lazy = false so QuitPre is hooked from startup.
-- _u = last closed split. _U = every split you closed in this tab.
-- Underscore then u / U, not <leader>u and not Vim's u (undo typing).
-- Does not restore :bd, neo-tree, or :q on the last window (that exits Neovim).
return {
  "andrewradev/undoquit.vim",
  lazy = false,
  init = function()
    vim.g.undoquit_mapping = "_u" -- last closed split
    vim.g.undoquit_tab_mapping = "_U" -- every split you closed in this tab
  end,
}
