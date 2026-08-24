-- Fuzzy finder: pickers for files, grep, buffers, LSP results, and more.
--
--   telescope.nvim              -- the picker UI itself (<leader>ff files, <leader>fg grep)
--   plenary.nvim                -- lua utility library telescope is built on (required)
--   telescope-fzf-native.nvim   -- compiled C sorter; much faster/better matching than the lua default
--   telescope-ui-select.nvim    -- makes vim.ui.select prompts (LSP code actions, etc.) render in telescope
--
-- ui-select is what gives <leader>ca (code actions, defined in lsp-config.lua) a
-- telescope dropdown instead of Neovim's numbered-list prompt.
return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = require('telescope.themes').get_dropdown({
          -- ╭╮ rounded corners (nvim 0.11 default winborder is none / square)
          border = true,
          borderchars = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
        }),
      },
    })

    -- Registers the compiled fzf-native sorter; without this the build above is unused
    require('telescope').load_extension('fzf')
    -- Routes vim.ui.select (LSP code actions, etc.) through telescope
    require('telescope').load_extension('ui-select')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  end
}
