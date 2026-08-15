-- File explorer sidebar/float, opened with <C-n>.
--
--   neo-tree.nvim        -- the tree itself (filesystem, buffers, git status sources)
--   plenary.nvim         -- lua utility library (required)
--   nui.nvim             -- UI component library neo-tree renders its windows with
--   nvim-web-devicons    -- filetype icons in the tree (needs a patched Nerd Font)
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal float<CR>')
  end
}
