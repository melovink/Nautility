hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,
		border_size = 2,
		layout = "dwindle",
		resize_on_border = true,
		col = {
			active_border = "rgb(2E3440)",
			inactive_border = "rgb(2E3440)",
		},
	},
	decoration = {
		rounding = 12,
		rounding_power = 3,
		active_opacity = 1.00,
		inactive_opacity = 1.00,
		shadow = {
			enabled = true,
			range = 8,
			render_power = 3,
			color = 0xaa14110f,
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			vibrancy = 0.17,
			noise = 0.01,
			new_optimizations = true,
		},
	},
})
