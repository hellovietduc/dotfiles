--- @param trunc_width number trunctates component when window width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icons = LazyVim.config.icons

    -- truncate branch name if not enough space
    opts.sections.lualine_b = {
      { "branch", fmt = trunc(80, 20, 0, true) },
    }

    -- only keep diagnostics in section C
    opts.sections.lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
    }

    -- remove diff from section X
    for i, comp in ipairs(opts.sections.lualine_x) do
      if comp[1] == "diff" then
        table.remove(opts.sections.lualine_x, i)
        break
      end
    end

    -- remove copilot from section X
    -- table.remove(opts.sections.lualine_x, 2)

    -- add filetype to section Y
    table.insert(opts.sections.lualine_y, 1, { "filetype" })

    -- show root directory in section Z (neovide)
    if vim.g.neovide then
      opts.sections.lualine_z = {
        LazyVim.lualine.root_dir({
          color = { fg = Snacks.util.color("SpecialKey") },
        }),
      }
    else
      opts.sections.lualine_z = {}
    end
  end,
}
