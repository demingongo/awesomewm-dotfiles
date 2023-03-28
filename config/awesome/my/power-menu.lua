local awful = require("awful")
local lockscreen_script = require('my.static').lockscreen_script
local get_single_instance = require('utils.get-single-instance')
local get_logout_popup = require('my.popups.logout-popup')
local get_shutdown_popup = require('my.popups.shutdown-popup')
local get_reboot_popup = require('my.popups.reboot-popup')

local function create_menu()
    local pmenu_widget = {}

    local current_popup = nil
    local popups_bag = {
        logout = nil,
        poweroff = nil,
        reboot = nil
    }

    local function is_current_popup_visible()
        return current_popup and current_popup.visible
    end

    local function get_popup(name, fn)
        if not popups_bag[name] then
            popups_bag[name] = fn()
            popups_bag[name]:connect_signal('hide', function()
                current_popup = nil
            end)
        end
        return popups_bag[name]
    end

    function pmenu_widget:logout()
        if not is_current_popup_visible() then
            current_popup = get_popup('logout', get_logout_popup)
            if current_popup then
                current_popup:show()
            end
        end
    end

    function pmenu_widget:poweroff()
        if not is_current_popup_visible() then
            current_popup = get_popup('poweroff', get_shutdown_popup)
            if current_popup then
                current_popup:show()
            end
        end
    end

    function pmenu_widget:reboot()
        if not is_current_popup_visible() then
            current_popup = get_popup('reboot', get_reboot_popup)
            if current_popup then
                current_popup:show()
            end
        end
    end

    function pmenu_widget:confirm()
        if is_current_popup_visible() then
            current_popup:confirm()
        end
    end

    function pmenu_widget:cancel()
        if is_current_popup_visible() then
            current_popup:cancel()
        end
    end

    return pmenu_widget
end

local get_menu = get_single_instance(create_menu)

local mypowermenu = {}

function mypowermenu:get()
    return get_menu()
end

function mypowermenu:lock()
    return awful.spawn.easy_async_with_shell(lockscreen_script)
end

function mypowermenu:logout()
    return get_menu():logout()
end

function mypowermenu:poweroff()
    return get_menu():poweroff()
end

function mypowermenu:reboot()
    return get_menu():reboot()
end

function mypowermenu:confirm()
    return get_menu():confirm()
end

function mypowermenu:cancel()
    return get_menu():cancel()
end

--Format for freedesktop.menu
function mypowermenu:get_table()
    return {
        { "  Lock",
            function()
                mypowermenu:lock()
            end
        },
        { "󰗽  Log out",
            function()
                mypowermenu:logout()
            end
        },
        { "  Power off",
            function()
                mypowermenu:poweroff()
            end
        },
        { "  Reboot",
            function()
                mypowermenu:reboot()
            end
        }
    }
end

return mypowermenu
