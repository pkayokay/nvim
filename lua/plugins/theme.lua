return {
  "HoNamDuong/hybrid.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("hybrid").setup(opts)
    vim.cmd.colorscheme("hybrid")
  end
}