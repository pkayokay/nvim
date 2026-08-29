-- afterglow-monokai — local colorscheme only (colors/afterglow-monokai.lua).
-- No remote theme plugins. Boots via lua/afterglow-monokai with priority = 1000.

return {
  {
    name = "afterglow-monokai",
    dir = vim.fn.stdpath("config") .. "/lua/afterglow-monokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("afterglow-monokai")
    end,
  },
}
