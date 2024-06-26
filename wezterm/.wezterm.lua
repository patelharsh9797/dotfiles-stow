-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.colors = {
	foreground = "#cdd6f4",
	background = "#0f0f0f",
	cursor_bg = "#f5e0dc",
	cursor_border = "#f5e0dc",
	cursor_fg = "#11111b",
	selection_bg = "#585b70",
	selection_fg = "#cdd6f4",
	ansi = { "#45475a", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#bac2de" },
	brights = { "#585b70", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#a6adc8" },
}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 12

config.enable_tab_bar = true
config.bold_brightens_ansi_colors = true

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 8

config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}

-- and finally, return the configuration to wezterm
return config
