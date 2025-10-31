return {
  "folke/noice.nvim",
  opts = function(_, opts)
    -- show search bar at top
    opts.presets.bottom_search = false

    -- table.insert(opts.routes, {
    --   filter = {
    --     event = "notify",
    --     find = "No information available",
    --   },
    --   opts = { skip = true },
    -- })
    --
    -- table.insert(opts.routes, {
    --   filter = {
    --     error = true,
    --     find = "Request textDocument/documentHighlight failed with message",
    --   },
    --   opts = { skip = true },
    -- })
  end,
  keys = {
    -- copied keymaps and change to <leader>N
    -- https://github.com/LazyVim/LazyVim/blob/12818a6cb499456f4903c5d8e68af43753ebc869/lua/lazyvim/plugins/ui.lua#L297
    { "<leader>N", "", desc = "Noice" },
    {
      "<leader>Nl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message",
    },
    {
      "<leader>Nh",
      function()
        require("noice").cmd("history")
      end,
      desc = "Noice History",
    },
    {
      "<leader>Na",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice All",
    },
    {
      "<leader>Nd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss All",
    },
    {
      "<leader>Nt",
      function()
        require("noice").cmd("pick")
      end,
      desc = "Noice Picker (Telescope/FzfLua)",
    },

    -- disable <leader>sn keymaps
    { "<leader>sn", false },
    { "<leader>snl", false },
    { "<leader>snh", false },
    { "<leader>sna", false },
    { "<leader>snd", false },
    { "<leader>snt", false },
  },
}
