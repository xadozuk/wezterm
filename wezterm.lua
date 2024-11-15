local wezterm = require("wezterm")

local config = {}

-- This is for newer wezterm vertions to use the config builder
if wezterm.config_builder then
	config = wezterm.config_builder()
end

require("keymaps").apply(config)
require("styles").apply(config, {
	dynamic_background = true,
})

config.default_domain = "WSL:Ubuntu"
config.front_end = "WebGpu"

config.default_prog = {
	"pwsh",
}

return config
