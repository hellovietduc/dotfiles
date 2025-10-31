return {
  "nvim-mini/mini.animate",
  cond = not vim.g.neovide,
  opts = {
    -- don't animate the cursor
    cursor = {
      enable = false,
    },
  },
}
