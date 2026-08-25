-- Persistent terminals. <leader>it toggles the last one you used.
-- <leader>i1–i6 each own a numbered shell (create or hide that slot).
--
--   toggleterm.nvim
--
-- Floating window, rounded border. First press opens a shell; again hides
-- it; again shows the same session still running. Esc leaves the shell
-- (vim-options.lua). Border title is "Terminal 1" or
-- "Terminal 1 (2 open)" when more than one exists.

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

local function set_border_title(term)
  last_id = term.id
  if not (term.window and vim.api.nvim_win_is_valid(term.window)) then
    return
  end
  local n = #require("toggleterm.terminal").get_all()
  local title = n > 1 and string.format(" Terminal %d (%d open) ", term.id, n)
    or string.format(" Terminal %d ", term.id)
  vim.api.nvim_win_set_config(term.window, {
    title = title,
    title_pos = "center",
  })
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float",
    float_opts = {
      border = "rounded",
      title_pos = "center",
    },
    start_in_insert = true,
    on_open = set_border_title,
  },
  keys = {
    { "<leader>it", toggle_last }, -- last used (1 if none yet)
    { "<leader>i1", "<cmd>1ToggleTerm<CR>" },
    { "<leader>i2", "<cmd>2ToggleTerm<CR>" },
    { "<leader>i3", "<cmd>3ToggleTerm<CR>" },
    { "<leader>i4", "<cmd>4ToggleTerm<CR>" },
    { "<leader>i5", "<cmd>5ToggleTerm<CR>" },
    { "<leader>i6", "<cmd>6ToggleTerm<CR>" },
  },
}
