-- breadcumbs
return {
  "Bekaboo/dropbar.nvim",
  cond = not not vim.g.neovide,
  event = "LazyFile",
  opts = function(_, opts)
    local sources = require("dropbar.sources")
    return vim.tbl_deep_extend("force", opts, {
      bar = {
        update_debounce = 200,

        -- Only update on events that can change file name/path
        update_events = {
          win = {
            "WinEnter",
            "WinResized",
          },
          buf = {
            "BufModifiedSet",
            "FileChangedShellPost",
          },
        },

        -- Only want file path in breadcumbs
        sources = { sources.path },
      },
    })
  end,
}
