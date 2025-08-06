call plug#begin('~/.config/nvim/plugged')
  " --------------------------------------------------
  " 👉 Plugins installation
  " --------------------------------------------------

  " Search
  Plug 'nvim-lua/plenary.nvim' " co-dependent to telescope
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
  Plug 'nvim-telescope/telescope-live-grep-args.nvim' " Extends telescope and allows passing arguments to grep
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

  " AI
  " Plug 'supermaven-inc/supermaven-nvim'

  " Languages
  Plug 'vim-test/vim-test'
  Plug 'dense-analysis/ale'
  Plug 'jlcrochet/vim-ruby'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-rails'
  Plug 'maxmellon/vim-jsx-pretty'

  " https://lsp-zero.netlify.app/v4.x/template/vimscript-config.html
  " LSP-ZERO
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v4.x'}
  Plug 'j-hui/fidget.nvim' " Extensible UI for Neovim notifications and LSP progress messages.

  " Make it pretty
  Plug 'rktjmp/lush.nvim' " required for darcula-solid
  Plug 'briones-gabriel/darcula-solid.nvim'
  Plug 'HoNamDuong/hybrid.nvim'
  Plug 'mhartington/oceanic-next'
  Plug 'danilo-augusto/vim-afterglow'
  Plug 'projekt0n/github-nvim-theme'

  Plug 'vwxyutarooo/nerdtree-devicons-syntax' " needs vim-devicons
  Plug 'ryanoasis/vim-devicons' " Ensure it's the last plugin and install JetBrains Mono Nerd Font https://www.nerdfonts.com/font-downloads
call plug#end()

" --------------------------------------------------
" 👉 Switch themes instantly!
" --------------------------------------------------
colorscheme habamax
let g:airline_theme='tomorrow'

let g:theme_index = 0
let g:themes = ['habamax', 'hybrid', 'afterglow', 'darcula-solid', 'OceanicNext', 'github_dark_dimmed']

" Function to switch to the next theme
function! SwitchThemeNext()
  let g:theme_index = (g:theme_index + 1) % len(g:themes)
  execute 'colorscheme ' . g:themes[g:theme_index]
  echo "Theme: " . g:themes[g:theme_index]
endfunction

" Function to switch to the previous theme
function! SwitchThemePrev()
  let g:theme_index = (g:theme_index - 1 + len(g:themes)) % len(g:themes)
  execute 'colorscheme ' . g:themes[g:theme_index]
  echo "Theme: " . g:themes[g:theme_index]
endfunction

nnoremap <C-S-p> :call SwitchThemePrev()<CR>
nnoremap <C-S-n> :call SwitchThemeNext()<CR>
" --------------------------------------------------
" 👉 Notes!
" --------------------------------------------------

" Add to ZSH to switch tab colors
" function tabcolor {
"   echo -n -e "\033]6;1;bg;red;brightness;$1\a"
"   echo -n -e "\033]6;1;bg;green;brightness;$2\a"
"   echo -n -e "\033]6;1;bg;blue;brightness;$3\a"
" }
"
" tabcolor $(jot -r 1 0 255) $(jot -r 1 0 255) $(jot -r 1 0 255)

" Tips
" - ctrl + 6 (^) to switch between last file
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


" --------------------------------------------------
" 👉 Neovim settings
" --------------------------------------------------

" Relative lines
set relativenumber " set norelativenumber
let mapleader = "\<Space>"
nnoremap <c-'> :colorscheme
set background=dark
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
set number
set splitbelow splitright
set scroll=10
set scrolloff=10
set sidescrolloff=10
set ignorecase smartcase " make searches case-insensitive, unless they contain upper-case letters
tnoremap <Esc> <C-\><C-n>
inoremap jj <ESC> " escape insert mode

" Split windows
nnoremap <leader>d<Bslash> :split<cr>
nnoremap <leader><Bslash> :vsplit<cr>| ":vnew or :new for empty windows

