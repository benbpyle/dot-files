-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
-- config.color_scheme = "One Dark (Gogh)"
config.font = wezterm.font("JetBrains Mono")
-- and finally, return the configuration to wezterm
config.use_fancy_tab_bar = true
config.color_scheme = "Catppuccin Frappe" -- or Macchiato, Frappe, Latte

--config.color_scheme = "Catppuccin Macchiato" -- or Macchiato, Frappe, Latte
config.cursor_thickness = "2"
return config
