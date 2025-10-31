-- toggleable terminal that persists
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cond = not not vim.g.neovide,
  opts = {
    open_mapping = [[<D-j>]],
    autochdir = true,

    -- always enter insert mode when navigating to the terminal
    start_in_insert = true,
    persist_mode = false,

    direction = "horizontal",
    size = function(term)
      if term.direction == "horizontal" then
        return 30
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,

    on_create = function(t)
      -- use neovide as text editor in toggleterm
      t:send("export EDITOR=neovide")

      -- initialize a timer when terminal is created
      t.esc_timer = (vim.uv or vim.loop).new_timer()
    end,
  },
  keys = {
    { "<D-j>", ":ToggleTerm<CR>", silent = true },

    -- double escape to exit terminal mode (go to normal mode)
    -- works by starting a 200ms timer on the terminal instance
    -- if a second escape is pressed within that time, the timer is stopped and switch to normal mode
    -- otherwise, the timer will expire and the escape key will be sent to the terminal
    {
      "<Esc>",
      function()
        local terminals = require("toggleterm.terminal")

        ---@class Terminal
        ---@field esc_timer uv_timer_t
        local term = terminals.get(terminals.get_focused_id())
        if not term then
          return "<Esc>"
        end

        if term.esc_timer:is_active() then
          term.esc_timer:stop()
          vim.cmd("stopinsert")
          return ""
        else
          term.esc_timer:start(200, 0, function() end)
          return "<Esc>"
        end
      end,
      mode = "t",
      expr = true,
    },
  },
}
