local awful = require("awful")
local beautiful = require("beautiful")
local taglist_buttons = require('my.screens.taglist-buttons')

local function create_taglist(s)
    local taglist = nil
    
    local taglist_args = {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }
    if beautiful.taglist_template then
        taglist_args.widget_template = beautiful.taglist_template
    end

    -- Create a taglist widget
    if type(beautiful.create_taglist) == "function" then
        taglist = beautiful.create_taglist(taglist_args, s)
    else
        taglist = awful.widget.taglist(taglist_args)
    end

    return taglist
end

return {
    create = create_taglist
}