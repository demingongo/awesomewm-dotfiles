local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local get_single_instance = require('utils.get-single-instance')
local themes = require('my.static').themes
local lockscreen_script = require('my.static').lockscreen_script
local switch_theme_script = require('my.static').switch_theme_script
local myvariables = require('my.variables')
local get_shutdown_popup = require('my.popups.shutdown-popup')

local function create_menu()
    local terminal = myvariables:get('terminal')

    -- Menubar configuration
    menubar.utils.terminal = terminal -- Set the terminal for applications that require it

    -- Create a launcher widget and a main menu
    local myawesomemenu = {
        { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        --{ "Manual", terminal .. " -e man awesome" },
        --{ "Edit config", myvariables:get('editor_cmd') .. " " .. awesome.conffile },
        { "Restart", awesome.restart },
        { "Quit",    function() awesome.quit() end },
    }

    local mypowermenu = {
        { "Lock screen",
            function() 
                awful.spawn.easy_async_with_shell(lockscreen_script)
            end
        },
        { "Shutdown",
            function()
                local shutdown_popup = get_shutdown_popup()
                shutdown_popup:show()
            end
        }
    }

    local mythemesmenu = {}

    for _, name in ipairs(themes) do
        table.insert(mythemesmenu, {
            name,
            function() os.execute(switch_theme_script .. " " .. name) end
        })
    end

    local result = freedesktop.menu.build {
        before = {
            { "Awesome", myawesomemenu, beautiful.awesome_icon },
        },
        after = {
            { "Change theme",  mythemesmenu },
            { "Power", mypowermenu },
            { "Open terminal", terminal },
        }
    }

    return result
end

local get_menu = get_single_instance(create_menu)

local mymainmenu = {}

function mymainmenu:get()
    return get_menu()
end

function mymainmenu:toggle()
    return mymainmenu:get():toggle()
end

function mymainmenu:show()
    return mymainmenu:get():show()
end

return mymainmenu
