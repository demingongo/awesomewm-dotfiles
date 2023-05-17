--- my/screens/init.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local awful = require("awful")
local tasklist = require('my.screens.tasklist')
local taglist = require('my.screens.taglist')
local mywibar = require('my.screens.wibar')
local mywidgets = require('my.widgets')
local set_wallpaper = require("my.screens.helpers").set_wallpaper

---Creates a wibox and wallpaper for each screen
local function load_screens()
    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)

    awful.screen.connect_for_each_screen(function(s)
        -- Wallpaper
        set_wallpaper(s)

        -- Create a promptbox for each screen
        s.mypromptbox = mywidgets:create_promptbox()

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = mywidgets:create_layoutbox(s)

        -- Create the taglist
        s.mytaglist = taglist.create(s)

        -- Create the tasklist
        s.mytasklist = tasklist.create(s)

        -- Create the wibox
        s.mywibox = mywibar.create(s)
    end)
end

return {
    load = load_screens
}
