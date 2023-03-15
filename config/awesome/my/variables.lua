local beautiful = require("beautiful")

local initiated = false

local variables = {}

-- This is used later as the default terminal and editor to run.
variables.terminal = beautiful.terminal or "kitty"
variables.editor = "nvim"
variables.editor_cmd = variables.terminal .. " -e " .. variables.editor


function variables:get(name)
    if not initiated then
        variables.terminal = beautiful.terminal or "kitty"
        variables.editor_cmd = variables.terminal .. " -e " .. variables.editor
        initiated = true
    end
    return variables[name]
end

return variables
