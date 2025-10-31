-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Don't add the comment prefix when I hit enter or o/O on a commented line
vim.api.nvim_create_autocmd("FileType", {
  command = "set formatoptions-=o",
})

-- #region Keep the cursor position when yanking
local cursorPreYank

vim.keymap.set({ "n", "x" }, "y", function()
  cursorPreYank = vim.api.nvim_win_get_cursor(0)
  return "y"
end, { expr = true })

vim.keymap.set("n", "Y", function()
  cursorPreYank = vim.api.nvim_win_get_cursor(0)
  return "yg_"
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == "y" and cursorPreYank then
      vim.api.nvim_win_set_cursor(0, cursorPreYank)
    end
  end,
})
-- #endregion

-- #region Lazyvim
-- From: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
local function lazyvim_augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- reset cursor type on leaving Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  group = lazyvim_augroup("Shape"),
  command = "set guicursor=a:ver90-blinkon1", -- vertical bar, blinking
})
-- #endregion

-- #region Hide Copilot suggestions when cmp menu is open
vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    require("copilot.suggestion").dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
-- #endregion
