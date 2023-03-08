local beautiful = require("beautiful")

-- This is used later as the default terminal and editor to run.
local terminal = beautiful.terminal or "kitty"
local editor = "nvim"
local editor_cmd = terminal .. " -e " .. editor

return {
    terminal = terminal,
    editor = editor,
    editor_cmd = editor_cmd
}
