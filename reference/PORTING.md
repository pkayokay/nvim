# Porting notes: `main` (vim-plug) → `lua` (lazy.nvim)

`reference/init.vim` started as a copy of `init.vim` from `main`. Lines are deleted
as they are ported, so what remains is still todo. Nothing loads it — Neovim reads
`init.lua` at the config root, and a real `init.vim` there would raise
`E5422: Conflicting configs`.

46 plugins were declared on `main`. Status below.

## Done (19)

`hybrid.nvim`, `nvim-cmp`, `cmp-buffer`, `cmp-nvim-lsp`, `cmp-path`, `nvim-lspconfig`,
`plenary.nvim`, `telescope.nvim`, `vim-afterglow`, `oceanic-next`, `fidget.nvim`,
`open-browser.vim`, `open-browser-github.vim`, `undoquit.vim`, `clever-f.vim`,
`ctrlsf.vim`, `vim-wordmotion`, `vim-surround`, `vim-repeat`

Their leftover `Plug` lines, `colorscheme hybrid`, and the Native LSP/cmp `lua <<EOF`
block are deleted from `reference/init.vim`. The telescope *config* block stays: the
lua branch has `<leader>ff` files, `<leader>fg` grep, `<leader>wfg` word under
cursor, `<leader>fb` buffers, and the old vertical centered layout at stock
size (80% × 90%). Dropped live-grep-args (`<leader>sf`, `<leader>gc`), leftover
no-preview `ff`, and bufexplorer.

Theme switcher (`<C-S-n>` / `<C-S-p>`) and `<C-'>` live in `lua/plugins/theme.lua`.

## Replaced by a different plugin (12)

| main | lua branch |
| --- | --- |
| `Raimondi/delimitMate` | `windwp/nvim-autopairs` |
| `tpope/vim-endwise` | `nvim-autopairs` endwise rules (Ruby / Lua / Elixir) |
| `williamboman/mason.nvim` | `mason-org/mason.nvim` (org renamed) |
| `williamboman/mason-lspconfig.nvim` | `mason-org/mason-lspconfig.nvim` (org renamed) |
| `preservim/nerdtree` | `neo-tree.nvim` (`<leader>nt` toggle, `<leader>nf` reveal) |
| `ctrlpvim/ctrlp.vim` | `telescope.nvim` (`<leader>ff` find-files) |
| `dense-analysis/ale` | `none-ls.nvim` |
| `ryanoasis/vim-devicons` | `nvim-web-devicons` |
| `vim-airline/vim-airline` + `-themes` | `nvim-lualine/lualine.nvim` |
| `airblade/vim-gitgutter` | `lewis6991/gitsigns.nvim` |
| `vim-test/vim-test` | `nvim-neotest/neotest` (vim-test kept only as a neotest detection fallback) |
| `voldikss/vim-floaterm` | `akinsho/toggleterm.nvim` (`<leader>it` float) |

Floaterm leftover (`Plug` line, `g:floaterm_*`, `<leader>it`) is deleted from
`reference/init.vim`.

NERDTree leftover (`Plug` lines, `g:NERDTree*`, nerdtree-devicons) is deleted from
`reference/init.vim`.

CtrlP leftover (`Plug` line, `g:ctrlp_user_command`) is deleted from `reference/init.vim`.

Gitgutter leftover is deleted from `reference/init.vim`. `highlight Directory`
(netrw folder gray) was dropped; theme default (usually blue) is fine.

Airline leftover (`Plug` lines, `g:airline_*`) is deleted from `reference/init.vim`.
Lualine uses `theme = "auto"` (follows the colorscheme) instead of airline `tomorrow`.

ALE leftover (`Plug` line, `g:ale_*`, `SetESLintLinter` / `SetRuboCopLinter`) is deleted
from `reference/init.vim`. Keep none-ls; lint/format-on-save can be added there later.

## Dropped (4)

| main | why |
| --- | --- |
| `tomtom/tcomment_vim` | Neovim 0.10+ has `gc` / `gcc` built in |
| `jlcrochet/vim-ruby` | treesitter `ruby` parser (highlight + indent) |
| `pangloss/vim-javascript` | treesitter `javascript` parser |
| `maxmellon/vim-jsx-pretty` | treesitter `javascript` / `tsx` parsers |

