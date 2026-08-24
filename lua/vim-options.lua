-- Core editor settings. Loaded from init.lua BEFORE any plugin, because mapleader
-- has to exist before the plugin files register their <leader> mappings.

-- <leader> is a prefix key you press before a shortcut. Space is the convention.
-- Every "<leader>x" mapping in lua/plugins/ therefore means: press Space, then x.
vim.g.mapleader = " "

-- Indentation
vim.opt.expandtab = true     -- pressing Tab inserts spaces, never a literal tab character
vim.opt.tabstop = 2          -- an existing tab character renders 2 columns wide
vim.opt.softtabstop = 2      -- Tab/Backspace move by 2 spaces, so they feel like one unit
vim.opt.shiftwidth = 2       -- auto-indent and the >> / << commands shift by 2

-- Display
vim.opt.number = true            -- gutter shows absolute line numbers
vim.opt.relativenumber = false   -- off: no distance-from-cursor numbers (for 5j / d3k)
vim.opt.cursorline = true        -- highlight the row the cursor is on
vim.opt.termguicolors = true     -- 24-bit colour; required by most Lua themes
vim.opt.background = "dark"      -- hint for default highlights; does not paint the UI
vim.opt.guicursor = "a:hor20-Cursor" -- horizontal bar cursor in every mode
vim.opt.wrap = false             -- long lines scroll sideways instead of wrapping

-- Splits: where they open, how to create them, how to move between them
vim.opt.splitbelow = true    -- :split opens the new window below, not above
vim.opt.splitright = true    -- :vsplit opens the new window to the right, not left
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>")  -- vertical split; opens right because of splitright
vim.keymap.set("n", "<leader>d\\", ":split<CR>")  -- horizontal split; opens below because of splitbelow
vim.keymap.set("n", "<C-h>", "<C-w>h") -- left  (stock is Ctrl-w then h)
vim.keymap.set("n", "<C-j>", "<C-w>j") -- down
vim.keymap.set("n", "<C-k>", "<C-w>k") -- up
vim.keymap.set("n", "<C-l>", "<C-w>l") -- right

-- Scrolling
vim.opt.scroll = 10          -- Ctrl-d / Ctrl-u jump 10 lines (Neovim may reset this on resize)
vim.opt.scrolloff = 10       -- keep 10 lines visible above and below the cursor
vim.opt.sidescrolloff = 10   -- keep 10 columns visible beside the cursor (wrap is off)

-- Search
vim.opt.ignorecase = true         -- /foo matches foo, Foo, FOO
vim.opt.smartcase = true          -- ignorecase unless the search contains a capital
-- vim.opt.gdefault = true        -- assume /g flag on for :s subtitutions
-- Dialog float with real nested input windows (native rounded borders),
-- titles on the boxes, focused field highlighted. Starts in insert on Find.
-- Enter / Tab jumps to Replace; Enter there runs :%s/find/replace/gc
-- (confirm each match). Esc / Ctrl-c cancels.
-- Example: "foo foo foo" with find foo, replace bar -> "bar bar bar"
-- (% = whole file, g = every match on a line, c = confirm).
vim.keymap.set("n", "<leader>fr", function()
  local target_win = vim.api.nvim_get_current_win()
  local width = math.min(56, vim.o.columns - 8)
  local height = 9
  -- col is the child's *outer* edge (its border), relative to parent content.
  -- Subtract left gap + right gap + the child's own two vertical borders.
  local gap = 2
  local inner_w = math.max(20, width - gap * 2 - 2)
  local pad = gap

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
    title = " Find and replace in file ",
    title_pos = "center",
    footer = " Enter next / replace    Esc cancel ",
    footer_pos = "right",
    style = "minimal",
    zindex = 60,
    focusable = false,
  })

  local function open_field(title, row)
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
      row = row,
      col = pad,
      border = "rounded",
      title = " " .. title .. " ",
      title_pos = "left",
      style = "minimal",
      zindex = 61,
    })
    vim.wo[win].wrap = false
    vim.wo[win].cursorline = false
    vim.wo[win].sidescrolloff = 0
    return buf, win
  end

  local find_buf, find_win = open_field("Find", 1)
  local replace_buf, replace_win = open_field("Replace", 5)

  local closing = false
  local wins = { find_win, replace_win, parent_win }
  local bufs = { find_buf, replace_buf, parent_buf }
  local group = vim.api.nvim_create_augroup("find-replace-form", { clear = true })

  local function close()
    if closing then
      return
    end
    closing = true
    pcall(vim.api.nvim_del_augroup_by_id, group)
    pcall(vim.cmd, "stopinsert")
    for _, w in ipairs(wins) do
      if vim.api.nvim_win_is_valid(w) then
        pcall(vim.api.nvim_win_close, w, true)
      end
    end
    for _, b in ipairs(bufs) do
      if vim.api.nvim_buf_is_valid(b) then
        pcall(vim.api.nvim_buf_delete, b, { force = true })
      end
    end
  end

  local function field_text(buf)
    return vim.trim(table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), ""))
  end

  local function paint_focus(focused_win)
    local on = "FloatBorder:FloatTitle,FloatTitle:FloatTitle,NormalFloat:NormalFloat"
    local off = "FloatBorder:FloatBorder,FloatTitle:Comment,NormalFloat:NormalFloat"
    if vim.api.nvim_win_is_valid(find_win) then
      vim.wo[find_win].winhighlight = focused_win == find_win and on or off
    end
    if vim.api.nvim_win_is_valid(replace_win) then
      vim.wo[replace_win].winhighlight = focused_win == replace_win and on or off
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

  local function submit()
    local find = field_text(find_buf)
    local replace = field_text(replace_buf)
    close()
    vim.schedule(function()
      if find == "" then
        return
      end
      if vim.api.nvim_win_is_valid(target_win) then
        vim.api.nvim_set_current_win(target_win)
      end
      -- pcall: :s E486 inside vim.schedule dumps a lua traceback instead of
      -- the usual "Pattern not found" line.
      local ok, err = pcall(vim.cmd, "%s/" .. find .. "/" .. replace .. "/gc")
      if not ok then
        vim.notify(tostring(err):match("E%d+:.*") or "Pattern not found", vim.log.levels.WARN)
      end
    end)
  end

  local function next_or_submit()
    if vim.api.nvim_get_current_win() == find_win then
      focus(replace_win)
    else
      submit()
    end
  end

  local function map_field(buf, win)
    vim.keymap.set({ "n", "i" }, "<Esc>", function()
      vim.schedule(close)
    end, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<C-c>", function()
      vim.schedule(close)
    end, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<CR>", next_or_submit, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<Tab>", next_or_submit, { buffer = buf, nowait = true })
    vim.keymap.set({ "n", "i" }, "<S-Tab>", function()
      focus(find_win)
    end, { buffer = buf, nowait = true })
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

  map_field(find_buf, find_win)
  map_field(replace_buf, replace_win)

  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    nested = true,
    callback = function(ev)
      local id = tonumber(ev.match)
      if id == find_win or id == replace_win or id == parent_win then
        close()
      end
    end,
  })

  focus(find_win)
  vim.schedule(function()
    focus(find_win)
  end)
