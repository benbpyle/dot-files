-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
-- config.color_scheme = "One Dark (Gogh)"
config.font = wezterm.font("JetBrains Mono")
-- and finally, return the configuration to wezterm
config.use_fancy_tab_bar = true
config.color_scheme = "Catppuccin Frappe" -- or Macchiato, Frappe, Latte, Mocha
-- config.color_scheme = "Tokyo Night Moon"

--config.color_scheme = "Catppuccin Frappe" -- or Macchiato, Frappe, Latte
config.cursor_thickness = "2"
config.keys = {
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

-- config.background = {
-- 	{
-- 		source = {
-- 			File = "/Users/benjamen/.config/wezterm/backgrounds/library.jpg",
-- 		},
-- 	},
-- }
-- config.window_background_opacity = 0.95
return config
