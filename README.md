# nvim

Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim). One plugin per
file under `lua/plugins/`, each with a comment header explaining what it does.

## Install

1. Clone this repo to `~/.config/nvim`
2. Install the external tools below
3. Launch `nvim` — lazy.nvim bootstraps itself and installs everything on first run

```sh
brew install ripgrep   # required by telescope's live_grep
brew install fd        # faster file finding for telescope
```

Icons need a [Nerd Font](https://www.nerdfonts.com/font-downloads) (JetBrainsMono Nerd
Font works well) set as your terminal font, otherwise the file tree shows tofu boxes.

## Keymaps

`<leader>` is <kbd>Space</kbd>, set in `lua/vim-options.lua`. So `<leader>gd` means
press <kbd>Space</kbd> then <kbd>g</kbd> then <kbd>d</kbd>.

**When** is the mode or UI the key works in. Blank = normal mode in a regular
buffer. Leader maps do nothing in insert or `:terminal` until you leave that
mode (`jj` or <kbd>Esc</kbd>).

### Call a feature

| Key | When | Does | From |
| --- | --- | --- | --- |
| <kbd>j</kbd><kbd>j</kbd> | insert | Escape insert mode | vim-options |
| <kbd>Esc</kbd> | terminal | Leave the shell (else Ctrl-\ Ctrl-n) | vim-options |
| <kbd>Space</kbd> `\` | | Vertical split (opens right) | vim-options |
| <kbd>Space</kbd> `d\` | | Horizontal split (opens below) | vim-options |
| <kbd>Ctrl</kbd>+<kbd>h</kbd>/<kbd>j</kbd>/<kbd>k</kbd>/<kbd>l</kbd> | | Move between splits | vim-options |
| <kbd>Space</kbd> <kbd>Shift</kbd>+<kbd>t</kbd> | | New tab | vim-options |
| <kbd>Space</kbd> `1`–`4` | | Jump to tab 1–4 | vim-options |
| <kbd>Space</kbd> `D` | | Delete line without yanking | vim-options |
| <kbd>Space</kbd> `fr` | | Find and replace in file (one float, confirm each) | vim-options |
| <kbd>Ctrl</kbd>+<kbd>b</kbd> | visual | Git blame selected lines (telescope dropdown) | vim-options |
| <kbd>Ctrl</kbd>+<kbd>\</kbd> | visual | Open file / selection on GitHub (`main`) | open-browser |
| <kbd>Ctrl</kbd>+<kbd>'</kbd> | | Start `:colorscheme` (tab-complete a name) | theme |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>n</kbd> / <kbd>p</kbd> | | Next / previous colorscheme | theme |
| <kbd>Space</kbd> `ff` | | Find files by name | telescope |
| <kbd>_</kbd><kbd>u</kbd> | | Reopen the last closed window | undoquit |
| <kbd>_</kbd><kbd>U</kbd> | | Reopen closed windows in this tab | undoquit |
| <kbd>Space</kbd> `fg` | | Search file *contents* across the project | telescope |
| <kbd>Space</kbd> `wfg` | | Grep the word under the cursor | telescope |
| <kbd>Space</kbd> `fb` | | Open buffers (Esc then `dd` deletes; Alt-d also) | telescope |
| <kbd>Space</kbd> `se` | | Project search (boxed float, Enter) | ctrlsf |
| <kbd>Space</kbd> `st` | | Toggle the search-results panel | ctrlsf |
| <kbd>Space</kbd> `nt` | | Toggle the file tree | neo-tree |
| <kbd>Space</kbd> `nf` | | File tree, jump to current file | neo-tree |
| <kbd>Space</kbd> `tn` / `ta` | | neotest nearest / this file | neotest |
| <kbd>Space</kbd> `tp` | | Pick a test (telescope dropdown) | neotest |
| <kbd>Space</kbd> `ts` | | neotest summary panel | neotest |
| <kbd>Space</kbd> `it` | | Toggle the last used floating terminal | toggleterm |
| <kbd>Space</kbd> `i1`–`i6` | | Toggle floating terminal 1–6 | toggleterm |
| <kbd>K</kbd> | | Show docs for the symbol under the cursor | LSP |
| <kbd>Space</kbd> `gd` | | Go to definition | LSP |
| <kbd>Space</kbd> `gr` | | List references | LSP |
| <kbd>Space</kbd> `ca` | | Code actions (quick fixes, telescope dropdown) | LSP |
| <kbd>Space</kbd> `rn` | | Rename symbol across the project | LSP |
| `[d` / `]d` | | Prev / next diagnostic | Neovim stock |
| `gcc` | | Toggle comment on this line | Neovim stock |
| `gc` | visual, or + motion | Toggle comments | Neovim stock |
| <kbd>Space</kbd> `gf` | | Format the current file | none-ls |
| <kbd>Space</kbd> `dt` | | Toggle breakpoint *(needs an adapter)* | nvim-dap |
| <kbd>Space</kbd> `dc` | | Start / continue debugging *(needs an adapter)* | nvim-dap |
| <kbd>Space</kbd> `dx` | | Terminate debug session | nvim-dap |
| <kbd>Space</kbd> `do` | | Step over | nvim-dap |

### Completion (insert, nvim-cmp)

Popup as you type. <kbd>Ctrl</kbd>+<kbd>n</kbd> / <kbd>p</kbd> also *open* the
menu if it is hidden. Docs-scroll keys only do something when the docs window
is showing. Visual <kbd>Ctrl</kbd>+<kbd>b</kbd> (blame) is a different mode, so
it does not clash with scroll-docs.

Snippets expand when you confirm a luasnip item with Enter. Placeholder jump
is **not mapped** — LuaSnip ships no Tab binding, and this config does not add
one.

| Key | Does |
| --- | --- |
| <kbd>Ctrl</kbd>+<kbd>n</kbd> / <kbd>p</kbd> | Next / previous item (or open the menu) |
| <kbd>Up</kbd> / <kbd>Down</kbd> | Previous / next item |
| <kbd>Ctrl</kbd>+<kbd>Space</kbd> | Force-open the menu |
| <kbd>Enter</kbd> | Confirm (auto-selects the first item) |
| <kbd>Ctrl</kbd>+<kbd>y</kbd> | Confirm the highlighted item only |
| <kbd>Ctrl</kbd>+<kbd>e</kbd> | Abort / close the menu |
| <kbd>Ctrl</kbd>+<kbd>b</kbd> / <kbd>f</kbd> | Scroll the docs window |

### clever-f (`f` / `F` / `t` / `T`)

Same first jump as stock Vim. Repeat is remapped; `;` / `,` are unused.
`fa` matches `a` and `A`; `fA` matches only `A` (`clever_f_smart_case`).

| Key | Does |
| --- | --- |
| `f` / `F` / `t` / `T` then a char | Jump (forward / back, on / before) |
| `f` again (after `f`/`t`) | Next match (stock is `;`) |
| `F` again (after `f`/`t`) | Previous match (stock is `,`) |

### wordmotion (`w` / `b` / `e`)

Stock `w` jumps a whole `getUserName` or `foo_bar`. This stops on each piece.
`W` / `B` / `E` still skip whitespace-separated WORDs.

### visual-multi (`Ctrl-n` — VS Code Cmd-D)

Adds another cursor on the next copy of the same word. **Normal mode** (Esc
first). Insert-mode <kbd>Ctrl</kbd>+<kbd>n</kbd> is still nvim-cmp.

| Key | Does | VS Code |
| --- | --- | --- |
| <kbd>Ctrl</kbd>+<kbd>n</kbd> | Select this word, then add the next match | <kbd>Cmd</kbd>+<kbd>d</kbd> |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>l</kbd> | Cursors on every match in the file | <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>l</kbd> |
| visual <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>l</kbd> | Caret at the **end** of each selected line | cursors at EOL |
| `0` or `I` | Each cursor to the start of **its** line | Home / <kbd>Cmd</kbd>+<kbd>←</kbd> |
| `$` or `A` | Each cursor to the end of **its** line | End / <kbd>Cmd</kbd>+<kbd>→</kbd> |
| visual `\` `c` | Caret on each selected line (same column) | then `0` / `$` |
| `q` | Skip this match, take the next | <kbd>Cmd</kbd>+<kbd>k</kbd> <kbd>Cmd</kbd>+<kbd>d</kbd> |
| `c` | Change all cursors | type to replace |
| <kbd>Esc</kbd> | Leave | <kbd>Esc</kbd> |

<kbd>Cmd</kbd>+<kbd>d</kbd> / <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>l</kbd> are
mapped too, but most terminals never send them. Use the Ctrl keys.

### surround (`cs` / `ds` / `ys`)

Stock Vim edits **inside** or **around** a pair. `da"` on `"foo"` deletes the
whole `"foo"`. Surround edits only the quotes/parens: `ds"` on `"foo"` leaves
`foo`. `.` repeats these (vim-repeat).

