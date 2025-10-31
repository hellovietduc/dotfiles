return {
  "coder/claudecode.nvim",
  opts = {
    terminal = {
      split_width_percentage = 0.40,
      snacks_win_opts = {
        keys = {
          claude_hide_alt = {
            "<D-l>",
            function(self)
              self:hide()
            end,
            mode = "t",
            desc = "Hide",
          },
        },
      },
    },

    diff_opts = {
      keep_terminal_focus = true, -- If true, moves focus back to terminal after diff opens
    },
  },
  keys = {
    { "<D-l>", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = "n" },
    {
      "<D-l>",
      function()
        vim.cmd("ClaudeCodeSend")
        vim.defer_fn(function()
          vim.cmd("ClaudeCodeFocus")
        end, 0)
      end,
      mode = { "x", "v" },
      desc = "Send to Claude",
    },
  },
}
