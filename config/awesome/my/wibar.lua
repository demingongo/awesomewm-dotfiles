local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local widgets = require('my.widgets')

local function create_left_widgets(s)
    return type(beautiful.create_left_widgets) == "function" and beautiful.create_left_widgets(
            widgets.launcher,
            s.mytaglist,
            s.mypromptbox
        ) or {
            layout = wibox.layout.fixed.horizontal,
            widgets.launcher,
            s.mytaglist,
            s.mypromptbox,
        }
end

local function create_middle_widgets(s)
    return beautiful.wibar_expand == "none" and
        wibox.container.constraint(s.mytasklist, "max", beautiful.tasklist_max_width or dpi(750)) or s.mytasklist
end

local function create_right_widgets(s)
    return type(beautiful.create_right_widgets) == "function" and beautiful.create_right_widgets(
            widgets.cpu_widget,
            widgets.ram_widget({}),
            widgets.volume_widget,
            widgets.battery_widget,
            widgets.keyboardlayout,
            widgets.textclock,
            s.mylayoutbox
        ) or {
            -- Right widgets default
            layout = wibox.layout.fixed.horizontal,
            widgets.spr,
            widgets.spr,
            wibox.widget.systray(),
            widgets.spr,
            widgets.arrl_ld,
            wibox.container.background(widgets.cpu_widget, beautiful.bg_focus),
            widgets.arrl_dl,
            widgets.ram_widget({
                widget_width = 40
            }),
            widgets.arrl_ld,
            wibox.container.background(widgets.padding, beautiful.bg_focus),
            wibox.container.background(widgets.volume_widget, beautiful.bg_focus),
            wibox.container.background(widgets.padding, beautiful.bg_focus),
            widgets.arrl_dl,
            widgets.padding,
            widgets.battery_widget,
            widgets.padding,
            widgets.arrl_ld,
            wibox.container.background(widgets.keyboardlayout, beautiful.bg_focus),
            widgets.arrl_dl,
            widgets.textclock,
            widgets.arrl_ld,
            wibox.container.background(s.mylayoutbox, beautiful.bg_focus),
        }
end

local function create_layout()
    return {
        layout = wibox.layout.align.horizontal,
        expand = beautiful.wibar_expand
    }
end

local function setup_wibar(s)
    local result = nil
    if type(beautiful.setup_wibar) == "function" then
        result = beautiful.setup_wibar(
            s, 
            create_layout(), 
            create_left_widgets(s),
            create_middle_widgets(s),
            create_right_widgets(s)
        )
    else
        result = create_layout()
        table.insert(result, create_left_widgets(s))
        table.insert(result, create_middle_widgets(s))
        table.insert(result, create_right_widgets(s))
    end
    return result
end

local function create_wibar(s)
    -- Create the wibar
    local mywibar = awful.wibar({
        screen = s,
        position = beautiful.wibar_position
    })

    mywibar:setup(setup_wibar(s))

    return mywibar
end

return {
    create = create_wibar
}
