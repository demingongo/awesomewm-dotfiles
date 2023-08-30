--- my/clients/signals.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local cairo = require("lgi").cairo
local beautiful = require("beautiful")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if c and c.valid then
        local client_icon = nil
        if not c.icon and beautiful.clients_default_icon then
            client_icon = beautiful.clients_default_icon
        end

        if type(beautiful.clients_icons) == "table" and beautiful.clients_icons[c.class] then
            client_icon = beautiful.clients_icons[c.class]
            c._client_icon = client_icon
        end

        if type(beautiful.clients_focused_icons) == "table" and beautiful.clients_focused_icons[c.class] then
            c._client_focused_icon = beautiful.clients_focused_icons[c.class]
        end

        -- Set icon for client
        -- check a client's class with "xprop" command
        if client_icon then
            local s = gears.surface(client_icon)
            local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
            local cr = cairo.Context(img)
            cr:set_source_surface(s, 0, 0)
            cr:paint()
            gears.timer ({
                callback = function() c.icon = img._native end,
                timeout = 0.5,
                autostart = true,
                single_shot = true
            })
        end
    end

    -- shape border radius
    if type(beautiful.border_radius) == "number" then
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end
    end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar_extra_args = type(beautiful.titlebar_extra_args) == "table" and 
        beautiful.titlebar_extra_args or {}

    local is_horizontal_titlebar = not (titlebar_extra_args.position == 'left' or titlebar_extra_args.position == 'right')

    awful.titlebar(c, titlebar_extra_args):setup {
        {
            -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = is_horizontal_titlebar and wibox.layout.fixed.horizontal or wibox.layout.fixed.vertical
        },
        {
            -- Middle
            is_horizontal_titlebar and {
                -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            } or nil,
            buttons = buttons,
            layout  = is_horizontal_titlebar and wibox.layout.flex.horizontal or wibox.layout.flex.vertical
        },
        {
            -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = is_horizontal_titlebar and wibox.layout.fixed.horizontal() or wibox.layout.fixed.vertical()
        },
        layout = is_horizontal_titlebar and wibox.layout.align.horizontal or wibox.layout.align.vertical
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
