local module = {}

local wezterm = require("wezterm")
-- local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

function module.apply(config, opts)
	opts = opts or {}

	-- smart_splits.apply_to_config(config, {
	-- 	direction_keys = {
	-- 		move = { "h", "j", "k", "l" },
	-- 		resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	-- 	},
	-- })
end

return module
