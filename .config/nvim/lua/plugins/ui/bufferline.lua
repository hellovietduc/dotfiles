return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    opts.options = {
      style_preset = require("bufferline").style_preset.no_italic,
      truncate_names = false, -- see buffer name more clearly
      diagnostics = false, -- to reduce clutter
      show_buffer_close_icons = false,

      -- close buffer with middle mouse
      middle_mouse_command = "bdelete! %d",
      right_mouse_command = false,
    }
  end,
}
