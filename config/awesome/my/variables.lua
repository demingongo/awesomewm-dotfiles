local beautiful = require("beautiful")

-- This is used later as the default terminal and editor to run.
local terminal = beautiful.terminal or "kitty"
local editor = "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

return {
    terminal = terminal,
    editor = editor,
    editor_cmd = editor_cmd,
    modkey = modkey
}
