if not vim.g.neovide then
  return
end

-- font
vim.opt.linespace = 4 -- extra pixels per line (line height)

-- window
vim.opt.title = true -- show filename in the window title
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_padding_top = 2
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 4
vim.g.neovide_padding_left = 4
vim.g.neovide_show_border = true

-- scroll animation
vim.g.neovide_scroll_animation_length = 0.1 -- used to turn off, but now 0.1 seems to be the sweet spot
vim.g.neovide_scroll_animation_far_lines = 0 -- this prevents previews in fzf windows from snapping

-- cursor
vim.g.neovide_cursor_animation_length = 0.02 -- seconds
vim.g.neovide_cursor_trail_size = 0.6
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_smooth_blink = false -- really want this on but it causes constant rerendering and lag
vim.o.guicursor = "n-v:block,i-c-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff500-blinkon900-Cursor/lCursor"

-- input
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.neovide_input_ime = false
