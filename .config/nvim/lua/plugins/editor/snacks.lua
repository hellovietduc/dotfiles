local function git_discard_everything()
  if vim.fn.confirm("Discard all changes?", "&Yes\n&No") == 1 then
    local cmd = { "git", "restore", ":/" }
    Snacks.picker.util.cmd(cmd, function()
      -- retry once
      Snacks.picker.util.cmd(cmd, function()
        -- no-op
      end)
    end)

    -- trigger autoread or warn the users buffer(s) was changed
    vim.cmd("checktime")
  end
end

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    input = {
      win = {
        keys = {
          -- TODO: this doesn't work
          i_del_word = { "<M-BS>", "delete_word", mode = "i", expr = true },
        },
        actions = {
          delete_word = function()
            return "<cmd>normal! diw<cr><right>"
          end,
        },
      },
    },
    picker = {
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
        },
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
  },
  keys = {
    -- Open projects
    { "<D-p>", "<leader>qS", mode = { "n", "v" }, remap = true },

    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Find Files (Smart)",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files (Root Dir)",
    },

    -- disable, trying the default live grep
    -- {
    --   "<leader>/",
    --   function()
    --     local picker = require("snacks.picker.core.picker")
    --     local last_search = picker and picker.last and picker.last.filter and picker.last.filter.search
    --     Snacks.picker.grep({ search = last_search })
    --   end,
    --   desc = "Grep (Root Dir)",
    -- },

    {
      "<leader>gk",
      function()
        Snacks.picker.git_branches({ preview = "none" })
      end,
      desc = "Checkout",
    },

    {
      "<leader>gt",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Stash",
    },

    {
      "<leader>gd",
      git_discard_everything,
      desc = "Discard",
    },

    -- disable
    { "<leader>gc", false },
  },
}
