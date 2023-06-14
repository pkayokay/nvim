call plug#begin('~/.config/nvim/plugged')
  Plug 'Raimondi/delimitMate' " provides insert mode auto-completion for quotes, parens, brackets, etc.
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
  Plug 'dyng/ctrlsf.vim'
  Plug 'vim-test/vim-test'
  Plug 'voldikss/vim-floaterm'
  Plug 'doums/darcula'
  Plug 'preservim/nerdtree'
  Plug 'andrewRadev/tagalong.vim' " Change an HTML(ish) opening tag and take the closing one along as well
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'chaoren/vim-wordmotion'
  Plug 'pangloss/vim-javascript'
  Plug 'tomtom/tcomment_vim'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'tpope/vim-endwise' "helps to end certain structures automatically. In Ruby, this means adding end after if, do, def and several other keywords.
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'dense-analysis/ale'
  Plug 'jlanzarotta/bufexplorer'
  Plug  'AndrewRadev/writable_search.vim'
  Plug 'jlcrochet/vim-ruby'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'ryanoasis/vim-devicons' " Ensure it's the last plugin and install Nerd Font https://www.nerdfonts.com/font-downloads
call plug#end()


" :Commands for help
" TODO: delete word backwards, find in files and multi select, buf explorer?, quick list for telescope?, grep, vim grep?
" https://github.com/wincent/ferret
" https://github.com/lfv89/vim-interestingwords
" https://github.com/AndrewRadev/writable_search.vim
" https://github.com/AndrewRadev/undoquit.vim
" https://github.com/t9md/vim-textmanip
" https://github.com/tpope/vim-repeat
" https://github.com/rhysd/clever-f.vim
" https://github.com/nvim-telescope/telescope-fzf-native.nvim

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


" Float term
nnoremap <silent><leader>it :FloatermToggle<cr>
let g:floaterm_height = 0.3
let g:floaterm_wintype = 'split'

" CtrlSF
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_auto_focus = { 'at': 'start' }
nnoremap <leader>se :CtrlSF
nnoremap <leader>st :CtrlSFToggle<cr>'
let g:ctrlsf_compact_winsize = '30%'
let g:ctrlsf_auto_close = {'normal' : 0, 'compact': 0}

let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_position = 'bottom'
" nnoremap <leader>sr :%s/
nnoremap <leader>sr :call PromptSubstitution()<CR>
function! PromptSubstitution()
    let find = input('Find: ')
    let replace = input('Replace with: ')
    execute '%s/' . find . '/' . replace . '/gc'
    redraw!
endfunction

" FZF
let g:fzf_buffers_jump = 1 " Always open buffer in existing tab
" noremap <leader>ff :GFilesCustom<cr>
" nnoremap <leader>sf :Rg<cr>
" nnoremap <leader>ef :BufferCustom<cr>
nnoremap <leader>et :WindowsCustom<cr>
nnoremap <leader>sl :BLinesCustom<cr>

let $FZF_DEFAULT_OPTS = '--layout=reverse --no-info --margin=0 --padding=0 --border=rounded --pointer=👉'
let g:original_fzf_layout_values = { 'window': { 'width': 0.6, 'height': 0.8, 'relative': v:false,} }
let g:fzf_preview_window_values = ['down,60%', 'ctrl-/']
let g:fzf_layout = g:original_fzf_layout_values
let g:fzf_preview_window = g:fzf_preview_window_values


" Bind custom command so fzf_layout window is smaller for GFiles
autocmd VimEnter * command! -bang -nargs=? GFilesCustom call CustomFzfLayout(<q-args>, <bang>0, 'GFiles')
autocmd VimEnter * command! -bang -nargs=? BufferCustom call CustomFzfLayout(<q-args>, <bang>0, 'Buffers')
autocmd VimEnter * command! -bang -nargs=? WindowsCustom call CustomFzfLayout(<q-args>, <bang>0, 'Windows')
autocmd VimEnter * command! -bang -nargs=? BLinesCustom call CustomFzfLayout(<q-args>, <bang>0, 'BLines')

function! CustomFzfLayout(args, bang, command)
  let g:fzf_preview_window = []
  let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.4, 'relative': v:false } }

  execute 'silent! ' a:command . ' '. a:args . (a:bang ? '!' : '')
  let g:fzf_layout = g:original_fzf_layout_values
  let g:fzf_preview_window = g:fzf_preview_window_values
endfunction

" Telescope
lua << EOF
 require('telescope').setup {
    defaults = {
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        prompt_position = 'top',
        mirror = true,
        height = 0.8,
        width = 0.6,
      }
    }
  }
EOF

" nnoremap <leader>ff :Telescope find_files<cr>
" ex. override defaults
nnoremap <leader>ff :lua require('telescope.builtin').find_files({previewer=false, layout_config={mirror=false,height=0.3,width=0.5}})<cr>
nnoremap <leader>ef :lua require('telescope.builtin').buffers({previewer=false, layout_config={mirror=false,height=0.3,width=0.5}})<cr>
nnoremap <leader>sf :Telescope live_grep<cr>


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
