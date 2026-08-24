-- Persistent terminals. <leader>it toggles the last one you used.
-- <leader>i1–i4 each own a numbered shell (create or hide that slot).
--
--   toggleterm.nvim
--
-- Floating window, rounded border. First press opens a shell; again hides
-- it; again shows the same session still running. Esc leaves the shell
-- (vim-options.lua).

local last_id = 1

local function toggle_last()
  local terms = require("toggleterm.terminal")
  local focused = terms.get_focused_id()
  if focused then
    last_id = focused
    require("toggleterm").toggle(focused)
    return
  end
  require("toggleterm").toggle(last_id)
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    start_in_insert = true,
    on_open = function(term)
      last_id = term.id
    end,
  },
  keys = {
    { "<leader>it", toggle_last }, -- last used (1 if none yet)
    { "<leader>i1", "<cmd>1ToggleTerm<CR>" },
    { "<leader>i2", "<cmd>2ToggleTerm<CR>" },
    { "<leader>i3", "<cmd>3ToggleTerm<CR>" },
    { "<leader>i4", "<cmd>4ToggleTerm<CR>" },
  },
}
