-- File explorer as a centered float.
--
--   neo-tree.nvim        -- the tree itself (filesystem, buffers, git status sources)
--   plenary.nvim         -- lua utility library (required)
--   nui.nvim             -- UI component library neo-tree renders its windows with
--   nvim-web-devicons    -- filetype icons in the tree (needs a patched Nerd Font)
--
--   <leader>nt  toggle the file tree
--   <leader>nf  reveal the current file in the tree
--
-- In the tree window, / is neo-tree's fuzzy filter (type to jump to a name).

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set("n", "<leader>nt", ":Neotree filesystem toggle float<CR>")
    -- reveal_force_cwd: jump to this buffer even if it is outside the tree's cwd
    vim.keymap.set("n", "<leader>nf", ":Neotree filesystem reveal_force_cwd float<CR>")
  end,
}
