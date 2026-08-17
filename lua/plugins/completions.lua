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

      cmp.setup({
        -- nvim-cmp cannot expand snippets itself. When you accept a snippet it
        -- hands the body here, and LuaSnip inserts it with jumpable placeholders
        -- (Tab / Shift-Tab to move between them -- LuaSnip's own default keys).
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- The border has to be named explicitly: on Neovim 0.11+ a bare bordered()
        -- inherits vim.o.winborder, which defaults to "none" -- so the menu and the
        -- docs window render flush against each other with no visible edge.
        window = {
          completion = cmp.config.window.bordered({ border = "rounded" }),
          documentation = cmp.config.window.bordered({ border = "rounded" }),
        },
        -- preset.insert supplies the usual defaults (C-n / C-p to move through the
        -- menu); the table below adds to them rather than replacing them.
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        -- Two groups: cmp only falls back to the second when the first returns
        -- nothing, so buffer words never clutter real LSP results.
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
