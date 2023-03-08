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

return {
    themes = themes,
    current_theme = theme_name,
    modkey = modkey
}