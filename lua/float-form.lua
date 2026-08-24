-- Nested rounded-border form: outer frame + titled 1-line inputs.
-- Used by <leader>fr (find/replace) and <leader>se (project search).
--
-- opts.title, opts.footer, opts.fields (list of box titles),
-- opts.on_submit(values) after the form closes.

local M = {}

function M.open(opts)
  local fields = opts.fields
  local width = math.min(56, vim.o.columns - 8)
  local gap = 2
  local inner_w = math.max(20, width - gap * 2 - 2)
  local height = 1 + #fields * 4
  local field_rows = {}
  for i = 1, #fields do
    field_rows[i] = 1 + (i - 1) * 4
  end

  local parent_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(parent_buf, 0, -1, false, vim.split(string.rep("\n", height), "\n"))
  vim.bo[parent_buf].buftype = "nofile"
  vim.bo[parent_buf].bufhidden = "wipe"
  vim.bo[parent_buf].swapfile = false
  vim.bo[parent_buf].modifiable = false

  local parent_win = vim.api.nvim_open_win(parent_buf, false, {
    relative = "editor",
    width = width,
    height = height,
    row = math.max(0, math.floor((vim.o.lines - (height + 2)) / 2)),
    col = math.max(0, math.floor((vim.o.columns - (width + 2)) / 2)),
    border = "rounded",
    title = opts.title,
    title_pos = "center",
    footer = opts.footer,
    footer_pos = "right",
    style = "minimal",
    zindex = 60,
    focusable = false,
  })

  local inputs = {}
  for i, name in ipairs(fields) do
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    local win = vim.api.nvim_open_win(buf, false, {
      relative = "win",
      win = parent_win,
      width = inner_w,
      height = 1,
      row = field_rows[i],
      col = gap,
      border = "rounded",
      title = " " .. name .. " ",
      title_pos = "left",
      style = "minimal",
      zindex = 61,
    })
    vim.wo[win].wrap = false
    vim.wo[win].cursorline = false
    vim.wo[win].sidescrolloff = 0
    inputs[i] = { buf = buf, win = win }
  end

  local closing = false
  local group = vim.api.nvim_create_augroup("float-form-" .. tostring(parent_win), { clear = true })

  local function close()
    if closing then
      return
    end
    closing = true
    pcall(vim.api.nvim_del_augroup_by_id, group)
    pcall(vim.cmd, "stopinsert")
    for _, input in ipairs(inputs) do
      if vim.api.nvim_win_is_valid(input.win) then
        pcall(vim.api.nvim_win_close, input.win, true)
      end
    end
    if vim.api.nvim_win_is_valid(parent_win) then
      pcall(vim.api.nvim_win_close, parent_win, true)
    end
    for _, input in ipairs(inputs) do
      if vim.api.nvim_buf_is_valid(input.buf) then
        pcall(vim.api.nvim_buf_delete, input.buf, { force = true })
      end
    end
    if vim.api.nvim_buf_is_valid(parent_buf) then
      pcall(vim.api.nvim_buf_delete, parent_buf, { force = true })
    end
  end

  local function values()
    local out = {}
    for i, input in ipairs(inputs) do
      out[i] = vim.trim(table.concat(vim.api.nvim_buf_get_lines(input.buf, 0, -1, false), ""))
    end
    return out
  end

  local on = "FloatBorder:FloatTitle,FloatTitle:FloatTitle,NormalFloat:NormalFloat"
  local off = "FloatBorder:FloatBorder,FloatTitle:Comment,NormalFloat:NormalFloat"

  local function paint_focus(focused_win)
    for _, input in ipairs(inputs) do
      if vim.api.nvim_win_is_valid(input.win) then
        vim.wo[input.win].winhighlight = input.win == focused_win and on or off
      end
    end
  end

  local function focus(win)
    if not vim.api.nvim_win_is_valid(win) then
      return
    end
    vim.api.nvim_set_current_win(win)
    paint_focus(win)
    vim.cmd("startinsert!")
  end

  local function index_of_win(win)
    for i, input in ipairs(inputs) do
      if input.win == win then
        return i
      end
    end
  end

  local function submit()
    local vals = values()
    close()
    vim.schedule(function()
      opts.on_submit(vals)
    end)
  end

  local function next_or_submit()
    local i = index_of_win(vim.api.nvim_get_current_win())
    if i and i < #inputs then
      focus(inputs[i + 1].win)
    else
      submit()
    end
  end

  local function prev_field()
    local i = index_of_win(vim.api.nvim_get_current_win())
    if i and i > 1 then
      focus(inputs[i - 1].win)
    else
      focus(inputs[1].win)
    end
  end

  for _, input in ipairs(inputs) do
    local buf, win = input.buf, input.win
    vim.keymap.set({ "n", "i" }, "<Esc>", function()
      vim.schedule(close)
    end, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<C-c>", function()
      vim.schedule(close)
    end, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<CR>", next_or_submit, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<Tab>", next_or_submit, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<S-Tab>", prev_field, { buffer = buf, nowait = true })
    vim.keymap.set("n", "o", "<nop>", { buffer = buf })
    vim.keymap.set("n", "O", "<nop>", { buffer = buf })
    vim.api.nvim_create_autocmd("WinEnter", {
      group = group,
      buffer = buf,
      callback = function()
        paint_focus(win)
      end,
    })
    vim.api.nvim_create_autocmd("TextChangedI", {
      group = group,
      buffer = buf,
      callback = function()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        if #lines > 1 then
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, { table.concat(lines, "") })
        end
      end,
    })
  end

  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    nested = true,
    callback = function(ev)
      local id = tonumber(ev.match)
      if id == parent_win then
        close()
        return
      end
      for _, input in ipairs(inputs) do
        if id == input.win then
          close()
          return
        end
      end
    end,
  })

  focus(inputs[1].win)
  vim.schedule(function()
    focus(inputs[1].win)
  end)
end

return M
