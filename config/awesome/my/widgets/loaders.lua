local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local separators = require("lain").util.separators
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local mymainmenu = require('my.main-menu')
local get_single_instance = require('my.widgets.get-single-instance')

return {
    -- Separators
    spr = get_single_instance(function()
        return wibox.widget.textbox(' ')
    end),
    arrl_dl = get_single_instance(function()
        return separators.arrow_left(beautiful.bg_focus, "alpha")
    end),
    arrl_ld = get_single_instance(function()
        return separators.arrow_left("alpha", beautiful.bg_focus)
    end),
    padding = get_single_instance(function()
        return wibox.widget.textbox('   ')
    end),
    --{{{ Widgets

    -- launcher
    launcher = function(args)
        local props = args or {}
        props.image = props.image or beautiful.awesome_icon
        props.menu = mymainmenu:get()
        return awful.widget.launcher(props)
    end,
    -- Keyboard map indicator and switcher
    keyboardlayout = function()
        return awful.widget.keyboardlayout()
    end,
    -- Clock / calendar
    textclock = function(args)
        local props = args or {}
        props.theme = props.theme or beautiful.calendar_theme or 'nord'
        props.placement = props.placement or beautiful.calendar_position or 'top_right'
        props.start_sunday = props.start_sunday or (type(beautiful.calendar_start_sunday) ~= 'boolean') and true or
            beautiful.calendar_start_sunday
        props.radius = props.radius or beautiful.calendar_radius or dpi(8)
        props.previous_month_button = 5
        props.next_month_button = 4

        -- Calendar widget
        local cw = calendar_widget(props)

        -- Create a textclock widget
        local mytextclock = wibox.widget.textclock(props.format or beautiful.textclock_format or '%a %b %d, %R')
        mytextclock:connect_signal("button::press",
            function(_, _, _, button)
                if button == 1 then cw.toggle() end
            end)
        return mytextclock
    end,
    -- CPU monitor
    cpu_widget = function(args)
        local props = args or {}
        props.width = props.width or dpi(40)
        props.step_width = props.step_width or dpi(2)
        props.step_spacing = props.step_spacing or dpi(1)
        props.color = props.color or beautiful.cpu_widget_color or '#009900'
        return cpu_widget(props)
    end,
    -- RAM monitor
    ram_widget = function(args)
        local props = args or {}
        return ram_widget(props)
    end,
    -- Volume control
    volume_widget = function(args)
        local props = args or {}
        props.widget_type = props.widget_type or beautiful.volume_widget_type or 'arc'
        props.shape = props.shape or 'hexagon'
        return volume_widget(props)
    end,
    -- Battery indicator
    battery_widget = function(args)
        local props = args or {}
        props.show_current_level = true
        props.enable_battery_warning = true
        props.timeout = 10
        props.show_notification_mode = props.show_notification_mode or 'on_hover'
        props.notification_position = props.notification_position or beautiful.batteryarc_notification_position or
            'top_right'
        props.arc_thickness = props.arc_thickness or 2
        props.size = props.size or dpi(18)
        props.main_color = props.main_color or beautiful.batteryarc_main_color or '#756321'
        return batteryarc_widget(props)
    end
    --}}}
}
