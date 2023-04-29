local gears = require("gears")
local beautiful = require("beautiful")


--[[
TODO: set a wallpaper with gradient

e.g. of gradient values
- "radial:50,50,10:55,55,30:0,#ff0000:0.5,#00ff00:1,#0000ff"
- {
    type  = "linear" ,
    from  = { 0, 0  },
    to    = { 0, 700 },
    stops = {
        { 0, "#0000ff" },
        { 1, "#ff0000" }
    }
 }

how to set:

gears.wallpaper.set(gradient_value)
--]]


local helpers = {}

helpers.wallpaper = nil

---set wallpaper to a screen
---@param screen any
helpers.set_wallpaper = function(screen)
    if not helpers.wallpaper then
        if beautiful.wallpaper then
            -- set the default wallpaper from the theme
            helpers.wallpaper = beautiful.wallpaper
        elseif type(beautiful.wallpaper_list) == "table" and #beautiful.wallpaper_list > 0 then
            -- set the first wallpaper from the list
            helpers.wallpaper = beautiful.wallpaper_list[1]
        else
            helpers.wallpaper = "#bbbbbb"
        end
    end

    -- Wallpaper
    if helpers.wallpaper then
        local wallpaper = helpers.wallpaper
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

helpers.change_wallpaper = function(wallpaper)
    helpers.wallpaper = wallpaper
    for s in screen do
        helpers.set_wallpaper(s)
    end
end


helpers.set_next_wallpaper = function()
    if type(beautiful.wallpaper_list) == "table" and #beautiful.wallpaper_list > 0 then
        local list = beautiful.wallpaper_list
        local current_wallpaper_index = 1
        for i, v in ipairs(list) do
            if v == helpers.wallpaper then
                current_wallpaper_index = i
                break
            end
        end
        local next_wallpaper_index = current_wallpaper_index + 1
        if #list < next_wallpaper_index then
            next_wallpaper_index = 1
        end
        helpers.change_wallpaper(list[next_wallpaper_index])
    elseif type(beautiful.wallpaper) == "function" then
        helpers.change_wallpaper(beautiful.wallpaper)
    end
end

return helpers
