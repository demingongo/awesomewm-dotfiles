local awful = require("awful")
local list_themes = require("utils.list-themes")
local get_current_theme_name = require('utils.get-current-theme-name')

local themes = list_themes() -- { "ricework", "spywork", "yumework" }
local function has_theme(val)
    for index, value in ipairs(themes) do
        if value == val then
            return true
        end
    end
    return false
end

local tmp_theme_name = get_current_theme_name()
local theme_name = has_theme(tmp_theme_name) and tmp_theme_name or themes[1] or "ricework";

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local default_layouts = {
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


return {
    themes = themes,
    current_theme = theme_name,
    modkey = modkey,
    default_layouts = default_layouts,

    screenshots_path = os.getenv("HOME") .. "/Pictures/Screenshots",

    --Lockscreen script path
    lockscreen_script = os.getenv("HOME") .. "/.local/bin/lockscreen",
    --Switch theme script path
    switch_theme_script = os.getenv("HOME") .. "/.local/bin/awesome_switch_theme"
}
