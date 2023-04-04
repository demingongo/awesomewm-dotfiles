local gears               = require("gears")
local awful               = require("awful")
local wibox               = require("wibox")
local tasklist_buttons    = require("my.screens.tasklist-buttons")
local get_single_instance = require("utils.get-single-instance")

return get_single_instance(
    function(args)
        return awful.popup {
            widget       = awful.widget.tasklist {
                screen          = screen[1],
                filter          = awful.widget.tasklist.filter.currenttags,
                buttons         = tasklist_buttons,
                style           = {
                    shape = gears.shape.rounded_rect,
                },
                layout          = {
                    spacing = 5,
                    forced_num_rows = 2,
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
            },
            border_color = '#777777',
            border_width = 2,
            ontop        = true,
            placement    = awful.placement.centered,
            shape        = gears.shape.rounded_rect,
            visible      = false
        }
    end)
