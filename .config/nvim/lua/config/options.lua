-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "snacks"

-- Don't use AI source in completion engine
vim.g.ai_cmp = false

-- ESLint auto format is slow
vim.g.lazyvim_eslint_auto_format = false

-- better diff
vim.opt.diffopt = "internal,filler,closeoff,iwhite,algorithm:patience,indent-heuristic"

-- diff character for deleted lines
vim.opt.fillchars:append({ diff = " " })
-- alternatively: https://github.com/sindrets/diffview.nvim#tips-and-faq
-- but it doesn't work well for tokyonight theme on neovide
-- vim.opt.fillchars:append({ diff = "╱" })

-- keeps 10 lines visible above/below the cursor when scrolling
vim.opt.scrolloff = 10

-- Disable swap file creation
vim.opt.swapfile = false
