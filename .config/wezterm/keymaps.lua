local wezterm = require("wezterm")
local k = require("utils/keys")

local act = wezterm.action
local M = {}

M.apply = function(config)
	-- disable cuz I only wanna map keys that I use
	config.disable_default_key_bindings = true

	config.keys = {
		-- #region WEZTERM
		k.cmd_shift_key("n", act.SpawnWindow),
		k.cmd_shift_key("x", act.CloseCurrentTab({ confirm = true })),
		k.cmd_key("q", act.QuitApplication),

		k.cmd_key("LeftArrow", act.SendKey({ key = "\001" })), -- Home
		k.cmd_key("RightArrow", act.SendKey({ key = "\005" })), -- End

		k.cmd_key("c", act.CopyTo("Clipboard")),
		k.cmd_key("v", act.PasteFrom("Clipboard")),
		k.cmd_key("y", act.ActivateCopyMode),
		k.cmd_shift_key(" ", act.QuickSelect),

		k.cmd_key("f", act.Search({ Regex = "" })),
		k.cmd_shift_key("j", act.ScrollByPage(0.7)),
		k.cmd_shift_key("k", act.ScrollByPage(-0.7)),

		k.cmd_shift_key("i", act.IncreaseFontSize),
		k.cmd_shift_key("o", act.DecreaseFontSize),
		k.cmd_shift_key("0", act.ResetFontSize),
		-- #endregion

		-- #region TMUX
		-- TODO: only execute these keys in tmux
		k.cmd_to_tmux_prefix("l", "s"), -- session switcher

		k.cmd_to_tmux_prefix("t", "c"), -- new window
		k.cmd_shift_to_tmux_prefix("w", "&"), -- close window
		k.cmd_shift_to_tmux_prefix("r", "r"), -- rename window

		-- cmd + <number> to switch windows
		k.cmd_to_tmux_prefix("1", "1"),
		k.cmd_to_tmux_prefix("2", "2"),
		k.cmd_to_tmux_prefix("3", "3"),
		k.cmd_to_tmux_prefix("4", "4"),
		k.cmd_to_tmux_prefix("5", "5"),
		k.cmd_to_tmux_prefix("6", "6"),
		k.cmd_to_tmux_prefix("7", "7"),
		k.cmd_to_tmux_prefix("8", "8"),
		k.cmd_to_tmux_prefix("9", "9"),

		k.cmd_to_tmux_prefix("|", "|"),
		k.cmd_to_tmux_prefix("-", "-"),
		-- TODO: vscode compat, consider something else
		k.cmd_to_tmux_prefix("d", "|"),
		-- TODO: make cmd+j smart (toggleterm)
		k.cmd_to_tmux_prefix("j", "-"),

		k.cmd_to_tmux_prefix("a", "Q"), -- send keystrokes to all panes
		k.cmd_shift_to_tmux_prefix("g", "G"), -- lazygit
		-- #endregion

		-- #region NEOVIM
		k.cmd_key(
			"s",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- escape
				k.multiple_actions(":w"), -- save
			})
		),
		k.cmd_key(
			"w",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- escape
				k.multiple_actions(":q"), -- close
			})
		),
		-- #endregion
	}
end

return M