end)

-- Clipboard: yank/delete/put use the OS clipboard. dd is cut; <leader>D is true delete.
vim.opt.clipboard = "unnamedplus" -- same pasteboard as unnamed on macOS
vim.keymap.set("n", "<leader>D", '"_dd') -- delete the line without clobbering the yank register

-- Diagnostics
-- Print the diagnostic message inline, to the right of the offending line.
-- Neovim 0.11+ ships this off by default: errors show only as a gutter sign,
-- which reads like the LSP is doing nothing. Use ]d / [d to jump between them.
vim.diagnostic.config({ virtual_text = true })

-- Insert / terminal
vim.keymap.set("i", "jj", "<Esc>") -- escape insert mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- :terminal: Esc leaves the shell; without this, press Ctrl-\ then Ctrl-n

-- Tabs (stock is :tabnew, gt/gT, {count}gt)
vim.keymap.set("n", "<leader><S-t>", ":tabnew<CR>") -- new tab
vim.keymap.set("n", "<leader>1", ":tabn 1<CR>") -- jump to tab 1
vim.keymap.set("n", "<leader>2", ":tabn 2<CR>") -- jump to tab 2
vim.keymap.set("n", "<leader>3", ":tabn 3<CR>") -- jump to tab 3
vim.keymap.set("n", "<leader>4", ":tabn 4<CR>") -- jump to tab 4

--[[ Git blame (visual Ctrl-b)
  Replaces the old :!git blame dump.
  Visual mode only: select lines, then Ctrl-b. In normal mode Ctrl-b is still page-up.
  Step 1: telescope dropdown of blame lines (same UI as <leader>ca code actions).
  Step 2: pick a line -> float with that commit's message (q / Esc to close).
]]
vim.keymap.set("v", "<C-b>", function()
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.fnamemodify(file, ":h")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Leave visual so telescope can take over the UI
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

  -- Step 1: git blame the selected lines, show them in the same telescope
  -- dropdown as <leader>ca (code actions) via vim.ui.select.
  local lines = vim.fn.systemlist({
    "git", "-C", dir, "blame", "--date=short", "-L", start_line .. "," .. end_line, "--", file,
  })
  if vim.v.shell_error ~= 0 then
    vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR)
    return
  end

  vim.ui.select(lines, { prompt = "Git blame" }, function(choice)
    if not choice then
      return
    end
    local hash = choice:match("^(%S+)")
    if not hash or hash:match("^0+$") or hash:match("^0+%^") then
      vim.notify("Not committed yet", vim.log.levels.INFO)
      return
    end
    hash = hash:gsub("%^$", "")

    -- Step 2: still git blame — open that commit's message in a float (q / Esc to close).
    local info = vim.fn.systemlist({ "git", "-C", dir, "show", "-s", hash })
    if vim.v.shell_error ~= 0 then
      vim.notify(table.concat(info, "\n"), vim.log.levels.ERROR)
      return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, info)
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"
    local width = math.min(80, vim.o.columns - 4)
    local height = math.min(math.max(#info + 2, 6), math.floor(vim.o.lines / 2))
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      style = "minimal",
      border = "rounded",
      title = " git blame " .. hash:sub(1, 7) .. " ",
    })
    vim.wo[win].wrap = true
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
    vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = buf, silent = true })
  end)
end)
--[[ end git blame ]]
