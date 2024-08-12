call plug#begin('~/.config/nvim/plugged')
  " New Plugins here...

  " Search
  Plug 'nvim-lua/plenary.nvim' " co-dependent to telescope
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
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
  " Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab
  Plug 'mg979/vim-visual-multi' " Multiple cursors plugin for vim/neovim, for vertical section enter v-block then shift+i insert mode
  Plug 'tyru/open-browser.vim'
  Plug 'tyru/open-browser-github.vim' " Open Github from code
  Plug 'airblade/vim-gitgutter' " Diff changes on the side

  " Misc
  Plug 'tpope/vim-fugitive' " Git wrapper
  Plug 'vim-airline/vim-airline' " Status bar
  Plug 'vim-airline/vim-airline-themes' " Status bar themes
  Plug 'voldikss/vim-floaterm' " floating terminal
  Plug 'preservim/nerdtree' " Tree navigation

  " Languages
  Plug 'vim-test/vim-test'
  Plug 'dense-analysis/ale'
  Plug 'jlcrochet/vim-ruby'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-rails'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Make it pretty
  Plug 'rktjmp/lush.nvim' " required for darcula-solid
  Plug 'briones-gabriel/darcula-solid.nvim'
  Plug 'HoNamDuong/hybrid.nvim'
  Plug 'mhartington/oceanic-next'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
  Plug 'ryanoasis/vim-devicons' " Ensure it's the last plugin and install Nerd Font https://www.nerdfonts.com/font-downloads
call plug#end()


" Add to ZSH to switch tab colors
" function tabcolor {
"   echo -n -e "\033]6;1;bg;red;brightness;$1\a"
"   echo -n -e "\033]6;1;bg;green;brightness;$2\a"
"   echo -n -e "\033]6;1;bg;blue;brightness;$3\a"
" }
"
" tabcolor $(jot -r 1 0 255) $(jot -r 1 0 255) $(jot -r 1 0 255)

" Tips
" - [c i ""] -> change inside "something" it deletes what's inside the quotes and put you on I mode
" - [d a ""] -> delete around it deletes what's inside and quotes, keeps you normal mode
" - [d a w] -> delete around word
" - [g i] -> jump to where you were last inserted
" - [c i] or [c o] jump list (ex. jump from efinition and back) (:jumps)
" - I beginning of line insert mode
" - A end of line insert mode
" shift + i -> beggining of line in insert mode
" shift + $ -> end of line
" vertical cursor, ctrl + v, shift + I or A

" ------Generic-------
  " Relative lines
set relativenumber
" Paste by typign dry on insert mode
inoremap dry before { driven_by(:selenium_chrome) }
let mapleader = "\<Space>"
nnoremap <c-'> :colorscheme
set background=dark
colorscheme hybrid
set termguicolors
set cursorline
set guicursor=a:hor20-Cursor
" set gdefault " assume /g flag on for :s subtitutions
set clipboard=unnamed
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
tnoremap <Esc> <C-\><C-n>
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


" Git blame
vmap <c-b> :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>,<C-R>=line("'>") <CR>p <CR>

" Custom command to find and replace in file
nnoremap <leader>fr :call FindAndReplace()<CR>
function! FindAndReplace()
    let find = input('Find: ')
    let replace = input('Replace with: ')
    execute '%s/' . find . '/' . replace . '/gc'
    redraw!
endfunction

" ------Plugins-------
"  coc.vim
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ "\<CR>"

" vim-airline/vim-airline
let g:airline_theme='bubblegum'
let g:airline_section_c = '%t'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_extensions = []
let g:SuperTabDefaultCompletionType = "<c-n>" " sort order for supertab plugin

" vim-gitgutter
let g:gitgutter_enabled = 1
highlight GitGutterAdd    guifg=#859c61 ctermfg=2
highlight GitGutterChange guifg=#f9c269 ctermfg=3
highlight GitGutterDelete guifg=#c77532 ctermfg=1
highlight Directory guifg=#cacbcd

" open-browser-github
vnoremap <c-\> :OpenGithubFile<cr>
let g:openbrowser_github_always_used_branch = 'main'

" ctrlp (Use rg (ripgrep) for ctrlp indexing, brew install ripgrep
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
endif

" undoquit
let g:undoquit_mapping = '_u'

" clever-f
let g:clever_f_smart_case = 1

" ALE
" npm install -g prettier && gem install standard
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'ruby': ['rubocop'],
\   'eruby': ['erblint'],
\ }

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'ruby': ['rubocop'],
\   'eruby': ['erblint'],
\ }

function! SetPrettierLinter()
  let g:ale_linters['javascript'] = ['prettier']
  let g:ale_linters['javascriptreact'] = ['prettier']
  let g:ale_linters['typescript'] = ['prettier']
  let g:ale_linters['typescriptreact'] = ['prettier']
  let g:ale_fixers['javascript'] = ['prettier']
  let g:ale_fixers['javascriptreact'] = ['prettier']
  let g:ale_fixers['typescript'] = ['prettier']
  let g:ale_fixers['typescriptreact'] = ['prettier']
endfunction
command! SetPrettierLinter call SetPrettierLinter()

function! SetStandardLinter()
  let g:ale_linters['ruby'] = ['standardrb']
  let g:ale_fixers['ruby'] = ['standardrb']
endfunction
command! SetStandardLinter call SetStandardLinter()

" NERDTree
" autocmd VimEnter * NERDTree | wincmd p "Start NERDTree and put the cursor back in the other window
let g:NERDTreeWinPos = "right"
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
let g:floaterm_height = 0.4
let g:floaterm_wintype = 'split'

" ctrlsf
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_auto_focus = { 'at': 'start' }
nnoremap <leader>se :CtrlSF
nnoremap <leader>st :CtrlSFToggle<cr>'
let g:ctrlsf_compact_winsize = '30%'
let g:ctrlsf_auto_close = {'normal' : 0, 'compact': 0}
let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_position = 'bottom'

" telescope
lua << EOF
 require('telescope').setup {
    defaults = {
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        anchor = 'CENTER',
        prompt_position = 'top',
        mirror = true,
        height = 0.8,
        width = 0.8,
      }
    }
  }
EOF

nnoremap <leader>ef :lua require('telescope.builtin').buffers({previewer=false, layout_config={height=0.4,width=0.6}})<cr>
nnoremap <leader>ff :lua require('telescope.builtin').find_files({previewer=false, layout_config={height=0.4,width=0.6}})<cr>
noremap <leader>sf :lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({preview=false,layout_config = {width = 0.8, anchor = 'N'}, path_display={'smart'},shorten_path = true, word_match = "-w", only_sort_text = true, search = '' }))<cr>