Stock (no plugin):

| Key | Stands for | Example |
| --- | --- | --- |
| `ciw` | change inner word | `foo` → word gone, insert mode |
| `ci"` | change inner quotes | `"foo"` → `""`, insert mode |
| `di"` | delete inner quotes | `"foo"` → `""` |
| `da"` | delete around quotes | `"foo"` → (gone) |
| `yi{` | yank inner braces | `{foo}` → yank `foo`, braces stay |

Surround:

| Key | Stands for | Example |
| --- | --- | --- |
| `ds"` | delete surround | `"foo"` → `foo` |
| `cs"'` | change surround | `"foo"` → `'foo'` |
| `ysiw)` | you surround inner word | `foo` → `(foo)` |
| `yss"` | you surround this line | `foo bar` → `"foo bar"` |
| visual `S)` | surround selection | `foo` → `(foo)` |

`ys` is the operator (you surround) + a motion + a wrapper: `ysiw)` on `foo` → `(foo)`.
`iw` is stock inner word (same as `ciw` on `foo`). So `ysiw)` = you surround inner word with parens.

### nvim-autopairs (insert)

Typing `(` inserts `()`; same for quotes and brackets. Typing the closer skips
over the one it added. Backspace on an empty pair deletes both. Enter between
braces opens a new indented line. Confirming a function completion also adds `()`.
Enter after `def` / `if` / `do` in Ruby, Lua, or Elixir inserts `end`.

