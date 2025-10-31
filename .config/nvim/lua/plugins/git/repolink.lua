-- copy git url to clipboard
return {
  "9seconds/repolink.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "RepoLink",
  },
  opts = {
    use_full_commit_hash = true,
  },
  keys = {
    { "<leader>y", "", desc = "Yank", mode = { "n", "v" } },
    { "<leader>yl", ":RepoLink!<CR>", mode = { "n", "v" }, desc = "Copy git URL", silent = true },
    {
      "<leader>yf",
      function()
        local filepath = vim.fn.expand("%:p")
        vim.fn.setreg("+", filepath)
        vim.notify(filepath)
      end,
      mode = { "n", "v" },
      desc = "Copy absolute file path",
      silent = true,
    },
    {
      "<leader>yp",
      function()
        local filepath = vim.fn.expand("%:.")
        vim.fn.setreg("+", filepath)
        vim.notify(filepath)
      end,
      mode = { "n", "v" },
      desc = "Copy relative file path",
      silent = true,
    },
    {
      "<leader>yn",
      function()
        local filename = vim.fn.expand("%:t")
        vim.fn.setreg("+", filename)
        vim.notify(filename)
      end,
      mode = { "n", "v" },
      desc = "Copy file name",
      silent = true,
    },
  },
}
