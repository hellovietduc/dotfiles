local wezterm = require("wezterm")
local keymaps = require("keymaps")

local config = wezterm.config_builder()

-- #region APPEARANCE
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	{ family = "Symbols Nerd Font Mono", scale = 0.8 },
})
config.font_size = 15

config.command_palette_font_size = 16
config.command_palette_rows = 9

config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 80

config.window_decorations = "RESIZE"
-- config.use_resize_increments = true -- make resizing work with tiling window managers

config.default_cursor_style = "SteadyBar"
config.cursor_thickness = "2px"
-- #endregion

-- #region WINDOWS
config.window_close_confirmation = "NeverPrompt"

config.enable_tab_bar = false
config.window_padding = {
	top = "0.25cell",
	bottom = "0.25cell",
	left = "0.5cell",
	right = "0.5cell",
}

config.scrollback_lines = 5000
-- #endregion

-- #region KEYMAPS
keymaps.apply(config)
-- #endregion-

-- #region SYSTEM
config.front_end = "WebGpu"
config.freetype_load_flags = "NO_HINTING" -- trying to get WezTerm font to be as bold as Neovide but not there yet
config.check_for_updates = false
-- #endregion

return config
