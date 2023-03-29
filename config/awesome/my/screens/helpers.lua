local gears = require("gears")
local beautiful = require("beautiful")

local helpers = {}

helpers.set_wallpaper = function (screen)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end
        -- If starts with "#", it is a hex color
        -- otherwise it is the path to the wallpaper
        if string.sub(wallpaper, 1, 1) == "#" then
            gears.wallpaper.set(wallpaper)
        else
            gears.wallpaper.maximized(wallpaper, screen, true)
        end
    end
end

return helpers
