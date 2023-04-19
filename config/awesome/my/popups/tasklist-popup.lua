local gears            = require("gears")
local awful            = require("awful")
local wibox            = require("wibox")
local tasklist_buttons = require("my.screens.tasklist-buttons")
local beautiful = require("beautiful")

---@param props table
---@param name string
---@return unknown
local function get_prop_value(props, name)
    return props[name] or beautiful["popups_" .. name]
end

local function create_tasklist_popup(s, args)
    local props = type(args) == "table" and args or {}

    props.close_button_text = props.close_button_text or 'X'
    props.border_width = get_prop_value(props, 'border_width')
    props.border_color = get_prop_value(props, 'border_color')
    props.close_bg = get_prop_value(props, 'close_bg')
    props.close_fg = get_prop_value(props, 'close_fg')
    props.fg = get_prop_value(props, 'fg')

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
    local close_button = wibox.widget {
        {
            {
                wibox.widget.textbox(''),
                wibox.widget.textbox(props.close_button_text),
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            left   = 5,
            right  = 5,
            top    = 5,
            bottom = 5,
            widget = wibox.container.margin
        },
        fg     = props.close_fg or props.fg,
        bg     = props.close_bg or props.border_color,
        shape  = function (cr, width, height, radius)
            return gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
        end,
        widget = wibox.widget.background
    }
    local close_button_bg = close_button.bg or beautiful.bg_normal
    local close_button_fg = close_button.fg or beautiful.fg_normal or "#ffffff"
    close_button:connect_signal("mouse::enter", function()
        if close_button_fg and type(close_button.set_bg) == 'function' then
            close_button:set_bg(close_button_fg)
        end
        if close_button_bg and type(close_button.set_fg) == 'function' then
            close_button:set_fg(close_button_bg)
        end
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "hand2" end
    end)
    close_button:connect_signal("mouse::leave", function()
        if close_button_bg and type(close_button.set_bg) == 'function' then
            close_button:set_bg(close_button_bg)
        end
        if close_button_fg and type(close_button.set_fg) == 'function' then
            close_button:set_fg(close_button_fg)
        end
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "left_ptr" end
    end)

    local widget = awful.popup {
        widget       = {
            {
                tasklist,
                close_button,
                spacing = 4,
                layout = wibox.layout.fixed.vertical
            },
            margins = 5,
            widget  = wibox.container.margin
        },
        border_color = props.border_color,
        border_width = props.border_width,
        ontop        = true,
        placement    = awful.placement.centered,
        shape        = gears.shape.rounded_rect,
        visible      = false
    }

    function widget:show()
        if not widget.visible then
            widget.visible = not widget.visible
        end
    end

    function widget:hide()
        if widget then
            local w = mouse.current_wibox
            if w then w.cursor = "left_ptr" end
            widget.visible = not widget.visible
        end
    end

    function widget:toggle()
        if not widget.visible then
            widget:show()
        else
            widget:hide()
        end
    end

    close_button:buttons(awful.util.table.join(awful.button({}, 1, function()
        widget:hide()
    end)))
    return widget
end


return {
    create_tasklist_popup = create_tasklist_popup
}
