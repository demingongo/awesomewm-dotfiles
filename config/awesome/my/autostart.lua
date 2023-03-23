local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- compositor (default)
awful.spawn.once("picom")
-- compositor (xrender backend) (VMs, ...)
-- uncomment this one for your VM and comment the default one 
--awful.spawn.once("picom --config " .. os.getenv("env") .. "/.config/picom/picom-vm.conf")
-- network
awful.util.spawn("nm-applet")
-- bluetooth
awful.util.spawn("blueman-applet")
-- numlock
awful.spawn.once("numlockx on")
-- disable the messed up touchpad on my Lenovo
awful.spawn.once('xinput disable "ETPS/2 Elantech Touchpad"')
-- disable built-in PC speaker (or beeper)
awful.spawn.once("xset -b")

if type(beautiful.autostart_shell_cmds) == "table" then
	for _, cmd in ipairs(beautiful.autostart_shell_cmds) do
		awful.spawn.easy_async_with_shell(
			cmd,
			function(_, stderr)
				if stderr and not stderr == "" then
					naughty.notify({
						preset = naughty.config.presets.critical,
						title = "autostart_shell_cmds error",
						text = stderr
					})
				end
			end
		)
	end
end

if type(beautiful.autostart) == "function" then
	beautiful.autostart()
end