### nvim-ts-autotag (HTML / JSX / TSX)

No new keys. Needs a treesitter parser for that filetype (`html` / `javascript` / `tsx`).

| What | Example |
| --- | --- |
| Close | type `<div>` then `>` → `<div></div>` (cursor in the middle) |
| Rename | `ciwspan` then Esc on `<div>` → `<span></span>` (both ends) |

Stock Vim does neither. surround `cst` is the manual rename (you type the new tag).

### Telescope (inside `ff` / `fg` / `fb` / `ca` / `tp` / visual <kbd>Ctrl</kbd>+<kbd>b</kbd>)

Opens in **insert**. Type to filter. These are telescope defaults (this config
does not override them). Same keys in the ui-select dropdown used by code
actions, test pick, and git blame.

| Key | When | Does |
| --- | --- | --- |
| <kbd>Ctrl</kbd>+<kbd>n</kbd> / <kbd>p</kbd> | insert | Next / previous result |
| <kbd>Enter</kbd> | insert or normal | Open the selection |
| <kbd>Ctrl</kbd>+<kbd>x</kbd> / <kbd>v</kbd> / <kbd>t</kbd> | insert or normal | Open in split / vsplit / tab |
| <kbd>Ctrl</kbd>+<kbd>u</kbd> / <kbd>d</kbd> | insert or normal | Scroll the preview |
| <kbd>Ctrl</kbd>+<kbd>c</kbd> | insert | Close the picker |
| <kbd>Esc</kbd> | insert | Drop to telescope normal mode (does **not** close) |
| <kbd>Esc</kbd> | normal | Close the picker |
| `j` / `k` | normal | Next / previous result |
| <kbd>Ctrl</kbd>+<kbd>q</kbd> | insert or normal | Send all results to the quickfix list |
| <kbd>Ctrl</kbd>+<kbd>/</kbd> | insert | Show telescope's own keymap help |
| `?` | normal | Same help |
| `dd` | normal, `fb` only | Delete the highlighted buffer |
| <kbd>Alt</kbd>+<kbd>d</kbd> | insert or normal, `fb` only | Same delete |

