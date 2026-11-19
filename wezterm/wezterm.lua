local wez = require("wezterm")

-- local resurrect = wez.plugin.require("https://github.com/StephenGemin/resurrect.wezterm")

local config = wez.config_builder()

-- General Options

-- config.enable_tab_bar = false
config.default_prog = { "/bin/zsh", "-l" }
config.window_decorations = "RESIZE" -- "TITLE", "TITLE | RESIZE", "NONE"
config.debug_key_events = false
config.adjust_window_size_when_changing_font_size = false
config.animation_fps = 120
config.max_fps = 240
config.scrollback_lines = 2000
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0

-- Font Options
config.font_size = 16
config.font = wez.font("GeistMono Nerd Font")
config.default_cursor_style = "SteadyBar"

-- Color options

config.colors = {
	foreground = "#d1d1d1",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#000000",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	tab_bar = {
		background = "None",
		active_tab = {
			bg_color = "None",
			fg_color = "#E5C07B",
		},
		inactive_tab = {
			bg_color = "None",
			fg_color = "#65737E",
		},
		inactive_tab_hover = {
			bg_color = "None",
			fg_color = "#65737E",
		},
		new_tab = {
			bg_color = "None",
			fg_color = "#65737E",
		},
		new_tab_hover = {
			bg_color = "None",
			fg_color = "#E5C07B",
		},
	},
}

-- Dimmer for background
local dimmer = {
	brightness = 0.05,
	saturation = 1,
}

-- Define the two background options (wallpaper and transparent)
local background_with_wallpaper = {
	{
		source = {
			File = wez.config_dir .. "/backgrounds/marian.jpg",
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

-- "No wallpaper" keeps the image layer loaded and covers it with a solid layer.
-- Dropping the image layer entirely triggers a wezterm 20240203 bug: the decoded
-- image's blob file gets freed, and re-adding the same image reuses the stale
-- handle -> "Io error in BlobLease" -> nothing paints -> fully transparent window.
local background_solid = {
	background_with_wallpaper[1],
	{
		source = { Color = config.colors.background },
		width = "100%",
		height = "100%",
		opacity = 1.0,
	},
}

-- Initialize with the wallpaper by default
config.background = background_with_wallpaper

local using_wallpaper = true

wez.on("toggle-background", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	using_wallpaper = not using_wallpaper
	overrides.background = using_wallpaper and background_with_wallpaper or background_solid
	window:set_config_overrides(overrides)
end)

-- Leader
config.leader = { key = "a", mods = "CTRL" }

-- SmartSplits-style nav: Ctrl+h/j/k/l moves between wezterm panes, but if the
-- focused pane is running (n)vim, forward the keypress to it instead, so the
-- same chord moves between vim splits and wezterm panes seamlessly.
local function is_vim(pane)
	local process_name = pane:get_foreground_process_name()
	if not process_name then
		return false
	end
	local basename = process_name:match("([^/\\]+)$")
	return basename == "vim" or basename == "nvim"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function smart_split_nav(key)
	return {
		key = key,
		mods = "CTRL",
		action = wez.action_callback(function(window, pane)
			if is_vim(pane) then
				window:perform_action(wez.action({ SendKey = { key = key, mods = "CTRL" } }), pane)
			else
				window:perform_action(wez.action({ ActivatePaneDirection = direction_keys[key] }), pane)
			end
		end),
	}
end

-- Keybinds
config.keys = {
	{ key = "a", mods = "LEADER|CTRL", action = wez.action({ SendString = "\x01" }) },
	{ key = "-", mods = "LEADER", action = wez.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "LEADER", action = wez.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = wez.action({ SpawnTab = "CurrentPaneDomain" }) },
	smart_split_nav("h"),
	smart_split_nav("j"),
	smart_split_nav("k"),
	smart_split_nav("l"),
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
	{ key = "p", mods = "LEADER", action = wez.action.ActivateCommandPalette },
}

-- Mouse
-- Claude Code's fullscreen TUI grabs the mouse, which blocks text selection.
-- Claim left-click back for selection even while mouse reporting is active.
-- https://www.1stvamp.org/mouse-selection-in-wezterm-when-claude-code-grabs-the-mouse/
config.bypass_mouse_reporting_modifiers = "CTRL|ALT"

local function select_bindings(streak, unit)
	return {
		{
			event = { Down = { streak = streak, button = "Left" } },
			mods = "NONE",
			mouse_reporting = true,
			action = wez.action.SelectTextAtMouseCursor(unit),
		},
		{
			event = { Drag = { streak = streak, button = "Left" } },
			mods = "NONE",
			mouse_reporting = true,
			action = wez.action.ExtendSelectionToMouseCursor(unit),
		},
		{
			event = { Up = { streak = streak, button = "Left" } },
			mods = "NONE",
			mouse_reporting = true,
			action = wez.action.CompleteSelection("ClipboardAndPrimarySelection"),
		},
	}
end

config.mouse_bindings = {
	-- ctrl+click opens links
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		mouse_reporting = true,
		action = wez.action.Nop,
	},
	{
		event = { Drag = { streak = 1, button = "Left" } },
		mods = "CTRL",
		mouse_reporting = true,
		action = wez.action.Nop,
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		mouse_reporting = true,
		action = wez.action.OpenLinkAtMouseCursor,
	},
}
-- single / double / triple click selects cell / word / line
for streak, unit in ipairs({ "Cell", "Word", "Line" }) do
	for _, binding in ipairs(select_bindings(streak, unit)) do
		table.insert(config.mouse_bindings, binding)
	end
end

-- Window options
config.window_padding = {
	left = 40,
	right = 40,
	top = 20,
	bottom = 0,
}

config.window_frame = {
	border_top_height = 20,
}

config.tab_max_width = 32
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
local function pane_path(pane_info)
	local cwd_uri = pane_info.current_working_dir
	if cwd_uri then
		local cwd = cwd_uri.file_path or tostring(cwd_uri)
		cwd = cwd:gsub("/$", "")
		local home = os.getenv("HOME")
		if home and cwd == home then
			return "~"
		end
		return cwd:match("([^/]+)$") or cwd
	end
	return pane_info.title
end

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, show the active pane's current working directory
	return pane_path(tab_info.active_pane)
end
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.6 }
-- config.inactive_pane_hsb = { hue = 1.0, saturation = 0.4, brightness = 0.4 }

-- Resurrect: handles autosave + startup restore for you (panes/tabs survive
-- a wezterm restart).
-- resurrect.setup(config)

wez.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local background = "#749cdc"
	local foreground = "#F0F2F5"
	local edge_background = "rgba(0,0,0,0)" -- transparent: let the window background show through

	if tab.is_active or hover then
		background = "#deadec"
		foreground = "#F0F2F5"
	end
	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	local max = config.tab_max_width - 9
	if #title > max then
		title = wez.truncate_right(title, max) .. "…"
	end

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
	}
end)

return config
