-- Git signs in the gutter (the column left of the line numbers): added,
-- changed, and deleted lines vs HEAD. Lua replacement for vim-gitgutter.
--
-- Signs match vim-gitgutter glyphs. Hunk colors are the old gitgutter hex
-- values (GitSignsAdd/Change/Delete). ColorScheme re-applies them because
-- :colorscheme clears highlights, including after <C-S-n>/<C-S-p>.
-- signs_staged_enable = false: gitgutter diffs against the index, so staged
-- hunks disappear from the gutter instead of getting a second sign set.
--
-- Not the same as lualine's branch/diff counts (that's a summary in the bar)
-- or visual Ctrl-b blame (that's in vim-options.lua).
--
-- highlight Directory from the old file is not gitgutter — still in init.vim.

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- Same characters gitgutter uses (defaults are all ┃ except delete).
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~_" },
    },
    signs_staged_enable = false,
  },
  config = function(_, opts)
    vim.opt.signcolumn = "yes" -- always show the gutter column (default auto hides until signs exist)
    require("gitsigns").setup(opts)

    local function hunk_colors()
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#859c61" }) -- GitGutterAdd
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#f9c269" }) -- GitGutterChange
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#c77532" }) -- GitGutterDelete
    end

    hunk_colors()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("gitsigns_hunk_colors", { clear = true }),
      callback = hunk_colors,
    })
  end,
}