### neo-tree (inside `nt` / `nf`)

The tree is a centered float. `/` is neo-tree's filter, not buffer search.
`?` lists every command.

| Key | Does |
| --- | --- |
| <kbd>Enter</kbd> | Open the file (or toggle a directory) |
| `/` | Fuzzy-filter by name |
| `a` / `A` | Add a file / directory |
| `d` | Delete |
| `r` | Rename |
| `y` / `x` / `p` | Copy / cut / paste |
| `s` / `S` / `t` | Open in vsplit / split / tab |
| <kbd>Backspace</kbd> | Up a directory |
| `.` | Set this folder as the tree root |
| `H` | Toggle hidden files |
| `R` | Refresh |
| `q` / <kbd>Esc</kbd> | Close the tree |
| `?` | Help |

### neotest summary (inside `ts`)

Side panel of the test tree. `Space ts` again (from a normal buffer) toggles it
closed; `q` in the panel also closes it. `?` lists every command.

| Key | Does |
| --- | --- |
| <kbd>Enter</kbd> | Expand / collapse |
| `r` | Run the test under the cursor |
| `i` | Jump to that test in the file |
| `o` | Show output |
| `u` | Stop a running test |
| `m` / `R` | Mark / run marked tests |
| `J` / `K` | Next / previous failed test |
| `?` | Help |
| `q` | Close the panel |

### Find and replace (inside `fr`)

One float titled **Find and replace in file**, with boxed **Find** and **Replace**
fields. Starts in insert on Find. Enter or Tab moves to Replace; Enter there
runs the substitute. Esc cancels. Then confirm each match (`y` / `n` / `a` / `q`).

### Git blame float (after visual <kbd>Ctrl</kbd>+<kbd>b</kbd>, pick a line)

Telescope first (keys above). Picking a commit opens a message float.

| Key | Does |
| --- | --- |
| `q` / <kbd>Esc</kbd> | Close the commit popup |

### ctrlsf (inside `se` / `st`)

`Space se` is a boxed float (same UI as `fr`) to type the query. Results are a
centered float (ctrlsf opens a split; we convert it). Edit a match line and `:w`
writes it back to the file. `:%s` in that buffer + `:w` is project replace on
this search. `Space st` hides/shows the same panel.

| Key | Does |
| --- | --- |
| <kbd>Enter</kbd> / `o` | Open the file at that match |
| `p` | Preview |
| `n` / `N` | Next / previous match |
| `q` | Close the panel |

### toggleterm (inside `it` / `i1`–`i6`)

Float starts in terminal mode, so typed keys go to the shell. <kbd>Esc</kbd>
leaves the shell (vim-options); then `Space it` hides the same session.
`Space i1`–`i6` each own a numbered shell.

### DAP UI (only while a debug session is running)

Panels open on `Space dc` and close on `Space dx`. No adapter is wired yet, so
this UI never appears until `dap.adapters` is filled in. Defaults from
nvim-dap-ui:

