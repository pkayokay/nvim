call plug#begin('~/.config/nvim/plugged')
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'ryanoasis/vim-devicons' "must be last plugin, need nerdfont compatible font https://www.nerdfonts.com/font-downloads
call plug#end()

" Notes
" :Commands for help 
" C is control
" S is shift
" can do commands above without <cr> to type but not execute, what is cr?

" Theme
colorscheme darcula
set termguicolors

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
nnoremap <leader>ntrs :vertical resize 25<cr>
let NERDTreeQuitOnOpen = 1


" Fzf
nnoremap <leader>ff :GFiles<cr>
nnoremap <leader>sf :Rg<cr>
nnoremap <leader>ef :Windows<cr>


" Window management
set splitbelow
set splitright
nnoremap <leader>d<Bslash> :split<cr>
nnoremap <leader><Bslash> :vsplit<cr>| ":vnew or :new for empty windows

" Tab
nnoremap <leader><S-t> :tabnew<cr>
nnoremap <leader>1 :tabn 1<cr>
nnoremap <leader>2 :tabn 2<cr>
nnoremap <leader>3 :tabn 3<cr>
nnoremap <leader>4 :tabn 4<cr>

" Search and replace, bind inputs?
nnoremap <leader>sr :%s/search/replace/g 
