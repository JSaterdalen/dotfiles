-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font('CaskaydiaCove Nerd Font')
config.font_size = 17
config.window_decorations = 'RESIZE'
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
