local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.gui.enumerate_gpus()

config.automatically_reload_config = true
config.default_domain = "WSL:Ubuntu"
config.initial_cols = 100
config.initial_rows = 24

config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false

-- Color scheme
config.bold_brightens_ansi_colors = true
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

-- Fonts
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12

-- Tab bar config
config.enable_tab_bar = false -- disable tab bar on top
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- config.visual_bell = {
-- 	fade_in_function = "EaseIn",
-- 	fade_in_duration_ms = 150,
-- 	fade_out_function = "EaseOut",
-- 	fade_out_duration_ms = 150,
-- }

-- Cursor
config.cursor_thickness = 1
config.default_cursor_style = "BlinkingBar" -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBarconfig.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
config.cursor_blink_rate = 500

-- Window | Looks
-- config.window_decorations = "RESIZE" -- For no status bar or any kind of bar on top
-- config.window_decorations = "TITLE"
config.window_background_opacity = 0.69
config.win32_system_backdrop = "Disable" -- or 'Auto' | 'Mica' | 'Acrylic' | 'Tabbed'
config.macos_window_background_blur = 8
config.native_macos_fullscreen_mode = false
config.window_padding = {
	left = 8,
	right = 8,
	top = 4,
	bottom = 4,
}
config.background = {
	{
		source = {
			-- File = './bg-blurred.png',
			File = "./bg-blurred-darker.png",
		},
		--   hsb = {
		--     hue = 1.0,
		--     saturation = 1.02,
		--     brightness = 0.25,
		--   },
		width = "Cover",
		height = "Cover",
		horizontal_align = "Left",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 0.69,
	},
	-- overlay
	-- {
	-- 	source = {
	-- 	  Color = "#0F0F0F",
	-- 	},
	-- 	width = "100%",
	-- 	height = "100%",
	-- 	opacity = 0.55,
	--   },
}

-- from: https://akos.ma/blog/adopting-wezterm/
config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		-- Before
		--regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
		--format = '$0',
		-- After
		regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
		format = "$1",
		highlight = 1,
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

-- rewrite keymaps
config.keys = {
	-- "ALT+ENTER" to toggle maximize
	{
		key = "\r",
		mods = "ALT",
		action = wezterm.action_callback(function(window)
			local old_dim = window:get_dimensions()
			window:maximize()
			local new_dim = window:get_dimensions()
			if (old_dim.pixel_width == new_dim.pixel_width) and (old_dim.pixel_height == new_dim.pixel_height) then
				window:restore()
			end
		end),
	},
	-- {
	-- 	key = "m", -- You can change this to your preferred key combination
	-- 	mods = "ALT", -- You can change this to your preferred modifier key(s)
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		local screen_width = wezterm.screen_info().width
	-- 		local screen_height = wezterm.screen_info().height
	-- 		win:set_window_position(0, 0)
	-- 		win:set_window_size(screen_width, screen_height)
	-- 	end),
	-- },
}

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
