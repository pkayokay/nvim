-- Lua test runner with a results panel (replaces vim-test as the UI).
--
--   neotest              -- runner + summary UI
--   nvim-nio             -- async library neotest requires
--   neotest-rspec        -- Ruby RSpec (*_spec.rb)
--   neotest-minitest     -- Ruby Minitest (*_test.rb) — Rails default
--   neotest-jest         -- JS/TS Jest
--   neotest-vitest       -- JS/TS Vitest
--   neotest-elixir       -- Elixir ExUnit
--   vim-test + neotest-vim-test -- auto-detect only, NOT a second runner.
--     No vim-test maps. Dedicated adapters miss some files (strict names).
--     vim-test is the looser auto-detect; neotest-vim-test feeds those files
--     into neotest. Run with tn/ta/tp/ts only. A test may appear twice if
--     both a dedicated adapter and vim-test match the file.
--
--   <leader>tn  nearest (old vim-test key)
--   <leader>ta  this file (old vim-test key)
--   <leader>tp  pick a test (telescope dropdown, same UI as <leader>ca)
--   <leader>ts  toggle the summary tree

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "vim-test/vim-test", -- auto-detect only — not mapped, not the UI
    "nvim-neotest/neotest-vim-test", -- auto-detect: vim-test's file guess → neotest
    "olimorris/neotest-rspec",
    "zidhuss/neotest-minitest",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "jfpedroza/neotest-elixir",
  },
  config = function()
    require("neotest").setup({
      floating = {
        border = "rounded", -- same as cmp / git blame floats
      },
      adapters = {
        require("neotest-rspec"),
        require("neotest-minitest"),
        require("neotest-jest"),
        require("neotest-vitest"),
        require("neotest-elixir"),
        require("neotest-vim-test"), -- auto-detect fallback; run still goes through neotest
      },
    })

    local neotest = require("neotest")
    vim.keymap.set("n", "<leader>tn", function() -- nearest
      neotest.run.run()
    end)
    vim.keymap.set("n", "<leader>ta", function() -- this file
      neotest.run.run(vim.fn.expand("%"))
    end)
    vim.keymap.set("n", "<leader>ts", function() -- summary panel
      neotest.summary.toggle()
    end)
    -- Lists tests in this file via vim.ui.select (telescope-ui-select).
    vim.keymap.set("n", "<leader>tp", function()
      require("nio").run(function()
        local file = require("nio").fn.expand("%:p")
        local tree = neotest.run.get_tree_from_args({ file }, false)
        require("nio").scheduler()
        if not tree then
          vim.notify("No tests in this file", vim.log.levels.WARN)
          return
        end
        local tests = {}
        for _, pos in tree:iter() do
          if pos.type == "test" then
            tests[#tests + 1] = pos
          end
        end
        if #tests == 0 then
          vim.notify("No tests in this file", vim.log.levels.WARN)
          return
        end
        vim.ui.select(tests, {
          prompt = "Run test",
          format_item = function(pos)
            return pos.name
          end,
        }, function(choice)
          if choice then
            neotest.run.run(choice.id)
          end
        end)
      end)
    end)
  end,
}
