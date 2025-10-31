-- modern vscode like git diff view and merge tool

-- https://github.com/sindrets/diffview.nvim/issues/11#issuecomment-1110280827
local function toggle_diff_view(view)
  return function()
    local lib = require("diffview.lib")
    local current_view = lib.get_current_view()
    if current_view then
      -- Current tabpage is a Diffview; close it
      vim.cmd(":DiffviewClose")
    else
      -- No open Diffview exists: open a new one
      vim.cmd(":" .. view)
    end
  end
end

return {
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          disable_diagnostics = true,
        },
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      file_panel = {
        listing_style = "list",
        win_config = {
          width = 40,
        },
      },
      keymaps = {
        view = {
          { "n", "<D-r>", ":DiffviewRefresh<CR>", { desc = "Refresh", silent = true } },
        },
        file_panel = {
          { "n", "<D-r>", ":DiffviewRefresh<CR>", { desc = "Refresh", silent = true } },
        },
        file_history_panel = {
          { "n", "<D-r>", ":DiffviewRefresh<CR>", { desc = "Refresh", silent = true } },
        },
      },
    },
    keys = {
      {
        "<leader>gs",
        toggle_diff_view("DiffviewOpen"),
        desc = "Status / Stage",
      },
      {
        "<leader>gl",
        toggle_diff_view("DiffviewFileHistory"),
        desc = "Git Log",
      },
      {
        "<leader>gf",
        toggle_diff_view("DiffviewFileHistory %"),
        desc = "File Log",
      },
      {
        "<leader>gx",
        ":DiffviewClose<CR>",
        desc = "Close diffview.nvim",
      },
    },
  },

  -- delete snacks keymap for git status
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gs", false },
    },
  },
}
