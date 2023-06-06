call plug#begin('~/.config/nvim/plugged')
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
call plug#end()

set shiftwidth=2
set nowrap " :set wrap! :set wrap 
let mapleader = "\<Space>"

" Ways to start NERDTree https://github.com/preservim/nerdtree#how-do-i-open-nerdtree-automatically-when-vim-starts
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>ntf :NERDTreeFocus<CR>
nnoremap <leader>nts :NERDTreeFind<CR>


"C is control
" S is shift

" Darcula
colorscheme darcula
" set termguicolors



" General
set number


" Fzf
" :Commands for help 
nnoremap <leader>ff :GFiles<cr>
nnoremap <leader>sf :Rg<cr>
nnoremap <leader>ef :Windows<cr>


inoremap jj <ESC>
nnoremap <leader>rst :vertical resize 25<cr>
