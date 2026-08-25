-- Fuzzy finder: pickers for files, grep, buffers, LSP results, and more.
--
--   telescope.nvim              -- the picker UI itself
--                               -- <leader>ff files, <leader>fg grep,
--                               -- <leader>wfg word under cursor, <leader>fb buffers
--   plenary.nvim                -- lua utility library telescope is built on (required)
--   telescope-fzf-native.nvim   -- compiled C sorter; much faster/better matching than the lua default
--   telescope-ui-select.nvim    -- makes vim.ui.select prompts (LSP code actions, etc.) render in telescope
--
-- ui-select is what gives <leader>ca (code actions, defined in lsp-config.lua) a
-- telescope dropdown instead of Neovim's numbered-list prompt.
--
-- Default pickers are a centered vertical stack (prompt on top), stock
-- size (80% × 90%). ui-select stays a small dropdown. fb is find buffers.
-- Esc then dd deletes it (normal mode). Alt-d still works in insert too.

return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('telescope').setup({
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          anchor = "CENTER",
          prompt_position = "top",
          mirror = true,
          height = 0.9,
          width = 0.8,
        },
      },
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
    -- fg = find grep (file contents), not vim's /g flag. Project-wide.
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    -- wfg = word find globally: grep the word under the cursor
    vim.keymap.set('n', '<leader>wfg', builtin.grep_string, {})
    -- fb = find buffers. No preview; compact.
    -- Esc (telescope normal mode) then dd deletes the highlighted buffer.
    -- Alt-d (M-d) still works in insert or normal.
    vim.keymap.set('n', '<leader>fb', function()
      builtin.buffers({
        previewer = false,
        layout_config = {
          height = 0.5,
          width = 0.45,
        },
        attach_mappings = function(_, map)
          map("n", "dd", require("telescope.actions").delete_buffer)
          return true
        end,
      })
    end)
  end
}
