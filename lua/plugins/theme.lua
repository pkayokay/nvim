-- Colorscheme: hybrid.nvim, a dark theme with treesitter/LSP highlight support.
-- priority = 1000 + lazy = false so colors load before any other plugin draws UI.
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