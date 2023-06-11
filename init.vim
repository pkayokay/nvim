call plug#begin('~/.config/nvim/plugged')
  Plug 'vim-test/vim-test'
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'chaoren/vim-wordmotion'
  Plug 'pangloss/vim-javascript'
  Plug 'tomtom/tcomment_vim'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'tpope/vim-endwise'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'dense-analysis/ale'
  Plug 'jlcrochet/vim-ruby'
  Plug 'ryanoasis/vim-devicons' " Ensure it's the last plugin and install Nerd Font https://www.nerdfonts.com/font-downloads
call plug#end()

" :Commands for help 
" General

let g:airline_theme='wombat'
let mapleader = "\<Space>"
colorscheme darcula
set termguicolors
set encoding=UTF-8 " for vim-devicons
set tabstop=2               " number of columns occupied by a tab character
set expandtab               " convert tabs to white space
set shiftwidth=2            " width for autoindents
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set nowrap " :set wrap! :set wrap 
let mapleader = "\<Space>"
set number
set splitbelow splitright
set scrolloff=10 sidescrolloff=20
set ignorecase smartcase " make searches case-insensitive, unless they contain upper-case letters
nnoremap <C-p> :PlugInstall<cr> :qall!
tnoremap <Esc> <C-\><C-n>
tnoremap jj  <C-\><C-n>
inoremap jj <ESC> 
nnoremap <silent><leader>it :terminal<cr>i
nnoremap <leader>d<Bslash> :split<cr>
nnoremap <leader><Bslash> :vsplit<cr>| ":vnew or :new for empty windows

" ALE 
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_linters = { 'ruby': ['ruby','standardrb'], 'eruby': ['erblint']}
let g:ale_fixers = { 'javascript': ['prettier'], 'ruby': ['standardrb'], 'eruby': ['erblint']}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'



" NERDTree
" Start NERDTree and put the cursor back in the other window (autocmd VimEnter * NERDTree | wincmd p)
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nrs :vertical resize 25<cr>
let NERDTreeQuitOnOpen = 1
let g:NERDTreeIgnore = ['^node_modules$','^tmp$']

" Fzf
let g:fzf_buffers_jump = 1 " Always open buffer in existing tab
noremap <leader>ff :GFiles<cr>
nnoremap <leader>sf :Rg<cr>
nnoremap <leader>ef :Buffer<cr>
nnoremap <leader>et :Windows<cr>
nnoremap <leader>sl :BLines<cr>
nnoremap <leader>sbl :Lines<cr>
autocmd VimEnter * command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': ['--no-preview']}, <bang>0)
let $BAT_THEME="" " brew install bat, used for Fzf previews
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.4, 'relative': v:false, 'yoffset': 0 } } " relative false opens the existing window, otherwise it opens in the split window
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --margin=1 --padding=1' " show on top, make smaller and center?

" Tabs
nnoremap <leader><S-t> :tabnew<cr>
nnoremap <leader>1 :tabn 1<cr>
nnoremap <leader>2 :tabn 2<cr>
nnoremap <leader>3 :tabn 3<cr>
nnoremap <leader>4 :tabn 4<cr>

" vim-test
let test#strategy = "neovim"
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>ta :TestFile<CR>
