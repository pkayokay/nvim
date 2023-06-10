call plug#begin('~/.config/nvim/plugged')
  Plug 'vim-test/vim-test'
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'ryanoasis/vim-devicons' "must be last plugin, need nerdfont compatible font https://www.nerdfonts.com/font-downloads
call plug#end()
 
" Notes
" :Commands for help 
" C is control
" S is shift
" can do commands above without <cr> to type but not execute, what is cr?
" Types of mapping and key binding definitions
" Feature I use in RubyMine/VSCode: auto-lint, go to reference, what else?


" Theme
colorscheme darcula
set termguicolors
set encoding=UTF-8 " for vim-devicons

" Bind insert mode escape to terminal
tnoremap <Esc> <C-\><C-n>


" General
inoremap jj <ESC>
set tabstop=2               " number of columns occupied by a tab character
set expandtab               " convert tabs to white space
set shiftwidth=2            " width for autoindents
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing


set nowrap " :set wrap! :set wrap 
let mapleader = "\<Space>"
set number 

" NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nrs :vertical resize 25<cr>
let NERDTreeQuitOnOpen = 1
let g:NERDTreeIgnore = ['^node_modules$','^tmp$']


" Fzf
noremap <leader>ff :GFiles<cr>
nnoremap <leader>sf :Rg<cr>
nnoremap <leader>ef :Buffer<cr>
nnoremap <leader>et :Windows<cr>
nnoremap <leader>sl :BLines<cr>
nnoremap <leader>sbl :Lines<cr>
let g:fzf_buffers_jump = 1 

" Window management
set splitbelow splitright
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


let test#strategy = "neovim"
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>ta :TestFile<CR>


" buffer
" "\<Leader\>be normal open
"\<Leader\>bt toggle open / close
"\<Leader\>bs force horizontal split open
"\<Leader\>bv force vertical split open
