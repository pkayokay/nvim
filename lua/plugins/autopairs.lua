-- Insert-mode auto-pairs. Type ( and you get (); same for quotes, brackets,
-- backticks. Typing the closer skips over the one it already inserted.
-- Backspace on an empty pair deletes both. Enter between braces opens a
-- new indented line.
--
--   nvim-autopairs
--
-- Replaces delimitMate. Stock defaults. Loads on first insert. Does not add
-- `end` after Ruby def (that's vim-endwise, still unported).

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({})

    -- nvim-cmp's Enter confirms a completion. After that, insert () when the
    -- item is a function or method so you don't have to type the parens.
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
