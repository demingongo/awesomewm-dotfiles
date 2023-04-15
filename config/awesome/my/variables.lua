local awful = require("awful")
local beautiful = require("beautiful")

local initiated = false

local variables = {}

-- This is used later as the default terminal and editor to run.
variables.terminal = beautiful.terminal or "kitty"
variables.editor = "nvim"
variables.editor_cmd = variables.terminal .. " -e " .. variables.editor

-- Table of layouts to cover with awful.layout.inc, order matters.
variables.layouts = beautiful.layouts or {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}


function variables:get(name)
    if not initiated then
        variables.terminal = beautiful.terminal or "kitty"
        variables.editor_cmd = variables.terminal .. " -e " .. variables.editor
        variables.layouts = beautiful.layouts or variables.layouts
        initiated = true
    end
    return variables[name]
end

return variables
