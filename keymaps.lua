local module = {}

local wezterm = require("wezterm")

local function apply_mux_bindings(config, opts)
	config.key_tables = {
		tab_navigation = {
			{ key = "h", mods = "CTRL", action = wezterm.action.ActivateTabRelative(-1) },
			{ key = "l", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
		},
	}

	config.keys = {
		{
			key = "c",
			mods = "LEADER",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "c",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SpawnTab({ DomainName = "local" }),
		},

		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},

		{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
		{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
		{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
		{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
		{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
		{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
		{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },

		{
			key = "h",
			mods = "LEADER|CTRL",
			action = wezterm.action.Multiple({
				wezterm.action.ActivateTabRelative(-1),
				wezterm.action.ActivateKeyTable({
					name = "tab_navigation",
					until_unknown = true,
					timeout_milliseconds = 1000,
					one_shot = false,
				}),
			}),
		},
		{
			key = "l",
			mods = "LEADER|CTRL",
			action = wezterm.action.Multiple({
				wezterm.action.ActivateTabRelative(1),
				wezterm.action.ActivateKeyTable({
					name = "tab_navigation",
					until_unknown = true,
					timeout_milliseconds = 1000,
					one_shot = false,
				}),
			}),
		},
		{
			key = ",",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = "z",
			mods = "LEADER",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "&",
			mods = "LEADER|SHIFT",
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
	}
end

function module.apply(config, override_opts)
	override_opts = override_opts or {}
	local opts = {
		enable_mux_bindings = false,
	}

	for k, v in pairs(override_opts) do
		opts[k] = v
	end

	local leader_key = "a"

	-- config.leader = {
	-- 	key = leader_key,
	-- 	mods = "CTRL",
	-- 	timeout_milliseconds = 1000,
	-- }
	-- config.allow_win32_input_mode = true
	config.disable_default_key_bindings = true
	-- config.debug_key_events = true

	config.keys = {
		-- Send Ctrl-a to the terminal when pressing Ctrl-a, Ctrl-a
		-- {
		-- 	key = leader_key,
		-- 	mods = "LEADER|CTRL",
		-- 	action = wezterm.action.SendKey({ key = leader_key, mods = "CTRL" }),
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
	}

	if opts.enable_mux_bindings then
		apply_mux_bindings(config, opts)
	end
end

return module
