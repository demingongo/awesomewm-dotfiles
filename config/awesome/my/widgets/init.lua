local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local loaders = require('my.widgets.loaders')

-- loaders for each widget
local mywidgets = {}

function mywidgets:create_promptbox()
    return type(beautiful.create_promptbox) == "function" and beautiful.create_promptbox() or awful.widget.prompt()
end

function mywidgets:create_layoutbox(s)
    local mylayoutbox = awful.widget.layoutbox(s)
    mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
    return mylayoutbox
end

function mywidgets:load(functionName, ...)
    assert(type(functionName) == "string", 'my.widgets:load expected first argument to be a "string", got "' .. type(functionName) .. '"')
    assert(type(mywidgets[functionName]) == "table", 'widget loader "' .. functionName .. '" was not found')
    return mywidgets[functionName](...)
end

for name, load in pairs(loaders)
do
    mywidgets[name] = setmetatable({}, {
        __call = function(_, ...)
            return load(...)
        end
    })
end

return mywidgets
