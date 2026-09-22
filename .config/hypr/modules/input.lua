hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
		},

		touchdevice = {
			enabled = false,
		}
	},
	misc = {
		middle_click_paste = false,
	},
})
--Open Menu
--Swipe Workspace
hl.gesture({
	fingers = 3,
	direction = "Horizontal",
	action = "workspace",
})

