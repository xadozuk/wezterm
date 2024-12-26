local module = {}

local wezterm = require("wezterm")

function module.apply(config, opts)
	opts = opts or {}

	config.default_prog = {
		"/usr/local/microsoft/powershell/7/pwsh",
	}

	config.font_size = 14
end

return module
