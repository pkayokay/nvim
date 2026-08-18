-- Teaches lua_ls that this is a Neovim config.
--
-- lua-language-server analyses files as plain Lua, where no global named `vim`
-- exists -- hence "Undefined global `vim`" on every line. lazydev points it at
-- Neovim's own type definitions, so the warnings stop AND `vim.` completes with
-- real signatures and docs. Declaring `vim` as a known global would only do the
-- first half.
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- vim.uv is the LuaJIT libuv binding; its types ship separately
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
