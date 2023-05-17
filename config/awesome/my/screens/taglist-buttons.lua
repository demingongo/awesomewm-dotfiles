--- my/screens/taglist-buttons.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local gears = require("gears")
local awful = require("awful")
local modkey = require('my.static').modkey

return gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)