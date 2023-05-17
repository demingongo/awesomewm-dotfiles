--- my/popups/shutdown-popup.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local confirm_popup = require('my.popups.confirm-popup')
local get_single_instance = require('utils.get-single-instance')

local get_shutdown_popup = get_single_instance(
    function()
        return confirm_popup({
            text = "Shutdown?",
            timeout = 61,
            confirm = function()
                os.execute('systemctl poweroff')
            end
        })
    end
)

return get_shutdown_popup
