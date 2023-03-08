local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local separators = require("lain").util.separators
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local mymainmenu = require('my.main-menu')

-- Calendar widget
local cw = calendar_widget({
    theme = beautiful.calendar_theme or 'nord',
    placement = beautiful.calendar_position or 'top_right',
    start_sunday = (type(beautiful.calendar_start_sunday) ~= 'boolean') and true or beautiful.calendar_start_sunday,
    radius = beautiful.calendar_radius or 8,
    previous_month_button = 5,
    next_month_button = 4,
})

-- Create a textclock widget
local mytextclock = wibox.widget.textclock(beautiful.textclock_format or '%a %b %d, %R')
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)


return {
    -- Separators
    spr = wibox.widget.textbox(' '),
    arrl_dl = separators.arrow_left(beautiful.bg_focus, "alpha"),
    arrl_ld = separators.arrow_left("alpha", beautiful.bg_focus),
    padding = wibox.widget.textbox('   '),
    -- Widgets
    launcher = awful.widget.launcher({
        image = beautiful.awesome_icon,
        menu = mymainmenu
    }),
    -- Keyboard map indicator and switcher
    keyboardlayout = awful.widget.keyboardlayout(),
    textclock = mytextclock,
    cpu_widget = cpu_widget({
        width = 40,
        step_width = 2,
        step_spacing = 1,
        color = beautiful.cpu_widget_color or '#009900'
    }),
    ram_widget = ram_widget({}),
    volume_widget = volume_widget {
        widget_type = beautiful.volume_widget_type or 'arc',
        shape = 'hexagon',
    },
    battery_widget = batteryarc_widget({
        show_current_level = true,
        show_notification_mode = 'on_hover',
        notification_position = beautiful.batteryarc_notification_position or 'top_right',
        arc_thickness = 2,
        size = 18,
        enable_battery_warning = true,
        timeout = 10,
        main_color = beautiful.batteryarc_main_color or '#756321'
    }),
    create_promptbox = function ()
        return awful.widget.prompt()
    end,
    create_layoutbox = function (s)
        local mylayoutbox = awful.widget.layoutbox(s)
        mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
        return mylayoutbox
    end
}
