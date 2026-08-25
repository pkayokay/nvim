-- Formatting/linting: exposes external CLI tools to Neovim as if they were an LSP server.
--
--   none-ls.nvim   -- maintained fork of null-ls. Registers a client literally named "null-ls",
--                     so CLI tools reach Neovim through the same API as real servers.
--                     Handles formatters and linters; only formatters are wired up below.
--   plenary.nvim   -- lua utility library (required)
--
-- Three layers (Space gf hits the same vim.lsp.buf.format() for all of them):
--
--   LSP          background per language (ruby_lsp, elixirls, …). Understands the
--                project: gd / gr / rn / diagnostics. Sometimes can format too.
--   Formatter    whatever rewrites style (stylua, prettier, mix format, …).
--   none-ls      fake LSP client that runs CLI formatters so format() can use them.
--
--   Language       Who formats                         Via
--   Lua            stylua                              none-ls
--   JS/TS/HTML/…   prettier                            none-ls
--   Elixir/HEEx    mix format (+ .formatter.exs)       none-ls
--   Ruby           Gemfile gem (standard/rubocop/…)    ruby_lsp (auto)
--
-- The stylua/prettier binaries come from mason-tool-installer in lsp-config.lua.
-- mix format ships with Elixir (same install as elixirls). HEEx/EEx use the
-- project's .formatter.exs (Phoenix.LiveView.HTMLFormatter) via --stdin-filename.
-- Ruby has no none-ls source: ruby_lsp auto-detects standard / rubocop /
-- syntax_tree from the project's Gemfile (formatter = "auto" default).
--
--   <leader>gf  format the current file. Prefers none-ls when it applies
--               (stylua / prettier / mix); otherwise the language server
--               (ruby_lsp + whatever the Gemfile lists).
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

    -- Prefer none-ls when it is attached (Lua / JS / Elixir), so lua_ls /
    -- ts_ls / elixirls do not fight it. Ruby has no none-ls source, so
    -- Space gf falls through to ruby_lsp (Gemfile formatter).
    local function format()
      local bufnr = vim.api.nvim_get_current_buf()
      local prefer_null_ls = #vim.lsp.get_clients({ bufnr = bufnr, name = "null-ls" }) > 0
      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
          if prefer_null_ls then
            return client.name == "null-ls"
          end
          return client.name ~= "null-ls"
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
