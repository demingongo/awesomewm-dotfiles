-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local tasklist = require('my.tasklist')
local taglist = require('my.taglist')
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
local current_theme = require('my.static').current_theme
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), current_theme))

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    --awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}


local mymainmenu = require('my.main-menu')

local widgets = require('my.widgets')
local wibar = require('my.wibar')

local mylauncher = widgets.launcher
local mykeyboardlayout = widgets.keyboardlayout
local mytextclock = widgets.textclock

-- Create a wibox for each screen and add it

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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Separators
local spr     = widgets.spr
local arrl_dl = widgets.arrl_dl
local arrl_ld = widgets.arrl_ld
local padding = widgets.padding

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(beautiful.taglist_tags or { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = widgets.create_promptbox()
    
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = widgets.create_layoutbox(s)

    -- Create the taglist
    s.mytaglist = taglist.create(s)

    -- Create the tasklist
    s.mytasklist = tasklist.create(s)

    -- Create the wibox
    s.mywibox = wibar.create(s)

    -- Add widgets to the wibox
    if type(beautiful.setup_wibar) == "function" then
        s.mywibox:setup(
            beautiful.setup_wibar(
                s,
                {
                    layout = wibox.layout.align.horizontal,
                    expand = beautiful.wibar_expand
                },
                type(beautiful.create_left_widgets) == "function" and beautiful.create_left_widgets(
                    mylauncher,
                    s.mytaglist,
                    s.mypromptbox
                ) or {
                -- Left widgets default
                    layout = wibox.layout.fixed.horizontal,
                    mylauncher,
                    s.mytaglist,
                    s.mypromptbox,
                },
                -- Middle widget
                beautiful.wibar_expand == "none" and
                wibox.container.constraint(s.mytasklist, "max", beautiful.tasklist_max_width or 750) or s.mytasklist,
                -- Right widgets
                type(beautiful.create_right_widgets) == "function" and beautiful.create_right_widgets(
                    widgets.cpu_widget,
                    ram_widget({}),
                    volume_widget {
                        widget_type = beautiful.volume_widget_type or 'arc',
                        shape = 'hexagon',
                    },
                    batteryarc_widget({
                        show_current_level = true,
                        show_notification_mode = 'on_hover',
                        notification_position = beautiful.batteryarc_notification_position or 'top_right',
                        arc_thickness = 2,
                        size = 18,
                        enable_battery_warning = true,
                        timeout = 10,
                        main_color = beautiful.batteryarc_main_color or '#756321'
                    }),
                    mykeyboardlayout,
                    mytextclock,
                    s.mylayoutbox
                ) or {
                -- Right widgets default
                    layout = wibox.layout.fixed.horizontal,
                    spr,
                    spr,
                    wibox.widget.systray(),
                    spr,
                    arrl_ld,
                    wibox.container.background(widgets.cpu_widget, beautiful.bg_focus),
                    arrl_dl,
                    ram_widget({
                        widget_width = 40
                    }),
                    arrl_ld,
                    wibox.container.background(
                        padding,
                        beautiful.bg_focus),
                    wibox.container.background(
                        volume_widget {
                            widget_type = beautiful.volume_widget_type or 'arc',
                            shape = 'hexagon',
                        }, beautiful.bg_focus),
                    wibox.container.background(
                        padding,
                        beautiful.bg_focus),
                    arrl_dl,
                    padding,
                    batteryarc_widget({
                        show_current_level = true,
                        show_notification_mode = 'on_hover',
                        notification_position = beautiful.batteryarc_notification_position or 'top_right',
                        arc_thickness = 2,
                        size = 18,
                        enable_battery_warning = true,
                        timeout = 10,
                        main_color = beautiful.batteryarc_main_color or '#756321'
                    }),
                    padding,
                    arrl_ld,
                    wibox.container.background(
                        mykeyboardlayout,
                        beautiful.bg_focus),
                    arrl_dl,
                    mytextclock,
                    arrl_ld,
                    wibox.container.background(
                        s.mylayoutbox,
                        beautiful.bg_focus),
                }
            )
        )
    else
        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            expand = beautiful.wibar_expand,
            -- Left widgets
            type(beautiful.create_left_widgets) == "function" and beautiful.create_left_widgets(
                mylauncher,
                s.mytaglist,
                s.mypromptbox
            ) or {
            -- Left widgets default
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            -- Middle widget
            beautiful.wibar_expand == "none" and
            wibox.container.constraint(s.mytasklist, "max", beautiful.tasklist_max_width or 750) or s.mytasklist,
            -- Right widgets
            type(beautiful.create_right_widgets) == "function" and beautiful.create_right_widgets(
                widgets.cpu_widget,
                ram_widget({}),
                volume_widget {
                    widget_type = beautiful.volume_widget_type or 'arc',
                    shape = 'hexagon',
                },
                batteryarc_widget({
                    show_current_level = true,
                    show_notification_mode = 'on_hover',
                    notification_position = beautiful.batteryarc_notification_position or 'top_right',
                    arc_thickness = 2,
                    size = 18,
                    enable_battery_warning = true,
                    timeout = 10,
                    main_color = beautiful.batteryarc_main_color or '#756321'
                }),
                mykeyboardlayout,
                mytextclock,
                s.mylayoutbox
            ) or {
            -- Right widgets default
                layout = wibox.layout.fixed.horizontal,
                spr,
                spr,
                wibox.widget.systray(),
                spr,
                arrl_ld,
                wibox.container.background(widgets.cpu_widget, beautiful.bg_focus),
                arrl_dl,
                ram_widget({
                    widget_width = 40
                }),
                arrl_ld,
                wibox.container.background(
                    padding,
                    beautiful.bg_focus),
                wibox.container.background(
                    volume_widget {
                        widget_type = beautiful.volume_widget_type or 'arc',
                        shape = 'hexagon',
                    }, beautiful.bg_focus),
                wibox.container.background(
                    padding,
                    beautiful.bg_focus),
                arrl_dl,
                padding,
                batteryarc_widget({
                    show_current_level = true,
                    show_notification_mode = 'on_hover',
                    notification_position = beautiful.batteryarc_notification_position or 'top_right',
                    arc_thickness = 2,
                    size = 18,
                    enable_battery_warning = true,
                    timeout = 10,
                    main_color = beautiful.batteryarc_main_color or '#756321'
                }),
                padding,
                arrl_ld,
                wibox.container.background(
                    mykeyboardlayout,
                    beautiful.bg_focus),
                arrl_dl,
                mytextclock,
                arrl_ld,
                wibox.container.background(
                    s.mylayoutbox,
                    beautiful.bg_focus),
            },
        }
    end
end)
-- }}}

-- Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- Key bindings
local keybindings = require('my.keybindings')
-- Set keys
root.keys(keybindings.globalkeys)

require('my.rules')(keybindings.clientkeys, keybindings.clientbuttons)
require('my.signals')
require('my.autostart')
