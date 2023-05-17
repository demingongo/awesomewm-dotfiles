--- my/global/init.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local myglobalkeybindings = require('my.global.keybindings')
local myglobalbuttonbindings = require('my.global.buttonbindings')

---Loads global keybindings and buttonbindings
local function load_keybindings_and_buttonbindings()
    -- Mouse bindings
    root.buttons(myglobalbuttonbindings)
    -- Key bindings
    root.keys(myglobalkeybindings)
end

return {
    load_keybindings_and_buttonbindings = load_keybindings_and_buttonbindings
}
