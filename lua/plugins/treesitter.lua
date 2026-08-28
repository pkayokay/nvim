-- Syntax parsing: nvim-treesitter installs per-language parsers that give Neovim a real
-- syntax tree, which drives accurate highlighting and indentation. Tracking the `main`
-- branch, where the plugin only manages parser installs and Neovim core owns
-- highlight/indent -- hence the FileType autocmd below.
--
-- Pairs with theme.lua: the parser produces @capture groups (@function, @keyword, ...)
-- and hybrid.nvim supplies the colors for them. Without a parser installed for a
-- filetype, that buffer silently falls back to Vim's older regex syntax.
--
-- Fresh machine: needs tree-sitter CLI + a C compiler before parsers can compile.
-- See README.md Install.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  config = function()
    local parsers = {
      'lua', 'javascript', 'ruby', 'elixir', 'typescript', 'tsx', 'html',
      'heex', 'embedded_template', 'json', 'yaml', 'markdown', 'css',
    }

    local function missing_prereqs()
      local missing = {}
      if vim.fn.executable('tree-sitter') == 0 then
        table.insert(missing, 'tree-sitter CLI (brew install tree-sitter-cli or mise use -g tree-sitter@latest)')
      end
      if vim.fn.executable('cc') == 0 and vim.fn.executable('clang') == 0 then
        table.insert(missing, 'C compiler (xcode-select --install)')
      end
      return missing
    end

    local function install_parsers()
      local missing = missing_prereqs()
      if #missing > 0 then
        vim.notify(
          'Treesitter parsers not installed:\n- ' .. table.concat(missing, '\n- '),
          vim.log.levels.WARN
        )
        return
      end

      local ts = require('nvim-treesitter')
      ts.install(parsers)
      ts.install({ 'eex' }, { generate = true })
    end

    -- Defer so lazy/mason can finish booting; install is async either way.
    vim.defer_fn(install_parsers, 100)

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