" Navigate through tabs
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

" Paste by typign dry on insert mode
inoremap dry before { driven_by(:selenium_chrome) }

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

" --------------------------------------------------
" 👉 Plugins config
" --------------------------------------------------

" Supermaven
lua << EOF
-- require("supermaven-nvim").setup({
  -- You can pass any configuration options here
-- })
EOF

" LSP-ZERO config
" https://lsp-zero.netlify.app/v4.x/template/vimscript-config.html
lua <<EOF
  local lsp_zero = require('lsp-zero')

  local lsp_attach = function(client, bufnr)
    local opts = {buffer = bufnr}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end

  lsp_zero.extend_lspconfig({
    sign_text = true,
    lsp_attach = lsp_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  })

  require('mason').setup({})
  require('mason-lspconfig').setup({
    handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup({})
      end,
    }
  })

  local cmp = require('cmp')

  cmp.setup({
    sources = {
      {name = 'nvim_lsp'},
    },
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),
  })
EOF

" Fidget (LSP notifications)
lua <<EOF
  require("fidget").setup {
    -- options
  }
EOF

" vim-airline/vim-airline
" Note: airline theme is set above in theme context ex. let g:airline_theme='bubblegum'
let g:airline_section_c = '%f'
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

" For personal projects set these linters
" SetStandardLinter
" SetPrettierLinter

" NERDTree
" autocmd VimEnter * NERDTree | wincmd p "Start NERDTree and put the cursor back in the other window
let g:NERDTreeWinPos = "right"
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nrs :vertical resize 30<cr>
let NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize=40
let g:NERDTreeIgnore = ['^node_modules$','^tmp$']

" vim-test
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>ta :TestFile<CR>
let test#strategy = "floaterm"

" Float term
nnoremap <silent><leader>it :FloatermToggle<cr>
let g:floaterm_height = 0.5
let g:floaterm_wintype = 'split'

" ctrlsf
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_auto_focus = { 'at': 'start' }
nnoremap <leader>se :CtrlSF<Space>
nnoremap <leader>st :CtrlSFToggle<cr>'
let g:ctrlsf_compact_winsize = '80%'
let g:ctrlsf_auto_close = {'normal' : 0, 'compact': 0}
let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_position = 'bottom'

" Telescope
lua << EOF
  local telescope = require('telescope')
  local lga_actions = require("telescope-live-grep-args.actions")

  telescope.setup {
    defaults = {
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      layout_config = {
        anchor = 'CENTER',
        prompt_position = 'top',
        mirror = true,
        height = 0.8,
        width = 0.75,
      }
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            ["<C-space>"] = lga_actions.to_fuzzy_refine,
          }
        }
      }
    }
  }

  -- Telescope telescope-live-grep-args
  vim.keymap.set("n", "<leader>sf", function()
    require('telescope').extensions.live_grep_args.live_grep_args()
    -- It enables passing arguments to the grep command, rg examples:
    -- "foo" -t ruby find in ruby files
    -- foo → press <C-k> → "foo"  → "foo" -tmd
    -- Only works if you set up the <C-k> mapping
    -- --no-ignore foo
    -- foo bar" bazdir
    -- "foo" --iglob **/bar/**
  end)

  -- Searches for the word in the cursor while in normal mode
  local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
  vim.keymap.set("n", "<leader>gc", live_grep_args_shortcuts.grep_word_under_cursor)

  -- Buffer
  vim.keymap.set("n", "<leader>ef", function()
    require('telescope.builtin').buffers({
      previewer = false,
      layout_config = {
        height = 0.5,
        width = 0.7
      }
    })
  end)

  -- Find files
  vim.keymap.set("n", "<leader>ff", function()
    require('telescope.builtin').find_files({
      previewer = false,
      layout_config = {
        height = 0.5,
        width = 0.7
      }
    })
  end)
EOF
