local module = {}

local wezterm = require("wezterm")

local TerminalBackgrounds = {}

local function join_path(path, child)
	local last_char = string.sub(path, -1)

	if last_char ~= "/" and last_char ~= "\\" then
		path = path .. "/"
	end

	return path .. child
end

local function fetch_terminal_backgrounds(path)
	if #TerminalBackgrounds > 0 then
		return TerminalBackgrounds
	end

	local backgrounds = {}

	for _, file in ipairs(wezterm.glob(join_path(path, "*.png"))) do
		table.insert(backgrounds, file)
	end

	TerminalBackgrounds = backgrounds
	return TerminalBackgrounds
end

local function terminal_background(path, index)
	index = index or 1

	local backgrounds = fetch_terminal_backgrounds(path)
	local wrapped_index = ((index - 1) % #backgrounds) + 1

	return backgrounds[wrapped_index]
end

local function random_terminal_background(path)
	local backgrounds = fetch_terminal_backgrounds(path)
	local random_index = math.random(1, #backgrounds)

	return backgrounds[random_index]
end

function module.apply(config, override_opts)
	local opts = {
		terminal_backgrounds_path = os.getenv("WEZTERM_BACKGROUNDS_PATH"),
		dynamic_background = false,
		dynamic_background_interval = 1800,
	}

	for k, v in pairs(override_opts) do
		opts[k] = v
	end

	local current_background = random_terminal_background(opts.terminal_backgrounds_path)

	if opts.dynamic_background then
		wezterm.time.call_after(opts.dynamic_background_interval, function()
			wezterm.reload_configuration()
		end)
	end

	config.font = wezterm.font("CaskaydiaCove Nerd Font")
	config.color_scheme = "Campbell (Gogh)"
	-- config.window_background_opacity = 0.9

	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_bar_at_bottom = true

	config.background = {
		{
			-- opacity = 0.75,
			vertical_align = "Middle",
			horizontal_align = "Center",
			hsb = {
				brightness = 0.05,
			},
			source = {
				File = current_background,
			},
		},
	}
end

return module
