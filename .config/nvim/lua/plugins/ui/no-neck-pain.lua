-- Center buffer horizontally on the screen
return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    cond = not not vim.g.neovide,
    opts = {
      width = 120,
      buffers = {
        -- left padding only
        right = { enabled = false },
      },
    },
    keys = {
      { "<leader>n", "", desc = "NoNeckPain" },
      { "<leader>np", ":NoNeckPain<CR>", desc = "NoNeckPain", silent = true },
      { "<leader>nh", ":NoNeckPainToggleLeftSide<CR>", desc = "Toggle Left Side", silent = true },
      { "<leader>nl", ":NoNeckPainToggleRightSide<CR>", desc = "Toggle Right Side", silent = true },
      { "<leader>nj", ":NoNeckPainWidthDown<CR>", desc = "Decrease Width", silent = true },
      { "<leader>nk", ":NoNeckPainWidthUp<CR>", desc = "Increase Width", silent = true },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>n", false },
    },
  },
}
