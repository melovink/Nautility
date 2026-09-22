hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@144",
	--mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})

-- colok monitor ahhhh
hl.monitor({ output = "HDMI-A-1", mode = "preferred", mirror = "eDP-1", scale = 1 })
--hl.workspace_rule({ workspace = 1, monitor = "HDMI-A-1", default = true })
--hl.workspace_rule({ workspace = 2, monitor = "HDMI-A-1", default = true })
--hl.workspace_rule({ workspace = 3, monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = 1, monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = 2, monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = 3, monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = 4, monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = 5, monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = 6, monitor = "eDP-1", default = true })

hl.workspace_rule({ workspace = "special:scratchpad", on_created_empty = "kitty -e rmpc" })
