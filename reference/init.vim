call plug#begin('~/.config/nvim/plugged')
  " --------------------------------------------------
  " 👉 Plugins installation
  " --------------------------------------------------

  " Search
  Plug 'nvim-telescope/telescope-live-grep-args.nvim' " Extends telescope and allows passing arguments to grep
  Plug 'jlanzarotta/bufexplorer' " allows quicky deletion of buffers

  " Efficiency
  Plug 'andrewRadev/tagalong.vim' " Change an HTML(ish) opening tag and take the closing one along as well
  Plug 'tpope/vim-surround' " delete/change/add parentheses/quotes/XML-tags/much more with ease
  Plug 'tomtom/tcomment_vim' " An extensible & universal comment vim-plugin
  Plug 'tpope/vim-endwise' "helps to end certain structures automatically. In Ruby, this means adding end after if, do, def and several other keywords.
  Plug 'chaoren/vim-wordmotion' " More useful word motions for Vim
  Plug 'Raimondi/delimitMate' " provides insert mode auto-completion for quotes, parens, brackets, etc.
  Plug 'tpope/vim-repeat' " repeat.vim: enable repeating supported plugin maps with .
  Plug 'mg979/vim-visual-multi' " Multiple cursors plugin for vim/neovim, for vertical section enter v-block then shift+i insert mode

  " Misc
  Plug 'tpope/vim-fugitive' " Git wrapper

  " Languages
  Plug 'jlcrochet/vim-ruby'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-rails'
  Plug 'maxmellon/vim-jsx-pretty'
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

" Folder name color (was next to gitgutter; used by netrw).
highlight Directory guifg=#cacbcd

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
