-- LSP stack: installs language servers/tools and wires up the keymaps to use them.
--
--   mason.nvim                 -- pure installer: downloads binaries to mason/bin (:Mason to browse).
--                                 Knows nothing about LSP -- it installs linters and DAP adapters too.
--   mason-lspconfig.nvim       -- the bridge. Maps package names to lspconfig names
--                                 (lua-language-server <-> lua_ls), and with automatic_enable
--                                 (on by default) calls vim.lsp.enable() for each installed server.
--   mason-tool-installer.nvim  -- installs non-LSP tools (formatters/linters) that mason-lspconfig ignores
--   nvim-lspconfig             -- supplies the server definitions (cmd, filetypes, root markers) that
--                                 vim.lsp.enable() resolves off the runtimepath; also holds the keymaps
--
-- Nothing here calls .setup() on a server: mason-lspconfig enables them, lspconfig defines them.
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
