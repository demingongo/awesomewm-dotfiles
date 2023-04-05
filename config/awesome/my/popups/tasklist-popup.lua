local gears            = require("gears")
local awful            = require("awful")
local wibox            = require("wibox")
local tasklist_buttons = require("my.screens.tasklist-buttons")

local function create_tasklist_popup(s)
    local tasklist = awful.widget.tasklist {
        screen          = s,
        filter          = awful.widget.tasklist.filter.currenttags,
        buttons         = tasklist_buttons,
        style           = {
            shape = gears.shape.rounded_rect,
        },
        layout          = {
            spacing = 5,
            orientation = "vertical",
            forced_num_cols = 4,
            layout = wibox.layout.grid.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 4,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 48,
            forced_height   = 48,
            widget          = wibox.container.background,
            create_callback = function(self, c, index, objects) --luacheck: no unused
                self:get_children_by_id('clienticon')[1].client = c
            end,
        },
    }
    return awful.popup {
        widget       = {
            tasklist,
            margins = 5,
            widget  = wibox.container.margin
        },
        border_color = '#777777',
        border_width = 2,
        ontop        = true,
        placement    = awful.placement.centered,
        shape        = gears.shape.rounded_rect,
        visible      = false
    }
end


return {
    create_tasklist_popup = create_tasklist_popup
}
