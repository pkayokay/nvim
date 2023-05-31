call plug#begin('~/.config/nvim/plugged')
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
call plug#end()

let mapleader = "\<Space>"

" Ways to start NERDTree https://github.com/preservim/nerdtree#how-do-i-open-nerdtree-automatically-when-vim-starts
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
nnoremap <leader>b :NERDTreeToggle<CR>
nnoremap <leader>k :NERDTreeFocus<CR>
nnoremap <C-r> :NERDTreeFind<CR>

" Darcula
colorscheme habamax
" set termguicolors



" General
set number


" Fzf
nnoremap <leader>ff :GFiles<cr>
nnoremap <leader>sf :Rg<cr>
