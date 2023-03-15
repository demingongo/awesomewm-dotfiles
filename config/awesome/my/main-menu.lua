local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local get_single_instance = require('utils.get-single-instance')
local themes = require('my.static').themes
local myvariables = require('my.variables')

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

    local mythemesmenu = {}

    for _, name in ipairs(themes) do
        table.insert(mythemesmenu, {
            name,
            function() os.execute(os.getenv("HOME") .. "/.local/bin/awesome_switch_theme " .. name) end
        })
    end

    local result = freedesktop.menu.build {
        before = {
            { "Awesome", myawesomemenu, beautiful.awesome_icon },
        },
        after = {
            { "Change theme",  mythemesmenu },
            { "Open terminal", terminal }
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
