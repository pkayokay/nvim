-- Debugging: step through running code with breakpoints, instead of adding prints.
--
--   nvim-dap     -- the debug adapter client. Speaks the Debug Adapter Protocol, but
--                   ships no adapters: each language needs its own (ruby, node, ...).
--   nvim-dap-ui  -- panels for scopes, breakpoints, stack frames, watches and the repl.
--                   nvim-dap works without it, but exposes no interface of its own.
--   nvim-nio     -- async primitives nvim-dap-ui is built on (a hard requirement)
return {
  "mfussenegger/nvim-dap",
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

    vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
    vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
    vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
    vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
  end,
}
