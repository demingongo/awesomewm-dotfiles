local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function init_toggable_systray(args)
    local props = type(args) == "table" and args or {}

    -- hide systray from the start
    local hidden_at_start = props.hidden_at_start or false

    -- no tooltip
    local no_tooltip = props.no_tooltip or false

    -- left or right
    local toggle_side = props.toggle_side == "right"
        and props.toggle_side or "left"

    -- show icon
    local text_icon_show = type(props.text_icon_show) == "string"
        and props.text_icon_show
        or (toggle_side == "left" and " ")
        or " "

    -- hide icon
    local text_icon_hide = type(props.text_icon_hide) == "string"
        and props.text_icon_hide
        or (toggle_side == "left" and " ")
        or " "

    -- icon + tooltip
    local text_icon = wibox.widget.textbox(text_icon_hide)
    if not no_tooltip then
        awful.tooltip {
            objects        = { text_icon },
            timer_function = function()
                return "systray"
            end,
            fg             = beautiful.fg_normal,
            bg             = beautiful.bg_normal
        }
    end

    -- systray widget
    local systray = wibox.widget.systray(true)

    -- wibox.container.margin
    local systray_container = wibox.widget {
        {
            systray,
            widget = wibox.container.place
        },
        visible = true,
        bottom = props.margin_bottom,
        top = props.margin_top,
        left = props.margin_left,
        right = props.margin_right,
        widget = wibox.container.margin
    }

    local widget_layout = {
        layout = wibox.layout.align.horizontal
    }
    if toggle_side == "left" then
        table.insert(widget_layout, text_icon)
        table.insert(widget_layout, systray_container)
    else
        table.insert(widget_layout, systray_container)
        table.insert(widget_layout, text_icon)
    end

    -- wibox.container.background
    local t_systray_widget = wibox.widget {
        widget_layout,
        widget = wibox.container.background
    }

    local function do_show()
        if not systray_container.visible then
            systray_container.visible = true
            text_icon:set_text(text_icon_hide)
        end
    end
    local function do_hide()
        if systray_container.visible then
            systray_container.visible = false
            text_icon:set_text(text_icon_show)
        end
    end
    local function toggle()
        if systray_container.visible then
            do_hide()
        else
            do_show()
        end
    end

    text_icon:buttons(awful.util.table.join(awful.button({}, 1, function()
        toggle()
    end)))

    text_icon:connect_signal("mouse::enter", function()
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "hand2" end
    end)
    text_icon:connect_signal("mouse::leave", function()
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "left_ptr" end
    end)

    function t_systray_widget:get_systray()
        return systray
    end

    function t_systray_widget:get_text_icon()
        return text_icon
    end

    function t_systray_widget:show()
        return do_show()
    end

    function t_systray_widget:hide()
        return do_hide()
    end

    function t_systray_widget:toggle()
        return toggle()
    end

    if hidden_at_start then
        -- hack: needs to be triggered one time to work as it should
        gears.timer {
            autostart   = true,
            timeout     = 0.5,
            callback    = toggle,
            single_shot = true
        }
    end

    return t_systray_widget
end

return setmetatable({}, { __call = function(_, ...) return init_toggable_systray(...) end })
