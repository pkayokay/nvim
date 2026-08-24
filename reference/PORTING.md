# Porting notes: `main` (vim-plug) → `lua` (lazy.nvim)

`reference/init.vim` started as a copy of `init.vim` from `main`. Lines are deleted
as they are ported, so what remains is still todo. Nothing loads it — Neovim reads
`init.lua` at the config root, and a real `init.vim` there would raise
`E5422: Conflicting configs`.

46 plugins were declared on `main`. Status below.

## Done (13)

`hybrid.nvim`, `nvim-cmp`, `cmp-buffer`, `cmp-nvim-lsp`, `cmp-path`, `nvim-lspconfig`,
`plenary.nvim`, `telescope.nvim`, `vim-afterglow`, `oceanic-next`, `fidget.nvim`,
`open-browser.vim`, `open-browser-github.vim`

Their leftover `Plug` lines, `colorscheme hybrid`, and the Native LSP/cmp `lua <<EOF`
block are deleted from `reference/init.vim`. The telescope *config* block stays: the
lua branch only has `<leader>ff` find-files and `<leader>fg` grep; live-grep-args, buffers,
and the old layout are not ported yet.

Theme switcher (`<C-S-n>` / `<C-S-p>`) and `<C-'>` live in `lua/plugins/theme.lua`.

## Replaced by a different plugin (8)

| main | lua branch |
| --- | --- |
| `williamboman/mason.nvim` | `mason-org/mason.nvim` (org renamed) |
| `williamboman/mason-lspconfig.nvim` | `mason-org/mason-lspconfig.nvim` (org renamed) |
| `preservim/nerdtree` | `neo-tree.nvim` |
| `ctrlpvim/ctrlp.vim` | `telescope.nvim` (`<leader>ff` find-files) |
| `dense-analysis/ale` | `none-ls.nvim` |
| `ryanoasis/vim-devicons` | `nvim-web-devicons` |
| `vim-airline/vim-airline` + `-themes` | `nvim-lualine/lualine.nvim` |
| `airblade/vim-gitgutter` | `lewis6991/gitsigns.nvim` |

CtrlP leftover (`Plug` line, `g:ctrlp_user_command`) is deleted from `reference/init.vim`.

Gitgutter leftover is deleted from `reference/init.vim`. `highlight Directory` stays
(it was next to gitgutter but is a folder-name color, not a hunk sign).

Airline leftover (`Plug` lines, `g:airline_*`) is deleted from `reference/init.vim`.
Lualine uses `theme = "auto"` (follows the colorscheme) instead of airline `tomorrow`.

## Not ported yet (21)

Grouped by what they do, with the usual modern equivalent where the original is a
Vimscript plugin that has one. Plenty of these still work fine under lazy.nvim — being
Vimscript is not a reason to replace them, only a reason to check.

### Git
- `tpope/vim-fugitive` — still the standard, port as-is

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
- `voldikss/vim-floaterm` — modern: `akinsho/toggleterm.nvim`

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

`gdefault` is in `lua/vim-options.lua` but commented out (same as the old file).

## Mappings (29)

`mapleader` is Space on both branches, so `<leader>` mappings carry over unchanged.

**Ported to `lua/vim-options.lua`:** `jj`, `<Esc>` in terminal, `<leader>\` / `<leader>d\`, `<C-h/j/k/l>`, `<leader><S-t>` / `<leader>1..4`, `<leader>D`, `<leader>fr`, visual `<C-b>` git blame.

**Ported to `lua/plugins/theme.lua`:** `<C-'>`, `<C-S-n>`, `<C-S-p>`.

**Ported to `lua/plugins/open-browser.lua`:** visual `<C-\>` (`:OpenGithubFile`).

**Tied to plugins you have not ported:**

| Mapping | Needs |
| --- | --- |
| `<leader>nt` `<leader>nf` `<leader>nrs` | NERDTree — neo-tree uses `<C-n>` already |
| `<leader>tn` `<leader>ta` | vim-test |
| `<leader>it` | vim-floaterm |
| `<leader>se` `<leader>st` | ctrlsf |

**Dropped:** `inoremap dry ...` (Rails system-test snippet). Never existed on the lua
branch; deleted from `reference/init.vim`.

## Functions (5)

- `SwitchThemeNext()` / `SwitchThemePrev()` — ported to `lua/plugins/theme.lua`
- `FindAndReplace()` — ported to `<leader>fr` in `lua/vim-options.lua`
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
