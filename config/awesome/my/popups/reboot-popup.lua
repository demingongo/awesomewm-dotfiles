local confirm_popup = require('my.popups.confirm-popup')
local get_single_instance = require('utils.get-single-instance')

local get_reboot_popup = get_single_instance(
    function()
        return confirm_popup({
            text = "Reboot?",
            timeout = 61,
            confirm = function()
                os.execute('systemctl reboot')
            end
        })
    end
)

return get_reboot_popup
