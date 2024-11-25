local module = {}

local wezterm = require("wezterm")

function module.apply(config, opts)
	opts = opts or {}

	config.default_domain = "WSL:Ubuntu"
end

return module
