call plug#begin('~/.config/nvim/plugged')
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'ryanoasis/vim-devicons' " need nerdfont compatible font
call plug#end()

" Notes
" :Commands for help 
" C is control
" S is shift
" can do commands above without <cr> to type but not execute, what is cr?

" Theme
colorscheme darcula

" General
inoremap jj <ESC>
set shiftwidth=2
set nowrap " :set wrap! :set wrap 
let mapleader = "\<Space>"
set number 
set encoding=UTF-8 " for vim-devicons

" NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>ntf :NERDTreeFocus<CR>
nnoremap <leader>nts :NERDTreeFind<CR>
nnoremap <leader>nts :vertical resize 25<cr>

" Fzf
nnoremap <leader>ff :GFiles<cr>
nnoremap <leader>sf :Rg<cr>
nnoremap <leader>ef :Windows<cr>


" Window management
set splitbelow
set splitright
nnoremap <leader>d<Bslash> :split<cr>
nnoremap <leader><Bslash> :vsplit<cr>| ":vnew or :new for empty windows

" Search and replace, bind inputs?
nnoremap <leader>sr :%s/search/replace/g 
