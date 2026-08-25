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
-- The tools installed here are consumed elsewhere: stylua/prettier by none-ls.lua,
-- and <leader>ca renders through telescope's ui-select extension (telescope.lua).
--
--   K           hover docs
--   <leader>gd  go to definition
--   <leader>gr  list references (telescope)
--   <leader>ca  code actions (telescope dropdown)
--   <leader>rn  rename
--
-- Jump diagnostics with stock [d / ]d (see vim-options.lua for virtual_text).
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
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Tells every server this client can do snippets and resolve, which is what
      -- unlocks auto-imports and expandable signatures in the cmp menu.
      -- The '*' applies it to all servers: tutorials attach capabilities inside
      -- lspconfig.<server>.setup(), but nothing here calls setup() -- mason-lspconfig
      -- auto-enables the servers instead (see the note above).
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", function()
        require("telescope.builtin").lsp_references()
      end)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end
  }
}
