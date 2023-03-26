local confirm_popup = require('my.popups.confirm-popup')
local get_single_instance = require('utils.get-single-instance')

local get_logout_popup = get_single_instance(
    function()
        return confirm_popup({
            text = "Logout?",
            timeout = 61,
            confirm = function()
                awesome.quit()
            end
        })
    end
)

return get_logout_popup
