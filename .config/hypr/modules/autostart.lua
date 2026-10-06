hl.on("hyprland.start", function()
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("qs -c boring")
	hl.exec_cmd("qs -c spotlight")
	--	hl.exec_cmd("waybar") --if using waybar
	--hl.exec_cmd("hypridle")
	hl.exec_cmd("mpc stop")
	hl.exec_cmd("exec-once = wl-paste -p --watch wl-copy -cp")
end)
