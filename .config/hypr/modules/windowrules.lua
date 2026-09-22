--Ignore maximize request from apps
local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.config({
	dwindle = {
		force_split = 0,
		preserve_split = true,
		smart_split = false,
		smart_resizing = true,
		permanent_direction_override = false,
		special_scale_factor = 1,
		split_width_multiplier = 1.0,
		use_active_for_splits = true,
		default_split_ratio = 1.0,
		split_bias = 0,
		precise_mouse_move = false,
	},
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})
