-- Colorschemes. hybrid is the default; the rest are installed so you can switch.
--
--   hybrid.nvim          -- default. Dark theme with treesitter/LSP highlights.
--   vim-afterglow        -- afterglow
--   oceanic-next         -- OceanicNext
--
-- lazy = false on all of them so :colorscheme can see every colors/ file at startup.
-- Only hybrid has priority = 1000, so it paints before other plugins draw UI.
-- <C-S-n> / <C-S-p> cycle the list; <C-'> leaves you on :colorscheme to tab-complete.

local themes = {
  "hybrid",
  "afterglow",
  "OceanicNext",
}

-- 1-based index into `themes`. Starts on hybrid, which is also what config() applies.
local theme_index = 1

local function switch_theme(delta)
  -- Wrap: past the last theme goes to the first, before the first goes to the last.
  theme_index = (theme_index - 1 + delta) % #themes + 1
  local name = themes[theme_index]
  vim.cmd.colorscheme(name)
  vim.api.nvim_echo({ { "Theme: " .. name } }, false, {})
end

return {
  {
    "HoNamDuong/hybrid.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("hybrid").setup(opts)
      vim.cmd.colorscheme("hybrid")

      -- Leaves you on :colorscheme so you can tab-complete a name (no <CR>).
      vim.keymap.set("n", "<C-'>", ":colorscheme ")
      vim.keymap.set("n", "<C-S-n>", function() -- next in `themes`
        switch_theme(1)
      end)
      vim.keymap.set("n", "<C-S-p>", function() -- previous in `themes`
        switch_theme(-1)
      end)
    end,
  },
  {
    "danilo-augusto/vim-afterglow",
    lazy = false,
  },
  {
    "mhartington/oceanic-next",
    lazy = false,
  },
}
