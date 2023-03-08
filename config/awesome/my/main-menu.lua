local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local themes = require('my.static').themes
local values = require('my.variables')
local terminal = values.terminal
-- local editor_cmd = values.editor_cmd

-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    --{ "Manual", terminal .. " -e man awesome" },
    --{ "Edit config", editor_cmd .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
    { "Quit",    function() awesome.quit() end },
}

local mythemesmenu = {}

for _, name in ipairs(themes) do
    table.insert(mythemesmenu, {
        name,
        function() os.execute(os.getenv("HOME") .. "/.local/bin/awesome_switch_theme " .. name) end
    })
end

local mymainmenu = freedesktop.menu.build {
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
    },
    after = {
        { "Change theme",  mythemesmenu },
        { "Open terminal", terminal }
    }
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

return mymainmenu