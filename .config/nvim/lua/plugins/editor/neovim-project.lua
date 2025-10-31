if true then
  return {}
end

return {
  "coffebar/neovim-project",
  cond = not not vim.g.neovide,
  priority = 100,
  lazy = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "Shatur/neovim-session-manager" },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.

    -- https://github.com/Shatur/neovim-session-manager/issues/133
    vim.opt.sessionoptions:remove("folds")
  end,
  opts = {
    picker = {
      type = "snacks",
    },
    projects = { -- define project roots
      "~/starkindustries/*",
      "~/starkindustries/mozart/packages/*",
      "~/starkindustries/mozart/serverless/*",
      "~/starkindustries/mozart/services/*",
      "~/starkindustries/mozart/tests/playwright",
      "~/tonystark/*",
    },
  },
  keys = {
    { "<D-p>", ":NeovimProjectDiscover<CR>", mode = { "n", "v" }, silent = true },
  },
}
