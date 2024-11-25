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

require("plugins").apply(config)

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	require("overrides.windows").apply(config)
end

config.front_end = "WebGpu"
config.default_prog = {
	"pwsh",
}

return config
