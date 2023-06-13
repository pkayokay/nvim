call plug#begin('~/.config/nvim/plugged')
  Plug 'dyng/ctrlsf.vim'
  " Plug 'ctrlpvim/ctrlp.vim' 
  Plug 'vim-test/vim-test'
  Plug 'voldikss/vim-floaterm'
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'chaoren/vim-wordmotion'
  Plug 'pangloss/vim-javascript'
  Plug 'tomtom/tcomment_vim'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'dense-analysis/ale'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'jlcrochet/vim-ruby'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'ryanoasis/vim-devicons' " Ensure it's the last plugin and install Nerd Font https://www.nerdfonts.com/font-downloads
call plug#end()

" :Commands for help
" General
"
" TODO: copy out of vim, delete word backwards, find in files and multi select (ctrlp?), buf explorer?
set clipboard=unnamed
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
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" NERDTree
autocmd VimEnter * NERDTree | wincmd p "Start NERDTree and put the cursor back in the other window
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nrs :vertical resize 30<cr>
let NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize=30
let g:NERDTreeIgnore = ['^node_modules$','^tmp$']


" CtrlSF
let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_default_view_mode = 'compact' 
nnoremap <leader>sf :CtrlSF 
nnoremap <leader>st :CtrlSFToggle<cr>
let g:ctrlsf_compact_winsize = '30%'
let g:ctrlsf_regex_pattern = 1

" FZF
let g:fzf_buffers_jump = 1 " Always open buffer in existing tab
noremap <leader>ff :GFilesCustom<cr>
nnoremap <leader>qf :Rg<cr>
nnoremap <leader>ef :Buffer<cr>
nnoremap <leader>et :Windows<cr>
nnoremap <leader>sl :BLines<cr>
nnoremap <leader>sbl :Lines<cr>

let $BAT_THEME="" " brew install bat, used for Fzf previews
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --margin=0 --padding=0 --border=rounded'
let g:original_fzf_layout_values = { 'window': { 'width': 0.6, 'height': 0.9, 'relative': v:false, 'yoffset': 0} }
let g:fzf_preview_window_values = ['down,70%', 'ctrl-/']
let g:fzf_layout = g:original_fzf_layout_values
let g:fzf_preview_window = g:fzf_preview_window_values


" Hide preview for GFiles
" autocmd VimEnter * command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': '--no-preview'}, <bang>0)
" Bind custom command so fzf_layout window is smaller for GFiles
autocmd VimEnter * command! -bang -nargs=? GFilesCustom call CustomFzfLayout(<q-args>, <bang>0)
function! CustomFzfLayout(args, bang)
  let g:fzf_preview_window = []
  let g:fzf_layout = { 'window': { 'width': 0.4, 'height': 0.4, 'relative': v:false, 'yoffset': 0} }

  execute 'silent! GFiles ' . a:args . (a:bang ? '!' : '')
  let g:fzf_layout = g:original_fzf_layout_values
  let g:fzf_preview_window = g:fzf_preview_window_values
endfunction
" end of FZF

" Tabs
nnoremap <leader><S-t> :tabnew<cr>
nnoremap <leader>1 :tabn 1<cr>
nnoremap <leader>2 :tabn 2<cr>
nnoremap <leader>3 :tabn 3<cr>
nnoremap <leader>4 :tabn 4<cr>

" vim-test
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>ta :TestFile<CR>
let test#strategy = "floaterm"
