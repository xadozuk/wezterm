local module = {}

local wezterm = require("wezterm")

function module.apply(config, opts)
	opts = opts or {}

	-- config.leader = {
	-- 	key = "a",
	-- 	mods = "CTRL",
	-- 	timeout_milliseconds = 1000,
	-- }
	-- config.allow_win32_input_mode = true
	config.disable_default_key_bindings = true
	-- config.debug_key_events = true
	config.keys = {
		-- Send Ctrl-a to the terminal when pressing Ctrl-a, Ctrl-a
		-- {
		-- 	key = "a",
		-- 	mods = "LEADER|CTRL",
		-- 	action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
		-- },
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ShowDebugOverlay,
		},
		{
			key = "p",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateCommandPalette,
		},
		-- Fix S-Enter
		{
			key = "phys:Return",
			mods = "SHIFT",
			action = wezterm.action.SendString("\x1b[13;2u"),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CopyTo("Clipboard"),
		},
		{
			key = "Return",
			mods = "ALT",
			action = wezterm.action.ToggleFullScreen,
		},
		-- Mux mapping
		-- {
		-- 	key = "c",
		-- 	mods = "LEADER",
		-- 	action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		-- },
		--
		-- {
		-- 	key = "|",
		-- 	mods = "LEADER|SHIFT",
		-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		-- },
		-- {
		-- 	key = "-",
		-- 	mods = "LEADER",
		-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		-- },
		--
		-- { key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
		-- { key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
		-- { key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
		-- { key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
		-- { key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
		-- { key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
		-- { key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
		-- { key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
		-- { key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
		--
		-- {
		-- 	key = "h",
		-- 	mods = "LEADER",
		-- 	action = wezterm.action.Multiple({
		-- 		wezterm.action.ActivateTabRelative(-1),
		-- 		wezterm.action.ActivateKeyTable({
		-- 			name = "tab_navigation",
		-- 			until_unknown = true,
		-- 			timeout_milliseconds = 1000,
		-- 			one_shot = false,
		-- 		}),
		-- 	}),
		-- },
		-- {
		-- 	key = "l",
		-- 	mods = "LEADER",
		-- 	action = wezterm.action.Multiple({
		-- 		wezterm.action.ActivateTabRelative(1),
		-- 		wezterm.action.ActivateKeyTable({
		-- 			name = "tab_navigation",
		-- 			until_unknown = true,
		-- 			timeout_milliseconds = 1000,
		-- 			one_shot = false,
		-- 		}),
		-- 	}),
		-- },
	}

	config.key_tables = {
		-- tab_navigation = {
		-- 	{ key = "h", action = wezterm.action.ActivateTabRelative(-1) },
		-- 	{ key = "l", action = wezterm.action.ActivateTabRelative(1) },
		-- },
	}
end

return module
