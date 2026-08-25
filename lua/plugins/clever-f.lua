-- Smarter f / F / t / T on this line. Stock Vim already jumps; this plugin
-- changes how you *repeat* and lights up the matches.
--
--   clever-f.vim
--
--   What          Stock              clever-f
--   First jump    fe                 fe
--   Next match    ;                  f again
--   Previous      ,                  F
--   Highlights    none               yes
--   fa vs fA      exact (unless      smart_case: fa matches a and A,
--                 ignorecase)        fA matches only A
--
-- lazy = false so f/t are remapped from startup.

return {
  "rhysd/clever-f.vim",
  lazy = false,
  init = function()
    vim.g.clever_f_smart_case = 1 -- fa matches a/A; fA is exact
  end,
  config = function()
    -- Default CleverFDefaultLabel is red. Gold matches GitSignsChange.
    local function mark_color()
      vim.api.nvim_set_hl(0, "CleverFDefaultLabel", { fg = "#f9c269", bold = true })
    end
    mark_color()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("clever_f_marks", { clear = true }),
      callback = mark_color,
    })
  end,
}
