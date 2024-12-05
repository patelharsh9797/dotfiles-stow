local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.gui.enumerate_gpus()

config.default_domain = 'WSL:Ubuntu'
config.initial_cols = 100
config.initial_rows = 24

config.colors = {
	foreground = "#cdd6f4",
	background = "#1E1D2F",
	-- background = "#0F0F0F",
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

config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = false
config.bold_brightens_ansi_colors = true
config.use_fancy_tab_bar = false

-- config.visual_bell = {
-- 	fade_in_function = "EaseIn",
-- 	fade_in_duration_ms = 150,
-- 	fade_out_function = "EaseOut",
-- 	fade_out_duration_ms = 150,
-- }

config.cursor_thickness = 1
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.cursor_blink_rate = 300

-- config.window_decorations = "RESIZE"
-- config.window_decorations = "TITLE"
config.window_background_opacity = 0.69
config.win32_system_backdrop = 'Disable'  -- or 'Auto' | 'Mica' | 'Acrylic' | 'Tabbed'
config.macos_window_background_blur = 8
config.native_macos_fullscreen_mode = false
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

config.background = {
	{
	  source = {
		-- File = './bg-blurred.png',
		File = './bg-blurred-darker.png',
	  },
	  width = 'Cover',
	  height = 'Cover',
	  horizontal_align = 'Left',
      repeat_x = 'Repeat',
	  repeat_y = 'Repeat',
	  opacity = 0.69,
	},
}

-- config.keys = {
-- 	{
-- 		key = "m", -- You can change this to your preferred key combination
-- 		mods = "ALT", -- You can change this to your preferred modifier key(s)
-- 		action = wezterm.action_callback(function(win, pane)
-- 			local screen_width = wezterm.screen_info().width
-- 			local screen_height = wezterm.screen_info().height
-- 			win:set_window_position(0, 0)
-- 			win:set_window_size(screen_width, screen_height)
-- 		end),
-- 	},
-- }

-- config.mouse_bindings = {
-- 	-- Ctrl-click will open the link under the mouse cursor
-- 	{
-- 		event = { Up = { streak = 1, button = "Left" } },
-- 		mods = "CTRL",
-- 		action = wezterm.action.OpenLinkAtMouseCursor,
-- 	},
-- }

-- and finally, return the configuration to wezterm
return config
