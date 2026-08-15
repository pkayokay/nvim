-- LSP stack: installs language servers/tools and wires up the keymaps to use them.
--
--   mason.nvim                 -- package manager for LSP servers, formatters, linters (:Mason to browse)
--   mason-lspconfig.nvim       -- bridges mason and nvim-lspconfig; auto-installs + enables the servers below
--   mason-tool-installer.nvim  -- installs non-LSP tools (formatters/linters) that mason-lspconfig ignores
--   nvim-lspconfig             -- default server configs; here it just carries the LSP keymaps
--
-- The tools installed here are consumed elsewhere: stylua/prettier by none-ls.lua.
-- <leader>ca renders through telescope's ui-select extension (telescope.lua), and every
-- <leader> mapping below depends on mapleader being set in vim-options.lua first.
return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = { "lua_ls", "ruby_lsp", "ts_ls", "elixirls", "tailwindcss" },
    }
  },
  {
    -- mason-lspconfig only installs LSP servers; formatters need this
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "stylua", "prettier" },
    }
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end
  }
}
