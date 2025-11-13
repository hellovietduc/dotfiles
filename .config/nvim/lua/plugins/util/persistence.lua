return {
  "folke/persistence.nvim",
  init = function()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,globals,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
  opts = {
    branch = false,
  },
}
