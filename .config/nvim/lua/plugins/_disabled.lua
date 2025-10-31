return {
  -- disabled plugins
  { "catppuccin/nvim", enabled = false },
  { "lukas-reineke/headlines.nvim", enabled = false },
  { "echasnovski/mini.files", enabled = false },

  -- disabled plugin keymaps
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      -- disable all telescope keymaps
      return {}
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>ge", false },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false, mode = { "n", "x" } },
    },
  },
}
