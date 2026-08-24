-- Git signs in the gutter (the column left of the line numbers): added,
-- changed, and deleted lines vs HEAD.
--
-- ColorScheme re-applies hunk colors because :colorscheme clears highlights,
-- including after <C-S-n>/<C-S-p>.
-- signs_staged_enable = false: only unstaged hunks in the gutter (no second
-- sign set for staged).
--
-- Not the same as lualine's branch/diff counts (that's a summary in the bar)
-- or visual Ctrl-b blame (that's in vim-options.lua).

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- Defaults are all ┃ except delete.
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
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#859c61" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#f9c269" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#c77532" })
    end

    hunk_colors()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("gitsigns_hunk_colors", { clear = true }),
      callback = hunk_colors,
    })
  end,
}
