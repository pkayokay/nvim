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

| Key | Does | From |
| --- | --- | --- |
| <kbd>j</kbd><kbd>j</kbd> | Escape insert mode | vim-options |
| <kbd>Esc</kbd> in `:terminal` | Leave the shell (else Ctrl-\ Ctrl-n) | vim-options |
| <kbd>Space</kbd> `\` | Vertical split (opens right) | vim-options |
| <kbd>Space</kbd> `d\` | Horizontal split (opens below) | vim-options |
| <kbd>Ctrl</kbd>+<kbd>h</kbd>/<kbd>j</kbd>/<kbd>k</kbd>/<kbd>l</kbd> | Move between splits | vim-options |
| <kbd>Space</kbd> <kbd>Shift</kbd>+<kbd>t</kbd> | New tab | vim-options |
| <kbd>Space</kbd> `1`–`4` | Jump to tab 1–4 | vim-options |
| <kbd>Space</kbd> `D` | Delete line without yanking | vim-options |
| <kbd>Space</kbd> `fr` | Find and replace in file | vim-options |
| <kbd>Ctrl</kbd>+<kbd>b</kbd> (visual) | Git blame selected lines (telescope, like code actions) | vim-options |
| <kbd>Ctrl</kbd>+<kbd>'</kbd> | Start `:colorscheme` (tab-complete a name) | theme |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>n</kbd> / <kbd>p</kbd> | Next / previous colorscheme | theme |
| <kbd>Ctrl</kbd>+<kbd>p</kbd> | Find files by name | telescope |
| <kbd>Space</kbd> `fg` | Search file *contents* across the project | telescope |
| <kbd>Ctrl</kbd>+<kbd>n</kbd> | Toggle the file tree | neo-tree |
| <kbd>K</kbd> | Show docs for the symbol under the cursor | LSP |
| <kbd>Space</kbd> `gd` | Go to definition | LSP |
| <kbd>Space</kbd> `gr` | List references | LSP |
| <kbd>Space</kbd> `ca` | Code actions (quick fixes) | LSP |
| <kbd>Space</kbd> `rn` | Rename symbol across the project | LSP |
| <kbd>Space</kbd> `gf` | Format the current file | none-ls |
| <kbd>Space</kbd> `dt` | Toggle breakpoint *(needs an adapter)* | nvim-dap |
| <kbd>Space</kbd> `dc` | Start / continue debugging *(needs an adapter)* | nvim-dap |
| <kbd>Space</kbd> `dx` | Terminate debug session | nvim-dap |
| <kbd>Space</kbd> `do` | Step over | nvim-dap |

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
lua/plugins/
  theme.lua           hybrid.nvim (default) plus extra colorschemes and the switcher
  treesitter.lua      syntax parsers
  lsp-config.lua      mason + lspconfig, and the LSP keymaps
  completions.lua     nvim-cmp autocompletion and snippets
  lazydev.lua         Neovim API types for lua_ls
  none-ls.lua         stylua / prettier formatting
  telescope.lua       fuzzy finder
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
