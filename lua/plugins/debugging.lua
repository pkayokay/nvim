-- Debugging: step through running code with breakpoints, instead of adding prints.
--
-- DISABLED. Prefer binding.pry / IEx.pry / browser DevTools for now. Flip
-- `enabled` to true and wire a language adapter when you want DAP back.
--
--   nvim-dap     -- the debug adapter client. Speaks the Debug Adapter Protocol, but
--                   ships no adapters: each language needs its own (ruby, node, ...).
--   nvim-dap-ui  -- panels for scopes, breakpoints, stack frames, watches and the repl.
--                   nvim-dap works without it, but exposes no interface of its own.
--   nvim-nio     -- async primitives nvim-dap-ui is built on (a hard requirement)
--
-- NOTHING RUNS UNTIL A LANGUAGE ADAPTER IS ADDED. nvim-dap is only the client; it
-- ships no debuggers. Each language needs two things: the adapter binary (mason has
-- js-debug-adapter, debugpy, delve; Ruby's rdbg comes from the `debug` gem instead),
-- and a dap.adapters.<name> + dap.configurations.<filetype> pair telling nvim-dap how
-- to launch it. Until then the keymaps below set breakpoints that never get hit --
-- check with :lua print(vim.inspect(require("dap").adapters))
--
--   <leader>dt  toggle breakpoint
--   <leader>dc  start / continue
--   <leader>dx  terminate session
--   <leader>do  step over
return {
  "mfussenegger/nvim-dap",
  enabled = false,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    -- Async library nvim-dap-ui depends on; it errors on setup without it.
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("dapui").setup()
    local dap, dapui = require("dap"), require("dapui")

    -- Open the UI whenever a session starts and close it when the session ends,
    -- so the panels are never left hanging around outside a debug run.
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>")
    vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>")
    vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>")
    vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>")
  end,
}
