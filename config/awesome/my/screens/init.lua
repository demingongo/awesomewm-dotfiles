local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local tasklist = require('my.screens.tasklist')
local taglist = require('my.screens.taglist')
local mywibar = require('my.screens.wibar')
local mywidgets = require('my.widgets')


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        -- If starts with "#", it is a hex color
        -- otherwise it is the path to the wallpaper
        if string.sub(wallpaper, 1, 1) == "#" then
            gears.wallpaper.set(wallpaper)
        else
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end
end

---Creates a wibox and wallpaper for each screen
local function load_screens()
    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)

    awful.screen.connect_for_each_screen(function(s)
        -- Wallpaper
        set_wallpaper(s)

        -- Each screen has its own tag table.
        awful.tag(beautiful.taglist_tags or { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s,
            #awful.layout.layouts > 0 and awful.layout.layouts[1] or awful.layout.suit.tile)

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
