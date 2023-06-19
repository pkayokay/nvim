call plug#begin('~/.config/nvim/plugged')
  " New Plugins here...



  " Search
  Plug 'nvim-lua/plenary.nvim' " co-dependent to telescope
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
  Plug 'dyng/ctrlsf.vim' " search/replace like sublime text
  Plug 'jlanzarotta/bufexplorer' " allows quicky deletion of buffers
  Plug 'ctrlpvim/ctrlp.vim' " file finder, multi select open 

  " Efficiency
  Plug 'andrewRadev/tagalong.vim' " Change an HTML(ish) opening tag and take the closing one along as well
  Plug 'tpope/vim-surround' " delete/change/add parentheses/quotes/XML-tags/much more with ease
  Plug 'tomtom/tcomment_vim' " An extensible & universal comment vim-plugin 
  Plug 'tpope/vim-endwise' "helps to end certain structures automatically. In Ruby, this means adding end after if, do, def and several other keywords.
  Plug 'chaoren/vim-wordmotion' " More useful word motions for Vim
  Plug 'Raimondi/delimitMate' " provides insert mode auto-completion for quotes, parens, brackets, etc.
  Plug 'rhysd/clever-f.vim' " Extended f, F, t and T key mappings for Vim.
  Plug 'tpope/vim-repeat' " repeat.vim: enable repeating supported plugin maps with .
  Plug 'andrewradev/undoquit.vim' " reopen the last window you closed

  " Misc 
  Plug 'tpope/vim-fugitive' " Git wrapper
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'voldikss/vim-floaterm'
  Plug 'preservim/nerdtree'

  " Languages
  Plug 'vim-test/vim-test'
  Plug 'dense-analysis/ale'
  Plug 'jlcrochet/vim-ruby'
  Plug 'pangloss/vim-javascript'

  " Make it pretty
  Plug 'doums/darcula'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'ryanoasis/vim-devicons' " Ensure it's the last plugin and install Nerd Font https://www.nerdfonts.com/font-downloads
call plug#end()

" CtrlP (Use rg (ripgrep) for ctrlp indexing, brew install ripgrep
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
endif

" :Commands for help
" TODO: find in files and multi select, buf explorer?, quick list for telescope?, grep, vim grep?
" https://github.com/carlhuda/janus
" https://github.com/excid3/dotfiles/blob/master/vim/vimrc
" https://github.com/wincent/ferret
" https://github.com/lfv89/vim-interestingwords
" https://github.com/t9md/vim-textmanip
" https://github.com/garbas/vim-snipmate
" https://github.com/tpope/vim-rails
" Ctags(definitions and even source code)
" Look at tips from Thoughtbot and plugins
" Look at Jason's setup too
" https://github.com/jeetsukumaran/vim-buffergator
" https://github.com/mg979/vim-visual-multi
" https://github.com/preservim/tagbar
" https://github.com/ervandew/supertab

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
nnoremap <C-i> :PlugInstall<cr> :qall!
tnoremap <Esc> <C-\><C-n>
tnoremap jj  <C-\><C-n>
inoremap jj <ESC>
nnoremap <leader>d<Bslash> :split<cr>
nnoremap <leader><Bslash> :vsplit<cr>| ":vnew or :new for empty windows
nnoremap <leader><S-t> :tabnew<cr>
nnoremap <leader>1 :tabn 1<cr>
nnoremap <leader>2 :tabn 2<cr>
nnoremap <leader>3 :tabn 3<cr>
nnoremap <leader>4 :tabn 4<cr>
" Navigation through windows
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
nnoremap <leader>[ :bn<cr>
nnoremap <leader>] :bp<cr>


" Undo quit
let g:undoquit_mapping = '_u'

" Clever F
let g:clever_f_smart_case = 1


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
" autocmd VimEnter * NERDTree | wincmd p "Start NERDTree and put the cursor back in the other window
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nrs :vertical resize 30<cr>
let NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize=30
let g:NERDTreeIgnore = ['^node_modules$','^tmp$']

" vim-test
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>ta :TestFile<CR>
let test#strategy = "floaterm"

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

" Custom command to find and replace in file
nnoremap <leader>fr :call FindAndReplace()<CR>
function! FindAndReplace()
    let find = input('Find: ')
    let replace = input('Replace with: ')
    execute '%s/' . find . '/' . replace . '/gc'
    redraw!
endfunction

" Telescope
lua << EOF
 require('telescope').setup {
    defaults = {
      path_display = { 'smart' },
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

" grep_string vs live_grep
nnoremap <leader>ff :lua require('telescope.builtin').find_files({previewer=false, layout_config={height=0.3,width=0.5}})<cr>
nnoremap <leader>ef :lua require('telescope.builtin').buffers({previewer=false, layout_config={height=0.3,width=0.5}})<cr>
nnoremap <leader>sf :lua require'telescope.builtin'.grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' }<cr>
