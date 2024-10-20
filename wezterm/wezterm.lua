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

config.colors = {
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

-- Dimmer for background
local dimmer = {
	brightness = 0.05,
	saturation = 0.9,
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

-- Leader
config.leader = { key = "a", mods = "CTRL" }

-- Keybinds
config.keys = {
	{ key = "a", mods = "LEADER|CTRL", action = wez.action({ SendString = "\x01" }) },
	{ key = "-", mods = "LEADER", action = wez.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "LEADER", action = wez.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = wez.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = wez.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = wez.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wez.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wez.action({ ActivatePaneDirection = "Right" }) },
	{ key = "H", mods = "LEADER|SHIFT", action = wez.action({ AdjustPaneSize = { "Left", 6 } }) },
	{ key = "J", mods = "LEADER|SHIFT", action = wez.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "LEADER|SHIFT", action = wez.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "LEADER|SHIFT", action = wez.action({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "1", mods = "LEADER", action = wez.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wez.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wez.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wez.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wez.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wez.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wez.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wez.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wez.action({ ActivateTab = 8 }) },
	{ key = "&", mods = "LEADER|SHIFT", action = wez.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "x", mods = "LEADER", action = wez.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
	{ key = "v", mods = "SHIFT|CTRL", action = wez.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "SHIFT|CTRL", action = wez.action.CopyTo("Clipboard") },
	{ key = "+", mods = "SHIFT|CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "SHIFT|CTRL", action = "DecreaseFontSize" },
	{ key = "0", mods = "SHIFT|CTRL", action = "ResetFontSize" },
	{ key = "b", mods = "CTRL|SHIFT", action = wez.action.EmitEvent("toggle-background") },
	{ key = "r", mods = "CTRL|SHIFT", action = wez.action.ReloadConfiguration },
}
-- Window options
config.window_padding = {
	left = 40,
	right = 40,
	top = 40,
	bottom = 20,
}

return config
