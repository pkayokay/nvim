-- Open the current file (or visual selection as a line range) on GitHub.
--
--   open-browser.vim         -- generic "open this URL in a browser" (required)
--   open-browser-github.vim  -- :OpenGithubFile, :OpenGithubProject, etc.
--
-- Visual Ctrl-\ only. Normal-mode Ctrl-\ is unused here
-- (in :terminal, Ctrl-\ Ctrl-n still leaves the shell — different mode).
-- always_used_branch = main: links use main even if you are on a feature
-- branch, so the URL does not 404 when that branch is not on the remote.

return {
  "tyru/open-browser-github.vim",
  dependencies = { "tyru/open-browser.vim" },
  init = function()
    vim.g.openbrowser_github_always_used_branch = "main"
  end,
  keys = {
    { "<C-\\>", ":OpenGithubFile<CR>", mode = "v" },
  },
}