Leftover `Plug` lines deleted from `reference/init.vim`. No leftover `g:`.
`.jsx` is `javascriptreact`; that filetype is in the treesitter autocmd so highlight
and indent still run after dropping jsx-pretty.

## Not ported yet (4)

Grouped by what they do, with the usual modern equivalent where the original is a
Vimscript plugin that has one. Plenty of these still work fine under lazy.nvim — being
Vimscript is not a reason to replace them, only a reason to check.

### Git
- `tpope/vim-fugitive` — still the standard, port as-is

### Editing
- `andrewradev/tagalong.vim` — renames paired HTML/JSX tags
- `mg979/vim-visual-multi` — multiple cursors

### Ruby / Rails
- `tpope/vim-rails`

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

**Ported to `lua/plugins/undoquit.lua`:** `_u` last window, `_U` this tab's closed windows.

**Ported to `lua/plugins/neo-tree.lua`:** `<leader>nt` toggle, `<leader>nf` reveal.

**Ported to `lua/plugins/neotest.lua`:** `<leader>tn` nearest, `<leader>ta` file, `<leader>tp` pick, `<leader>ts` summary. vim-test leftover deleted (plugin kept as detection only).

**Ported to `lua/plugins/toggleterm.lua`:** `<leader>it` last used, `<leader>i1`–`i6` numbered slots (float, rounded border).

**Ported to `lua/plugins/ctrlsf.lua`:** `<leader>se` prompt, `<leader>st` toggle. Same `g:ctrlsf_*` as old init.vim. Trailing `'` on the old `st` map was a typo and is gone.

Later: try `grug-far.nvim` for the same search-then-replace workflow; keep ctrlsf until then.

**Dropped:** `inoremap dry ...` (Rails system-test snippet). Never existed on the lua
branch; deleted from `reference/init.vim`.

**Ported to `lua/plugins/telescope.lua`:** `<leader>wfg` word under cursor, `<leader>fb` buffers (no preview; old leftover `ef`). Vertical centered layout from leftover init.vim, stock 80% × 90% size. Leftover no-preview `ff` dropped (keep current `ff`).

**Dropped leftover `<leader>sf` / live-grep-args / bufexplorer:** `<leader>fg` is typed grep; `<leader>wfg` is word-under-cursor; `<leader>fb` is the buffer list.

**Ported to `lua/plugins/wordmotion.lua`:** stock `w`/`b`/`e` become subword (camelCase / snake_case). Leftover `Plug` line deleted from `reference/init.vim`. No leftover `g:` settings.

**Ported to `lua/plugins/surround.lua`:** `cs` / `ds` / `ys` edit wrappers. `vim-repeat` is a dependency so `.` repeats them. Leftover `Plug` lines deleted from `reference/init.vim`. No leftover `g:`.

**Replaced with `lua/plugins/autopairs.lua`:** `nvim-autopairs` instead of delimitMate. Stock defaults plus Ruby/Lua/Elixir `end` (replaces vim-endwise). nvim-cmp `confirm_done` inserts `()` after function/method completions. Leftover `Plug` lines deleted from `reference/init.vim`. No leftover `g:`.

## Functions (5)

- `SwitchThemeNext()` / `SwitchThemePrev()` — ported to `lua/plugins/theme.lua`
- `FindAndReplace()` — ported to `<leader>fr` in `lua/vim-options.lua`
- `SetESLintLinter()` / `SetRuboCopLinter()` — dropped with ALE (were per-project linter swaps)

## ALE config

Dropped with ALE. none-ls equivalents if you want them later:

- `ale_fix_on_save` → the commented-out `BufWritePre` autocmd in `none-ls.lua`
- `ale_linters` → `null_ls.builtins.diagnostics.*` sources
- `ale_fixers` → `null_ls.builtins.formatting.*` sources (you have stylua + prettier)
- `ale_sign_error` / `ale_echo_msg_format` → `vim.diagnostic.config()`

This is the one area where porting means redesigning, not translating.
