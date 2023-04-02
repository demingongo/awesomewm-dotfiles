local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local xrandr = require("xrandr")
local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
local modkey = require('my.static').modkey
local screenshots_path = require('my.static').screenshots_path
local myvariables = require('my.variables')
local mymainmenu = require('my.main-menu')
local mypowermenu = require('my.power-menu')
local set_next_wallpaper = require("my.screens.helpers").set_next_wallpaper

local globalkeys = gears.table.join(
    --  Audio
    awful.key({}, "XF86AudioRaiseVolume", function() volume_widget:inc(5) end,
    { description = "volume +5%", group = "hotkeys" }),
    awful.key({}, "XF86AudioLowerVolume", function() volume_widget:dec(5) end,
    { description = "volume -5%", group = "hotkeys" }),
    awful.key({}, "XF86AudioMute", function() volume_widget:toggle() end,
    { description = "toggle mute", group = "hotkeys" }),
    awful.key({}, "XF86AudioPlay", function() os.execute("playerctl play-pause") end,
    { description = "player pause/play", group = "hotkeys" }),
    awful.key({}, "XF86AudioNext", function() os.execute("playerctl next") end,
    { description = "player next", group = "hotkeys" }),
    awful.key({}, "XF86AudioPrev", function() os.execute("playerctl previous") end,
    { description = "player previous", group = "hotkeys" }),

    -- Brightness
    awful.key({}, "XF86MonBrightnessDown", function() os.execute("brightnessctl set 5%-") end,
        { description = "brightness -5%", group = "hotkeys" }),
    awful.key({}, "XF86MonBrightnessUp", function() os.execute("brightnessctl set 5%+") end,
        { description = "brightness +5%", group = "hotkeys" }),

    -- Print Screen
    awful.key({}, "Print", function()
            os.execute("scrot " .. screenshots_path .. "/awesome_screenshot_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".png")
        end,
        { description = "capture screen", group = "screenshots" }),
    awful.key({ modkey }, "Print", function()
            os.execute("scrot -ub " .. screenshots_path .. "/awesome_screenshot_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".png")
        end,
        { description = "capture window", group = "screenshots" }),
    awful.key({ modkey, "Shift" }, "Print", function()
            os.execute("scrot -s " .. screenshots_path .. "/awesome_screenshot_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".png")
        end,
        { description = "capture area", group = "screenshots" }),

    -- Power (c, e, r, t, y, z)
    awful.key({ modkey }, "c", function() mypowermenu:lock() end,
        { description = "lock screen", group = "power" }),
    awful.key({ modkey, "Shift" }, "e", function() mypowermenu:logout() end,
        { description = "log out (exit)", group = "power" }),
    awful.key({ modkey, "Shift" }, "r", function() mypowermenu:reboot() end,
        { description = "reboot", group = "power" }),
    awful.key({ modkey, "Shift" }, "t", function() mypowermenu:poweroff() end,
        { description = "power off (terminate)", group = "power" }),
    awful.key({ modkey }, "z", function() mypowermenu:cancel() end,
        { description = "cancel action", group = "power" }),
    awful.key({ modkey }, "y", function() mypowermenu:confirm() end,
        { description = "confirm action", group = "power" }),

    -- Wallpaper
    awful.key({ modkey, "Shift" }, "g", function() set_next_wallpaper() end,
        { description = "select next wallpaper", group = "screen" }),

    -- Multiple monitors
    awful.key({ modkey, "Shift" }, "v", function() xrandr.xrandr() end,
        { description = "xrandr", group = "screen" }),

    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    awful.key({ modkey, }, "Down",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "Up",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key({ modkey, }, "w", function() mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "Down", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "Up", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),

    -- Standard program
    awful.key({ modkey, }, "Return", function() awful.spawn(myvariables:get('terminal')) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    --[[
    awful.key({ modkey, "Shift" }, "e", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    --]]
    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end,
        { description = "restore minimized", group = "client" }),

    -- Prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),

    awful.key({ modkey }, "x",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" }),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
        { description = "show the menubar", group = "launcher" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

--
-- Tags with numpad
--
local np_map = { 87, 88, 89, 83, 84, 85, 79, 80, 81 }
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. np_map[i],
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag numpad" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. np_map[i],
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag numpad" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. np_map[i],
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag numpad" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. np_map[i],
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag numpad" })
    )
end

return globalkeys