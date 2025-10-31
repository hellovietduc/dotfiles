-- color scheme
return {
  "folke/tokyonight.nvim",
  opts = function(_, opts)
    -- set tokyonight to transparent but only when not launch in neovide
    -- TODO: either wait for neovide transparency support to be better
    -- or just stop using transparent bg
    if not vim.g.neovide then
      opts.transparent = true
      opts.styles = vim.tbl_extend("force", opts.styles or {}, {
        sidebars = "transparent",
        floats = "transparent",
      })
    end
  end,
}
