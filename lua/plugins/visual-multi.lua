-- VS Code Cmd-D / Cmd-Shift-L style multi-cursors.
--
--   vim-visual-multi
--
--   Cursor on foo (normal mode, not insert)
--   Ctrl-n               select this foo, again adds the next
--   Ctrl-Shift-l         cursors on every foo in the file
--   V then Ctrl-Shift-l  caret at the end of each selected line
--   q                    skip this one, take the next
--   c                    change all of them
--   Esc                  leave
--
-- Insert Ctrl-n is still nvim-cmp. Terminals usually eat Cmd-d / Cmd-Shift-l.
-- lazy = false so Ctrl-n is remapped from startup.

return {
  "mg979/vim-visual-multi",
  lazy = false,
  init = function()
    -- Before load. Off: do not steal Ctrl-Up/Down. Find Under stays Ctrl-n.
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ["Select All"] = "<C-S-l>",
      ["Visual Cursors"] = "\\c", -- one caret per selected line (same column)
    }
    -- Default underlines every match. Off: gold caret only.
    vim.g.VM_highlight_matches = "hi Search guifg=NONE guibg=NONE gui=NONE"
  end,
  config = function()
    vim.keymap.set("n", "<D-d>", "<Plug>(VM-Find-Under)")
    vim.keymap.set("x", "<D-d>", "<Plug>(VM-Find-Subword-Under)")
    vim.keymap.set("n", "<D-S-l>", "<Plug>(VM-Select-All)")

    local function visual_cursors_eol()
      local keys = vim.api.nvim_replace_termcodes("<Plug>(VM-Visual-Cursors)$", true, false, true)
      vim.api.nvim_feedkeys(keys, "m", false)
    end
    vim.keymap.set("x", "<C-S-l>", visual_cursors_eol)
    vim.keymap.set("x", "<D-S-l>", visual_cursors_eol)

    -- Gold caret (hybrid Visual is too faint). Block cursor while VM is on.
    local gold = { fg = "#1c1c1c", bg = "#f9c269", bold = true }
    local none = { fg = "NONE", bg = "NONE", reverse = false, underline = false, bold = false }
    local saved_search = {}

    local function cursor_hl()
      vim.api.nvim_set_hl(0, "VM_Cursor", gold)
      vim.api.nvim_set_hl(0, "VM_Mono", gold)
      vim.api.nvim_set_hl(0, "VM_Insert", gold)
      vim.api.nvim_set_hl(0, "MultiCursor", gold)
      vim.api.nvim_set_hl(0, "VM_Extend", none) -- selected word: no wash, caret only
    end

    local function hide_search_hl()
      saved_search.CurSearch = vim.api.nvim_get_hl(0, { name = "CurSearch", link = false })
      saved_search.IncSearch = vim.api.nvim_get_hl(0, { name = "IncSearch", link = false })
      vim.api.nvim_set_hl(0, "CurSearch", none)
      vim.api.nvim_set_hl(0, "IncSearch", none)
    end

    local function restore_search_hl()
      if saved_search.CurSearch then
        vim.api.nvim_set_hl(0, "CurSearch", saved_search.CurSearch)
      end
      if saved_search.IncSearch then
        vim.api.nvim_set_hl(0, "IncSearch", saved_search.IncSearch)
      end
      saved_search = {}
    end

    cursor_hl()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("visual_multi_cursor", { clear = true }),
      callback = function()
        vim.schedule(cursor_hl)
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_start",
      group = vim.api.nvim_create_augroup("visual_multi_cursor_mode", { clear = true }),
      callback = function()
        vim.b.vm_prev_guicursor = vim.o.guicursor
        vim.opt.guicursor = "a:block-VM_Cursor"
        hide_search_hl()
        vim.schedule(cursor_hl)
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_exit",
      group = vim.api.nvim_create_augroup("visual_multi_cursor_mode_exit", { clear = true }),
      callback = function()
        vim.opt.guicursor = vim.b.vm_prev_guicursor or "a:hor20-Cursor"
        restore_search_hl()
      end,
    })
  end,
}
