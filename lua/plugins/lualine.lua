-- Statusline: the bar at the bottom of each window (mode, file, git, cursor).
-- nvim-web-devicons is already used by neo-tree.
--
-- The bar is split into sections, left to right:
--   A  mode (NORMAL / INSERT / VISUAL)
--   B  git branch, diff counts, LSP diagnostics
--   C  filename
--   X  encoding / line endings / filetype   (right side starts here)
--   Y  percent through the file
--   Z  line:column
--
-- theme = "auto" follows the colorscheme.
-- path = 1 is a relative path (lua/plugins/lualine.lua).
-- No tabline.

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        -- path = 1: relative path (lua/plugins/lualine.lua). 0 = tail only, 2 = absolute
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
