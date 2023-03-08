local awful = require("awful")
local beautiful = require("beautiful")

local function create_wibar(s)
    local wibar_args = {
        screen = s,
        position = beautiful.wibar_position,
        --height = beautiful.wibar_height,
        --opacity = beautiful.wibar_opacity or 1,
        --border_width = beautiful.wibar_border_width or 0,

        --visible = false
    }

    --[[
    if beautiful.wibar_bg then
	wibar_args.bg = beautiful.wibar_bg
    end
    --]]
    -- Create the wibar
    local mywibar = awful.wibar(wibar_args)

    return mywibar
end

return {
    create = create_wibar
}