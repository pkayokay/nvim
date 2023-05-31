call plug#begin('~/.config/nvim/plugged')
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
call plug#end()


" Ways to start NERDTree https://github.com/preservim/nerdtree#how-do-i-open-nerdtree-automatically-when-vim-starts
" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree

colorscheme darcula
set termguicolors


