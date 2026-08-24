call plug#begin('~/.config/nvim/plugged')
  " --------------------------------------------------
  " 👉 Plugins installation
  " --------------------------------------------------

  " Efficiency
  Plug 'andrewRadev/tagalong.vim' " Change an HTML(ish) opening tag and take the closing one along as well
  Plug 'mg979/vim-visual-multi' " Multiple cursors plugin for vim/neovim, for vertical section enter v-block then shift+i insert mode

  " Misc
  Plug 'tpope/vim-fugitive' " Git wrapper

  " Languages
  Plug 'tpope/vim-rails'
call plug#end()

" --------------------------------------------------
" 👉 Notes!
" --------------------------------------------------

" Add to ZSH to switch tab colors
" function tabcolor {
"   echo -n -e "\033]6;1;bg;red;brightness;$1\a"
"   echo -n -e "\033]6;1;bg;green;brightness;$2\a"
"   echo -n -e "\033]6;1;bg;blue;brightness;$3\a"
" }
"
" tabcolor $(jot -r 1 0 255) $(jot -r 1 0 255) $(jot -r 1 0 255)

" Tips
" - ctrl + 6 (^) to switch between last file
" - [c i ""] -> change inside "something" it deletes what's inside the quotes and put you on I mode
" - [d a ""] -> delete around it deletes what's inside and quotes, keeps you normal mode
" - [d a w] -> delete around word
" - [g i] -> jump to where you were last inserted
" - [c i] or [c o] jump list (ex. jump from efinition and back) (:jumps)
" - I beginning of line insert mode
" - A end of line insert mode
" shift + i -> beggining of line in insert mode
" shift + $ -> end of line
" vertical cursor, ctrl + v, shift + I or A


" --------------------------------------------------
" 👉 Neovim settings
" --------------------------------------------------
" Ported `set` options live in lua/vim-options.lua.
" encoding=UTF-8 was dropped: Neovim is UTF-8 always.


