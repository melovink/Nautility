local mod = "SUPER"
-----------------
--Open Programs--
-----------------
hl.bind(mod .. " + Q", hl.dsp.exec_cmd("kitty"))
--hl.bind(mod .. " + D", hl.dsp.exec_cmd("thunar"))
hl.bind(mod .. " + F", hl.dsp.exec_cmd("zen-browser"))

--------
--Menu--
--------
--hl.bind(mod .. " + R", hl.dsp.exec_cmd("/home/melovink/.config/hypr/scripts/open-surface.sh launcher"))
--hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("quickshell ipc -c boring call bottomBar showLauncher"))--
-- Spotlight-style launcher: apps and ~/AppImage entries only, no files or folders.
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("quickshell ipc -c spotlight call spotlightWindow toggle"))

-----------------------
--Window Manipulation--
-----------------------
hl.bind(mod .. " + X", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + X", hl.dsp.window.kill())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + B", hl.dsp.window.fullscreen())
hl.bind(mod .. " + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/show-desktop.sh"))

hl.bind(mod .. " + SHIFT + J", hl.dsp.layout("swapsplit"))

hl.bind("SUPER + A", hl.dsp.layout("splitratio -0.1"))
hl.bind("SUPER + D", hl.dsp.layout("splitratio +0.1"))

----------------
--Window Focus--
----------------
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))

--------------
--Workspaces--
--------------

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + U", function()
	if hl.get_workspace("special:minimized") then
		hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
		hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
	else
		hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
		hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
	end
end)

---------------
--Screenshots--
---------------
hl.bind(mod .. " + N", hl.dsp.exec_cmd("flameshot full -c"))
--hl.bind(mod .. " + N", hl.dsp.exec_cmd("/home/melovink/rishot/bin/rishot"))
--hl.bind(mod .. " + N", hl.dsp.exec_cmd("grim  ~/Pictures/Screenshots/helo$(date +%s).png | wl-copy "))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("flameshot gui -c"))
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("flameshot full -p /home/melovink/Screenshots/ &"))
hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd("flameshot gui -p /home/melovink/Screenshots/ &"))

------------------
--Lock and Panic--
------------------
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock &"))
hl.bind(mod .. " + O", hl.dsp.exec_cmd("./suspend.sh &"))

----------
--Volume--
----------
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

---------------------
--Screen Brightness--
---------------------
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-------
--MPD--
-------
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("mpc next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("mpc prev"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("mpc stop"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("mpc toggle"))

------------------------------------
--Miscelaneos gmn cara nulisnya jir--
------------------------------------
hl.bind(mod .. " + W", hl.dsp.exec_cmd("quickshell ipc -c boring call bottomBar showWallpaper &"))
hl.bind(mod .. " + G", hl.dsp.exec_cmd("qs ipc -c boring call bottomBar toggleGif &"))
-- Peek: hold left Super to expand the bar, release to collapse it.
-- A `release` bind is registered correctly here but Hyprland never delivers the
-- release edge for a modifier key, so it is not used. CInputState::isKeysymDown
-- reads m_pressed, which does contain Super_L while it is held, so a short repeat
-- timer watches the keysym instead. 40ms is well under a perceptible delay.
local barHoldTimer = nil

-- Toggle: SUPER + Escape expands the island, press again to collapse it.
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd("qs ipc -c boring call bottomBar toggleBar"))

-- hl.bind("SUPER_L", function()
--     hl.exec_cmd("qs ipc -c boring call bottomBar holdBar")
--     if barHoldTimer then
--         barHoldTimer:set_enabled(false)
--     end
--     barHoldTimer = hl.timer(function()
--         if not hl.is_key_down("Super_L") then
--             hl.exec_cmd("qs ipc -c boring call bottomBar unholdBar")
--             barHoldTimer:set_enabled(false)
--         end
--     end, { timeout = 40, type = "repeat" })
-- end)
hl.bind(mod .. " + tab", hl.dsp.exec_cmd("/home/melovink/.config/hypr/scripts/touchpad_toggle.sh"))

-----------
--Battery--
-----------
hl.bind(mod .. " + F1", function()
	local battery = (hl.get_config("animations.enabled") == false)

	if battery then
		hl.exec_cmd("hyprctl reload")
		return
	end

	hl.config({
		general = {
			gaps_in = 0,
			gaps_out = 0, -- Disable gaps
			border_size = 0,
		},

		animations = {
			enabled = false, -- Disable animations
		},

		-- Disable blur, shadow and window rounding
		decoration = {
			shadow = { enabled = false },
			blur = { enabled = false },
			rounding = 0,
		},
	})

	hl.monitor({
		output = "eDP-1",
		mode = "1920x1080@60",
	})
end)
