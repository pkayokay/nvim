return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({
      'lua', 'javascript', 'ruby', 'elixir', 'typescript', 'tsx',
    })

    -- highlight/indent are no longer plugin modules; Neovim owns them now
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua', 'javascript', 'ruby', 'elixir', 'typescript', 'typescriptreact' },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
}
