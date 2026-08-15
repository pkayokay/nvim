-- Formatting/linting: exposes external CLI tools to Neovim as if they were an LSP server.
--
--   none-ls.nvim   -- maintained fork of null-ls; runs stylua/prettier through the LSP formatting API
--   plenary.nvim   -- lua utility library (required)
--
-- The stylua/prettier binaries come from mason-tool-installer in lsp-config.lua.
-- <leader>gf formats the buffer.
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      },
    })

    -- only let none-ls format, so LSP servers that also format don't compete
    local function format()
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end

    vim.keymap.set("n", "<leader>gf", format, {})

    -- format on save -- uncomment to enable
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   callback = function()
    --     format()
    --   end,
    -- })
  end,
}
