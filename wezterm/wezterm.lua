local wez = require("wezterm")

local config = wez.config_builder()

-- General Options

-- config.enable_tab_bar = false
config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" }
config.window_decorations = "RESIZE" -- "TITLE", "TITLE | RESIZE", "NONE"
config.debug_key_events = false
config.adjust_window_size_when_changing_font_size = false
config.animation_fps = 1
config.max_fps = 30
config.scrollback_lines = 2000

-- Font Options
-- config.font = wez.font("MesloLGS Nerd Font Mono")
config.font_size = 12

-- Color options

config.color_scheme = "Palenight (Gogh)"

config.colors = {
	foreground = "#c0caf5", -- Foreground color
	background = "#1a1b26", -- Background color
	cursor_bg = "#c0caf5", -- Cursor background color
	cursor_border = "#c0caf5", -- Cursor border color
	cursor_fg = "#1a1b26", -- Cursor foreground color
	selection_bg = "#33467C", -- Selection background color
	selection_fg = "#c0caf5", -- Selection foreground color
	ansi = {
		"#15161E", -- Black
		"#f7768e", -- Red
		"#9ece6a", -- Green
		"#e0af68", -- Yellow
		"#7aa2f7", -- Blue
		"#bb9af7", -- Magenta
		"#7dcfff", -- Cyan
		"#a9b1d6", -- White
	},
	brights = {
		"#414868", -- Bright Black
		"#f7768e", -- Bright Red
		"#9ece6a", -- Bright Green
		"#e0af68", -- Bright Yellow
		"#7aa2f7", -- Bright Blue
		"#bb9af7", -- Bright Magenta
		"#7dcfff", -- Bright Cyan
		"#c0caf5", -- Bright White
	},
}

-- Dimmer for background
local dimmer = {
	brightness = 0.05,
	saturation = 0.75,
}

-- Define the two background options (wallpaper and transparent)
local background_with_wallpaper = {
	{
		source = {
			File = wez.config_dir .. "/backgrounds/chisato.png",
		},
		width = "Cover",
		height = "Cover",
		vertical_align = "Middle",
		horizontal_align = "Center",
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		opacity = 1,
		hsb = dimmer,
	},
}

-- Initialize with the wallpaper by default
config.background = background_with_wallpaper

-- Toggle function between the two backgrounds
config.keys = {
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wez.action.EmitEvent("toggle-background"),
	},
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = wez.action.ReloadConfiguration,
	},
}

-- Window options
config.window_padding = {
	left = 40,
	right = 40,
	top = 40,
	bottom = 20,
}

return config
