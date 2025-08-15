-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.font = wezterm.font("JetBrainsMonoNerdFontMono")
-- or, changing the font size and color scheme.
config.font_size = 19
config.color_scheme = "Dracula (Official)"
config.max_fps = 144
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 3,
	right = 3,
	top = 0,
	bottom = 0,
}

-- Finally, return the configuration to wezterm:
return config
