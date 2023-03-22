local awful = require("awful")
local beautiful = require("beautiful")
local taglist_buttons = require('my.screens.taglist-buttons')

local function create_taglist(s)
    local taglist = nil

    -- Each screen has its own tag table.
    awful.tag(beautiful.taglist_tags or { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s,
        #awful.layout.layouts > 0 and awful.layout.layouts[1] or awful.layout.suit.tile)

    -- Adding more tags
    if (type(beautiful.init_tags_for_screen) == "function") then
        local tags = beautiful.init_tags_for_screen(s)
        for name, props in pairs(tags)
        do
            props.screen = props.screen or s
            awful.tag.add(props.tag_name or props.name or name, props)
        end
    end


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
