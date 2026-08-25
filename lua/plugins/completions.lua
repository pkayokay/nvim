-- Autocompletion: the popup menu that suggests as you type.
--
--   cmp-nvim-lsp      -- source: completions from the attached language server
--   cmp-buffer        -- source: words already present in the open buffer
--   cmp-path          -- source: filesystem paths
--   LuaSnip           -- snippet engine; nvim-cmp delegates snippet expansion to it
--   cmp_luasnip       -- source: feeds LuaSnip's snippets into the cmp menu
--   friendly-snippets -- a library of VS Code style snippets for LuaSnip to load
--   nvim-cmp          -- the completion engine. Draws the menu, but has no suggestions
--                        of its own; everything comes from the "sources" listed below.
--
--   Tab        menu open: accept (same as Enter). Then jump snippet holes.
--   Shift-Tab  previous snippet hole. Indent if none.
return {
  {
    -- Stands alone rather than nesting under nvim-cmp because lsp-config.lua also
    -- requires it, for default_capabilities().
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      -- cmp_luasnip lists snippets in the menu; LuaSnip does the expanding.
      "saadparwaiz1/cmp_luasnip",
      -- Snippet data only -- inert until lazy_load() below reads it.
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    -- Each source is its own plugin; the { name = ... } entries below only work
    -- if the matching plugin is installed, otherwise they are silently ignored.
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      -- Parses the friendly-snippets JSON files into LuaSnip
      require("luasnip.loaders.from_vscode").lazy_load()

      local luasnip = require("luasnip")

      cmp.setup({
        -- nvim-cmp cannot expand snippets itself. Confirm hands the body here;
        -- LuaSnip inserts it with $1 / $2 holes. LuaSnip maps no keys of its
        -- own -- Tab / Shift-Tab below are ours.
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- Named rounded: on Neovim 0.11+ a bare bordered() follows vim.o.winborder.
        -- vim-options sets that to rounded; keep the name so the menu still has
        -- an edge if that option is unset.
        window = {
          completion = cmp.config.window.bordered({ border = "rounded" }),
          documentation = cmp.config.window.bordered({ border = "rounded" }),
        },
        -- preset.insert supplies the usual defaults (C-n / C-p to move through the
        -- menu); the table below adds to them rather than replacing them.
        -- Tab is not "next item". Menu open: accept (same as Enter). After a
        -- snippet expands: jump to the next hole. Else indent.
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- Two groups: cmp only falls back to the second when the first returns
        -- nothing, so buffer words never clutter real LSP results.
        sources = cmp.config.sources({
          -- group_index 0 puts lazydev's Neovim API results above everything else
          { name = "lazydev", group_index = 0 },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
