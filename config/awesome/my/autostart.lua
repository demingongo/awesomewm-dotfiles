local awful = require("awful")
local beautiful = require("beautiful")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- compositor
awful.spawn.once("picom")
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

if type(beautiful.autostart) == "function" then
	beautiful.autostart()
end
