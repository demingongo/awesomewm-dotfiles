--- my/screens/tasklist.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local awful = require("awful")
local beautiful = require("beautiful")
local tasklist_buttons = require('my.screens.tasklist-buttons')

local function create_tasklist(s)
    local tasklist_args = {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    };

    local tasklist = nil

    -- Create a tasklist widget
    if type(beautiful.create_tasklist) == "function" then
        tasklist = beautiful.create_tasklist(tasklist_args, s)
    else
        tasklist = awful.widget.tasklist(tasklist_args)
    end

    return tasklist
end

return {
    create = create_tasklist
}