-- a much better neo-tree/mini.files
return {
  "stevearc/oil.nvim",
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  opts = {
    -- take over as default file manager when running `nvim .` or `nvim /a-dir`
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["q"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["<C-p>"] = "actions.preview", -- toggle preview window
      ["<C-d>"] = "actions.preview_scroll_down",
      ["<C-u>"] = "actions.preview_scroll_up",
      ["<C-y>"] = "actions.yank_entry", -- yank the file path
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name)
        return name == ".git" or name == ".DS_Store" or name == "node_modules"
      end,
    },
    float = {
      max_width = 100,
    },
  },
  keys = {
    { "~", ":Oil --float<CR>", silent = true },
  },
}
