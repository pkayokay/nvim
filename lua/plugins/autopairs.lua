-- Insert-mode auto-pairs. Type ( and you get (); same for quotes, brackets,
-- backticks. Typing the closer skips over the one it already inserted.
-- Backspace on an empty pair deletes both. Enter between braces opens a
-- new indented line. Enter after Ruby/Lua/Elixir openers (def, if, do, …)
-- inserts the matching `end`.
--
--   nvim-autopairs
--
-- Loads on first insert.

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({})
    npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
    npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
    npairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))

    -- nvim-cmp's Enter confirms a completion. After that, insert () when the
    -- item is a function or method so you don't have to type the parens.
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
