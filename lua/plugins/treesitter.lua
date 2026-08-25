-- Syntax parsing: nvim-treesitter installs per-language parsers that give Neovim a real
-- syntax tree, which drives accurate highlighting and indentation. Tracking the `main`
-- branch, where the plugin only manages parser installs and Neovim core owns
-- highlight/indent -- hence the FileType autocmd below.
--
-- Pairs with theme.lua: the parser produces @capture groups (@function, @keyword, ...)
-- and hybrid.nvim supplies the colors for them. Without a parser installed for a
-- filetype, that buffer silently falls back to Vim's older regex syntax.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({
      'lua', 'javascript', 'ruby', 'elixir', 'typescript', 'tsx', 'html',
      'heex', 'eex', 'embedded_template', 'json', 'yaml', 'markdown', 'css',
    })

    -- eruby is the vim filetype; the parser is named embedded_template
    vim.treesitter.language.register('embedded_template', 'eruby')

    -- highlight/indent are no longer plugin modules; Neovim owns them now
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua', 'javascript', 'javascriptreact', 'html', 'ruby', 'eruby',
        'elixir', 'heex', 'eex', 'typescript', 'typescriptreact',
        'json', 'yaml', 'markdown', 'css',
      },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
}
