# Porting notes: `main` (vim-plug) → `lua` (lazy.nvim)

`reference/init.vim` started as a copy of `init.vim` from `main`. Lines are deleted
as they are ported, so what remains is still todo. Nothing loads it — Neovim reads
`init.lua` at the config root, and a real `init.vim` there would raise
`E5422: Conflicting configs`.

46 plugins were declared on `main`. Status below.

## Done (8)

`hybrid.nvim`, `nvim-cmp`, `cmp-buffer`, `cmp-nvim-lsp`, `cmp-path`, `nvim-lspconfig`,
`plenary.nvim`, `telescope.nvim`

## Replaced by a different plugin (6)

| main | lua branch |
| --- | --- |
| `williamboman/mason.nvim` | `mason-org/mason.nvim` (org renamed) |
| `williamboman/mason-lspconfig.nvim` | `mason-org/mason-lspconfig.nvim` (org renamed) |
| `preservim/nerdtree` | `neo-tree.nvim` |
| `ctrlpvim/ctrlp.vim` | `telescope.nvim` |
| `dense-analysis/ale` | `none-ls.nvim` |
| `ryanoasis/vim-devicons` | `nvim-web-devicons` |

## Not ported yet (31)

Grouped by what they do, with the usual modern equivalent where the original is a
Vimscript plugin that has one. Plenty of these still work fine under lazy.nvim — being
Vimscript is not a reason to replace them, only a reason to check.

### Git
- `tpope/vim-fugitive` — still the standard, port as-is
- `airblade/vim-gitgutter` — modern equivalent: `lewis6991/gitsigns.nvim`

### Editing
- `tpope/vim-surround` — modern: `kylechui/nvim-surround`
- `tpope/vim-repeat` — needed by vim-surround; drop if you move to nvim-surround
- `tomtom/tcomment_vim` — Neovim 0.10+ has commenting built in (`gc`), likely droppable
- `raimondi/delimitmate` — modern: `windwp/nvim-autopairs`
- `tpope/vim-endwise` — Ruby/Lua `end` insertion; nvim-autopairs can cover this
- `andrewradev/tagalong.vim` — renames paired HTML/JSX tags
- `mg979/vim-visual-multi` — multiple cursors
- `chaoren/vim-wordmotion` — subword motions

### Navigation / search
- `dyng/ctrlsf.vim` — project search + edit; telescope covers most of it
- `jlanzarotta/bufexplorer` — telescope `buffers` picker covers this
- `rhysd/clever-f.vim` — improved `f`/`t`
- `nvim-telescope/telescope-live-grep-args.nvim` — telescope extension, easy port
- `andrewradev/undoquit.vim` — reopen closed windows

### Ruby / Rails / JS
- `tpope/vim-rails`
- `jlcrochet/vim-ruby`, `pangloss/vim-javascript`, `maxmellon/vim-jsx-pretty` —
  treesitter already handles this highlighting; probably droppable
- `vim-test/vim-test` — modern: `nvim-neotest/neotest`

### UI
- `vim-airline/vim-airline` + `-themes` — modern: `nvim-lualine/lualine.nvim`
- `j-hui/fidget.nvim` — LSP progress; already a Lua plugin, easy port
- `voldikss/vim-floaterm` — modern: `akinsho/toggleterm.nvim`

### Browser
- `tyru/open-browser.vim`, `tyru/open-browser-github.vim`

### Themes (only one can be active)
- `briones-gabriel/darcula-solid.nvim`, `danilo-augusto/vim-afterglow`,
  `mhartington/oceanic-next`, `projekt0n/github-nvim-theme`, `rktjmp/lush.nvim`
- The `lua` branch currently uses `hybrid.nvim`

## How to port one

Create `lua/plugins/<name>.lua` returning a lazy.nvim spec. The vim-plug line

```vim
Plug 'tpope/vim-fugitive'
```

becomes

```lua
return { "tpope/vim-fugitive" }
```

Any `let g:foo = 1` settings from `init.vim` go in a `config` function as
`vim.g.foo = 1`, or in `init` if they must be set before the plugin loads.

---

# Non-plugin config

The `Plug` lines are only 46 of 523 lines. The rest is settings, mappings and
functions, and most of it has nothing to do with which plugins you pick.

## `set` options (18)

All in `lua/vim-options.lua` and deleted from `reference/init.vim`.

Dropped: `encoding=UTF-8` — Neovim is UTF-8 always; that line was for vim-devicons.

`clipboard` is `unnamedplus` (old `init.vim` had `unnamed`; same pasteboard on macOS).

## Mappings (29)

`mapleader` is Space on both branches, so `<leader>` mappings carry over unchanged.

**Ported to `lua/vim-options.lua`:** `jj`, `<Esc>` in terminal, `<leader>\` / `<leader>d\`.

**Worth porting — plugin-independent:**

| Mapping | Does |
| --- | --- |
| `<C-h/j/k/l>` | Move between splits |
| `<leader><S-t>`, `<leader>1..4` | New tab, jump to tab N |
| `<leader>D` → `"_dd` | Delete line without clobbering the yank register |
| `<leader>fr` | Find-and-replace prompt (needs `FindAndReplace()`, below) |

**Tied to plugins you have not ported:**

| Mapping | Needs |
| --- | --- |
| `<leader>nt` `<leader>nf` `<leader>nrs` | NERDTree — neo-tree uses `<C-n>` already |
| `<leader>tn` `<leader>ta` | vim-test |
| `<leader>it` | vim-floaterm |
| `<leader>se` `<leader>st` | ctrlsf |
| `<C-\>` | open-browser-github |
| `<C-S-p>` `<C-S-n>` `<c-'>` | the theme switcher functions |
| `<c-b>` (visual) | git blame on the selection — shells out, no plugin needed |

**Probably drop:** `inoremap dry ...` inserts a Rails system-test line; that is what
snippets are for now, and you have LuaSnip.

## Functions (5)

- `SwitchThemeNext()` / `SwitchThemePrev()` — cycle themes; only useful with the five
  themes from `main` installed
- `FindAndReplace()` — prompts for find/replace then runs `%s`. Easy to rewrite in Lua
  with `vim.fn.input`
- `SetESLintLinter()` / `SetRuboCopLinter()` — swap ALE's linters per project.
  ALE is replaced by none-ls, so this needs rethinking rather than porting

## ALE config (~20 lines)

`g:ale_linters`, `g:ale_fixers`, `ale_fix_on_save` and friends do not translate — none-ls
uses a different model. The equivalents:

- `ale_fix_on_save` → the commented-out `BufWritePre` autocmd in `none-ls.lua`
- `ale_linters` → `null_ls.builtins.diagnostics.*` sources
- `ale_fixers` → `null_ls.builtins.formatting.*` sources (you have stylua + prettier)
- `ale_sign_error` / `ale_echo_msg_format` → `vim.diagnostic.config()`

This is the one area where porting means redesigning, not translating.
