call plug#begin('~/.config/nvim/plugged')
  " --------------------------------------------------
  " 👉 Plugins installation
  " --------------------------------------------------

  " Search
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
  Plug 'mg979/vim-visual-multi' " Multiple cursors plugin for vim/neovim, for vertical section enter v-block then shift+i insert mode
  Plug 'tyru/open-browser.vim'
  Plug 'tyru/open-browser-github.vim' " Open Github from code
  Plug 'airblade/vim-gitgutter' " Diff changes on the side

  " Misc
  Plug 'tpope/vim-fugitive' " Git wrapper
  Plug 'voldikss/vim-floaterm' " floating terminal
  Plug 'preservim/nerdtree' " Tree navigation

  " Languages
  Plug 'vim-test/vim-test'
  Plug 'dense-analysis/ale'
  Plug 'jlcrochet/vim-ruby'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-rails'
  Plug 'maxmellon/vim-jsx-pretty'

  " Make it pretty
  Plug 'vwxyutarooo/nerdtree-devicons-syntax' " needs vim-devicons
  Plug 'ryanoasis/vim-devicons' " Ensure it's the last plugin and install JetBrains Mono Nerd Font https://www.nerdfonts.com/font-downloads
call plug#end()

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
" Ported `set` options live in lua/vim-options.lua.
" encoding=UTF-8 was dropped: Neovim is UTF-8 always.

" --------------------------------------------------
" 👉 Plugins config
" --------------------------------------------------

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

" --- DEFAULTS (Prettier + StandardRB) ---
let g:ale_linters = {
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'ruby': ['standardrb'],
\   'eruby': ['erblint'],
\ }

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'ruby': ['standardrb'],
\   'eruby': ['erblint'],
\ }

" --- COMMANDS TO switch BACK to ESLint/RuboCop when needed ---

function! SetESLintLinter()
  let g:ale_linters['javascript'] = ['eslint']
  let g:ale_linters['javascriptreact'] = ['eslint']
  let g:ale_linters['typescript'] = ['eslint']
  let g:ale_linters['typescriptreact'] = ['eslint']
  let g:ale_fixers['javascript'] = ['eslint']
  let g:ale_fixers['javascriptreact'] = ['eslint']
  let g:ale_fixers['typescript'] = ['eslint']
  let g:ale_fixers['typescriptreact'] = ['eslint']
endfunction
command! SetESLintLinter call SetESLintLinter()

function! SetRuboCopLinter()
  let g:ale_linters['ruby'] = ['rubocop']
  let g:ale_fixers['ruby'] = ['rubocop']
endfunction
command! SetRuboCopLinter call SetRuboCopLinter()

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
