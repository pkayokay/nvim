-- Project search + edit (Sublime-style). Uses ripgrep if installed.
--
--   ctrlsf.vim
--
--   <leader>se  boxed search float (same UI as <leader>fr), Enter
--   <leader>st  hide/show the results panel
--
-- Results are a buffer: edit match lines, :w writes them back to the files.
-- Then :%s in that buffer + :w is project replace on the search you just ran.
--
-- regex_pattern: query is a regex.
-- auto_focus at start: jump into the results when the search finishes.
-- Don't auto-close when you open a file. compact_winsize only applies if
-- you switch to compact view (M in the results).
--
-- ctrlsf has no center/float option (only left/right/top/bottom splits).
-- After it opens the split, we convert that window to a centered float.
-- Preview stays inside the main window so it does not open a second split.
--
-- The query is passed as one :CtrlSF argument (nvim_cmd args), not glued
-- into vim.cmd("CtrlSF " .. text). Spaces stay in the pattern; | is not
-- treated as a second Ex command.

local function prompt_search()
  require("float-form").open({
    title = " Project search (ctrlsf) ",
    footer = " Enter search    Esc cancel ",
    fields = { "Search" },
    on_submit = function(values)
      local text = values[1] or ""
      if text ~= "" then
        -- args table: the query is one argument (spaces stay; | does not chain)
        vim.api.nvim_cmd({ cmd = "CtrlSF", args = { text } }, {})
      end
    end,
  })
end

local function float_results(win)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  local width = math.min(math.max(60, math.floor(vim.o.columns * 0.8)), vim.o.columns - 2)
  local height = math.min(math.max(16, math.floor(vim.o.lines * 0.8)), vim.o.lines - 4)
  vim.api.nvim_win_set_config(win, {
    relative = "editor",
    width = width,
    height = height,
    row = math.max(0, math.floor((vim.o.lines - height) / 2) - 1),
    col = math.max(0, math.floor((vim.o.columns - width) / 2)),
    border = "rounded",
    title = " CtrlSF ",
    title_pos = "center",
    zindex = 50,
  })
end

return {
  "dyng/ctrlsf.vim",
  cmd = { "CtrlSF", "CtrlSFToggle", "CtrlSFOpen", "CtrlSFUpdate" },
  init = function()
    vim.g.ctrlsf_regex_pattern = 1
    vim.g.ctrlsf_auto_focus = { at = "start" }
    vim.g.ctrlsf_compact_winsize = "80%"
    vim.g.ctrlsf_auto_close = { normal = 0, compact = 0 }
    vim.g.ctrlsf_default_view_mode = "normal"
    vim.g.ctrlsf_position = "bottom"
    vim.g.ctrlsf_preview_position = "inside"
  end,
  config = function()
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = vim.api.nvim_create_augroup("ctrlsf-float", { clear = true }),
      callback = function(ev)
        if not vim.api.nvim_buf_get_name(ev.buf):match("__CtrlSF__$") then
          return
        end
        vim.schedule(function()
          float_results(vim.fn.bufwinid(ev.buf))
        end)
      end,
    })
  end,
  keys = {
    { "<leader>se", prompt_search },
    { "<leader>st", "<cmd>CtrlSFToggle<CR>" },
  },
}
