# vim
1. Install VIM PLUG https://github.com/junegunn/vim-plug#neovim
2. Add this repo under ~/.config/nvim

For NerdTree Icons, use download JetBrainsMono Nerd Font here https://www.nerdfonts.com/font-downloads

### For telescope install
```
brew install ripgrep
brew install fd
https://github.com/BurntSushi/ripgrep
https://github.com/sharkdp/fd
```

---

## LSP

https://github.com/VonHeikemen/lsp-zero.nvim

Helps setup nvim-lspconfig and nvim-cmp (auto completion) with pre-made configuration for various language servers.

Install LSPs, linters and formatters (do not need to use for formatters though as this config uses ALE)

Ex.
```
:LspInstall ruby-lsp
:LspInstall html-lsp
:LspInstall tailwindcss-language-server
```
