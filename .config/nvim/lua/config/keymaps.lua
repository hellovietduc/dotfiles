-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function send_keys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

local function get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

-----------
-- RESET --
-----------
vim.keymap.del("n", "<leader>gB") -- LazyVim.lazygit.browse
vim.keymap.del("n", "<leader>K") -- Keywordprg
vim.keymap.del("n", "<leader>gL") -- lazygit log
vim.keymap.del("n", "<leader>gY") -- Git Browse (copy)

-----------
-- BASIC --
-----------
-- copy pasting
vim.keymap.set("n", "<D-s>", ":w<CR>", { silent = true }) -- Save normal mode
vim.keymap.set("n", "<D-S>", ":noa w<CR>", { silent = true }) -- Save normal mode (without formatting)
vim.keymap.set("i", "<D-s>", "<Esc>:w<CR>", { silent = true }) -- Save insert mode
vim.keymap.set("i", "<D-S>", "<Esc>:noa w<CR>", { silent = true }) -- Save insert mode (without formatting)
vim.keymap.set("v", "<D-c>", '"+y', { silent = true }) -- Copy visual mode
vim.keymap.set("n", "<D-v>", '"+P', { silent = true }) -- Paste normal mode
vim.keymap.set("v", "<D-v>", '"+P', { silent = true }) -- Paste visual mode
vim.keymap.set("t", "<D-v>", '<C-\\><C-n>"+pi', { silent = true }) -- Paste terminal mode
vim.keymap.set("c", "<D-v>", "<C-R>+", { silent = true }) -- Paste command mode

-- delete, undo
vim.keymap.set("n", "x", '"_x') -- don't move single-cut character to clipboard
vim.keymap.set("i", "<M-BS>", "<C-w>") -- Delete word backwards
vim.keymap.set("i", "<D-z>", "<Esc>ua") -- Undo insert mode

-- commenting
vim.keymap.set("n", "<D-/>", "gcc", { remap = true }) -- toggle line comment
vim.keymap.set("i", "<D-/>", "<Esc>gcO", { remap = true }) -- add line comment

-- bold, italic
vim.keymap.set("i", "<D-b>", function()
  if vim.bo.filetype == "markdown" then
    send_keys("****<Left><Left>")
  end
end)
vim.keymap.set("i", "<D-i>", function()
  if vim.bo.filetype == "markdown" then
    send_keys("__<Left>")
  end
end)

-- fast up/down
vim.keymap.set({ "n", "v" }, "J", "5j")
vim.keymap.set({ "n", "v" }, "K", "5k")

-- more comfy start/end
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")

-- increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- indent
vim.keymap.set("x", "<Tab>", ">gv")
vim.keymap.set("x", "<S-Tab>", "<gv")

-- search and replace
vim.keymap.set({ "n", "v" }, "<D-g>", "<leader>sr", { remap = true })

-- quick edit word
vim.keymap.set({ "n" }, "<CR>", "ciw", { remap = true })

------------------
-- CODE ACTIONS --
------------------
vim.keymap.set({ "n", "v" }, "<F2>", "<leader>cr", { remap = true })
vim.keymap.set("n", "<D-.>", '<cmd>lua require("fastaction").code_action()<CR>')
vim.keymap.set("v", "<D-.>", '<cmd>lua require("fastaction").range_code_action()<CR>')
vim.keymap.set({ "n", "v" }, "<D->>", "<leader>cA", { remap = true })
vim.keymap.set({ "n", "v" }, "<D-o>", "<leader>ss", { remap = true })

-------------
-- BUFFERS --
-------------
vim.keymap.set({ "n", "v" }, "<D-[>", ":bp<CR>", { silent = true }) -- Previous buffer
vim.keymap.set({ "n", "v" }, "<D-]>", ":bn<CR>", { silent = true }) -- Next buffer
vim.keymap.set({ "n", "v" }, "<D-w>", "<cmd>lua Snacks.bufdelete()<CR>", { silent = true }) -- Close buffer

-------------
-- NEOVIDE --
-------------

if vim.g.neovide then
  -----------
  -- BASIC --
  -----------
  -- editing
  vim.keymap.set({ "n", "v", "i" }, "<D-a>", "<Esc>ggVG") -- Select all
  vim.keymap.set("i", "<D-v>", '<Esc>"+pli', { silent = true }) -- Paste insert mode

  -- find selected text
  vim.keymap.set("n", "<D-f>", "*")
  vim.keymap.set("v", "<D-f>", function()
    local text = get_visual_selection()
    send_keys("/" .. text .. "<CR>")
  end)
  vim.keymap.set("v", "<D-F>", function()
    local text = get_visual_selection()
    Snacks.picker.grep({ search = text })
  end)

  -------------
  -- BUFFERS --
  -------------
  -- buffers
  vim.keymap.set({ "n", "v" }, "<C-Tab>", ":b#<CR>", { silent = true }) -- Last buffer
  vim.keymap.set({ "n", "v" }, "<D-n>", ":enew<CR>", { silent = true }) -- New buffer

  -------------
  -- TERMINAL --
  -------------
  -- terminal go to start/end
  vim.keymap.set("t", "<D-Left>", "<Home>")
  vim.keymap.set("t", "<D-Right>", "<End>")

  --------
  -- UI --
  --------
  -- git
  vim.keymap.set({ "n", "v" }, "<D-G>", "<leader>gs", { remap = true })
  vim.keymap.set({ "n", "v" }, "<D-L>", "<leader>gl", { remap = true })
  vim.keymap.set({ "n", "v" }, "<D-K>", "<leader>gk", { remap = true })

  -- zoom in/out
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set({ "n", "v", "c" }, "<D-I>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set({ "n", "v", "c" }, "<D-O>", function()
    change_scale_factor(1 / 1.25)
  end)
  vim.keymap.set({ "n", "v", "c" }, "<D-)>", function()
    vim.g.neovide_scale_factor = 1.0
  end)
end
