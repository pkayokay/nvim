-- Formatting/linting: exposes external CLI tools to Neovim as if they were an LSP server.
--
--   none-ls.nvim   -- maintained fork of null-ls. Registers a client literally named "null-ls",
--                     so CLI tools reach Neovim through the same API as real servers.
--                     Handles formatters and linters; only formatters are wired up below.
--   plenary.nvim   -- lua utility library (required)
--
-- The stylua/prettier binaries come from mason-tool-installer in lsp-config.lua.
-- mix format ships with Elixir (same install as elixirls). HEEx/EEx use the
-- project's .formatter.exs (Phoenix.LiveView.HTMLFormatter) via --stdin-filename.
--
--   <leader>gf  format the current file (none-ls only; skips competing LSP formatters)
--
-- Format on save is written but commented out at the bottom.
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        -- Phoenix-recommended: mix format (+ HEEx via .formatter.exs plugin)
        null_ls.builtins.formatting.mix.with({
          extra_filetypes = { "heex", "eex" },
        }),
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