| Key | Does |
| --- | --- |
| <kbd>Enter</kbd> | Expand the variable / node |
| `o` | Open |
| `d` | Remove |
| `e` | Edit |
| `t` | Toggle |
| `q` / <kbd>Esc</kbd> | Close a DAP float |

## Terms

- **LSP** (Language Server Protocol) — a background process per language that
  understands your code, providing go-to-definition, rename, errors, and hover docs.
- **Treesitter** — parses files into a real syntax tree, which gives accurate
  highlighting and indentation instead of regex guesswork.
- **lazy.nvim** — the plugin manager. Each file in `lua/plugins/` returns a *spec*: a
  table naming a GitHub repo plus how to configure it.

## Commands

| Command | Does |
| --- | --- |
| `:Lazy` | Plugin manager UI — install, update, check load times |
| `:Mason` | Browse and install language servers, formatters, linters |
| `:checkhealth` | Diagnose a broken setup (missing binaries, bad config) |
| `:LspInfo` | Which language servers are attached to this buffer |

## Layout

```
init.lua              bootstraps lazy.nvim, then loads the two below
lua/vim-options.lua   tabs, line numbers, clipboard, mapleader, insert/terminal maps
lua/float-form.lua    boxed float form used by <leader>fr and <leader>se
lua/plugins/
  theme.lua           hybrid.nvim (default) plus extra colorschemes and the switcher
  fidget.lua          LSP progress overlay in the corner
  lualine.lua         statusline (bottom bar)
  gitsigns.lua        git hunk signs in the gutter
  open-browser.lua    visual Ctrl-\ opens the file on GitHub
  undoquit.lua        _u last closed window, _U this tab's closed windows
  clever-f.lua        f/t repeat with highlights (smart_case)
  wordmotion.lua      w/b/e stop on camelCase / snake_case
  visual-multi.lua    Ctrl-n next match; Ctrl-Shift-l every match / visual EOL carets
  surround.lua        cs/ds/ys change wrappers (quotes, parens)
  autotag.lua         HTML/JSX close and rename paired tags
  autopairs.lua       insert auto-pairs for quotes and brackets
  neotest.lua         test runner + summary panel (tn / ta / tp / ts)
  toggleterm.lua      floating terminals (<leader>it last used, i1–i6)
  ctrlsf.lua          project search + edit (<leader>se / st)
  treesitter.lua      syntax parsers
  lsp-config.lua      mason + lspconfig, and the LSP keymaps
  completions.lua     nvim-cmp autocompletion and snippets
  lazydev.lua         Neovim API types for lua_ls
  none-ls.lua         stylua / prettier formatting
  telescope.lua       fuzzy finder (ff / fg / wfg / fb, vertical layout)
  neo-tree.lua        file tree
  debugging.lua       nvim-dap and its UI
```

Language servers installed automatically: `lua_ls`, `ruby_lsp`, `ts_ls`, `elixirls`,
`tailwindcss`. Formatters: `stylua`, `prettier`.

## Not set up yet

- **Debug adapters.** nvim-dap is installed but has no adapter, so no debug session can
  start yet -- `dap.adapters` and `dap.configurations` are both empty. Each language
  needs its own debugger wired up, in two parts: install the adapter binary (most live
  in mason: `js-debug-adapter`, `debugpy`, `delve`; Ruby's `rdbg` ships as the `debug`
  gem instead), then define `dap.adapters.<name>` and `dap.configurations.<filetype>`
  so nvim-dap knows how to launch it. `jay-babu/mason-nvim-dap.nvim` can do both steps.
  Until then the `<leader>d*` keymaps set breakpoints nothing will ever hit.
- **Linting.** none-ls runs formatters only; no `diagnostics` sources are registered.
- **Format on save** is written but commented out at the bottom of `none-ls.lua`.
- `plugged/` is leftover from the old vim-plug setup and is no longer loaded.
