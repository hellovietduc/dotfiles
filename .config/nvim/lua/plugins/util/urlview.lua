return {
  "axieax/urlview.nvim",
  opts = {
    default_action = "system", -- open in browser
  },
  keys = {
    { "<leader>fl", ":UrlView<CR>", desc = "Find URLs in Buffer", silent = true },
    { "<leader>fL", ":UrlView lazy<CR>", desc = "Open Lazy Plugins", silent = true },
  },
}
