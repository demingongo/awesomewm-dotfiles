local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require('naughty')

local function container_shape(cr, width, height, radius)
    return gears.shape.rounded_rect(cr, width, height, 3)
end

---@param props table
---@param name string
---@return unknown
local function get_prop_value(props, name)
    return props[name] or beautiful["popups_" .. name]
end

local function text_container(w, bg)
    return wibox.widget {
        {
            {
                wibox.widget.textbox(''),
                w,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            left = 5,
            right = 5,
            top = 5,
            bottom = 5,
            widget  = wibox.container.margin
        },
        bg     = bg,
        shape  = container_shape,
        widget = wibox.widget.background
    }
end

local function format_button(widget, bg, bg_hover, fg, fg_hover)
    local bg_base = bg or widget.bg
    local fg_base = fg or widget.fg
    widget:connect_signal("mouse::enter", function()
        if bg_hover and type(widget.set_bg) == 'function' then
            widget:set_bg(bg_hover)
        end
        if fg_hover and type(widget.set_fg) == 'function' then
            widget:set_fg(fg_hover)
        end
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "hand2" end
    end)
    widget:connect_signal("mouse::leave", function()
        if bg_base and type(widget.set_bg) == 'function' then
            widget:set_bg(bg_base)
        end
        if fg_base and type(widget.set_fg) == 'function' then
            widget:set_fg(fg_base)
        end
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "left_ptr" end
    end)
end

---Returns a awful.popup
---@param args { font?: string, timeout_font?: string, fg?: string, bgimage?: string, bg?: string, text_bg?: string, confirm_bg?: string, cancel_bg?: string, border_width?: number, border_color?: string, text?: string, yes_text?: string, cancel_text?: string, timeout?: number, confirm?: function, cancel?: function }
---@return {}
local function init_confirm_popup(args)
    local props = type(args) == "table" and args or {}

    props.font = get_prop_value(props, 'font')
    props.timeout_font = get_prop_value(props, 'timeout_font')
    props.fg = get_prop_value(props, 'fg') or beautiful.fg_normal
    props.bgimage = get_prop_value(props, 'bgimage')
    props.bg = get_prop_value(props, 'bg')
    props.text_bg = get_prop_value(props, 'text_bg')
    props.confirm_bg = get_prop_value(props, 'confirm_bg')
    props.cancel_bg = get_prop_value(props, 'cancel_bg')
    props.confirm_hover_bg = get_prop_value(props, 'confirm_hover_bg')
    props.confirm_hover_fg = get_prop_value(props, 'confirm_hover_fg')
    props.cancel_hover_bg = get_prop_value(props, 'cancel_hover_bg')
    props.cancel_hover_fg = get_prop_value(props, 'cancel_hover_fg')
    props.border_width = get_prop_value(props, 'border_width')
    props.border_color = get_prop_value(props, 'border_color')
    props.minimum_width = get_prop_value(props, 'minimum_width')
    props.minimum_height = get_prop_value(props, 'minimum_height')
    props.maxmimum_width = get_prop_value(props, 'maxmimum_width')
    props.maximum_height = get_prop_value(props, 'maximum_height')
    props.width = get_prop_value(props, 'width')
    props.height = get_prop_value(props, 'height')

    local function confirm_callback ()
        if type(props.confirm) == "function" then
            props.confirm()
        else
            naughty.notify {
                title = 'Confirm popup',
                text = "default callback"
            }
        end
    end

    local function cancel_callback ()
        if type(props.cancel) == "function" then
            props.cancel()
        end
    end

    local yes_button = text_container({
        text   = props.yes_text or 'Yes',
        font = props.font,
        widget = wibox.widget.textbox
    }, props.confirm_bg)
    format_button(
        yes_button, 
        props.confirm_bg,
        props.confirm_hover_bg,
        props.fg,
        props.confirm_hover_fg
    )

    local cancel_button = text_container({
        text   = props.cancel_text or 'No',
        font = props.font,
        widget = wibox.widget.textbox
    }, props.cancel_bg)
    format_button(
        cancel_button, 
        props.cancel_bg, 
        props.cancel_hover_bg,
        props.fg,
        props.cancel_hover_fg
    )

    -- {{{ Countdown
    local countdown_textbox = nil
    local countdown_timer = nil
    local countdown_count = 1
    local countdown_pace = 2
    ---@param value integer
    ---@return integer
    local function format_countdown_value(value)
        local formatted_value = value - 1 -- because display might be late
        if formatted_value < 0 then formatted_value = 0 end
        return formatted_value
    end
    local function get_countdown_string(value)
        if value < 0 then
            value = 0
        end
        return "... " .. value .. " seconds"
    end
    local function reset_countdown_timer()
        if countdown_timer then
            countdown_count = 1
            countdown_textbox:set_text(
                get_countdown_string(
                    format_countdown_value(props.timeout)
                )
            )
            countdown_timer:again()
        end
    end
    local function stop_countdown_timer()
        if countdown_timer then
            countdown_timer:stop()
        end
    end

    if type(props.timeout) == 'number' and props.timeout > countdown_pace then
        countdown_textbox = wibox.widget {
            text = get_countdown_string(props.timeout),
            font = props.timeout_font or props.font,
            widget = wibox.widget.textbox
        }

        countdown_timer = gears.timer.start_new (countdown_pace, function ()
            countdown_textbox:set_text(
                get_countdown_string(
                    format_countdown_value(props.timeout - (countdown_count * countdown_pace))
                )
            )
            countdown_count = countdown_count + 1
            return (props.timeout - (countdown_count * countdown_pace) >= 0)
        end)
        countdown_timer:stop()
    end
    -- }}}

    -- content
    local content = {
        -- message
        text_container({
            text   = props.text or 'Are you sure?',
            font = props.font,
            widget = wibox.widget.textbox
        }, props.text_bg),
        spacing = 10,
        layout = wibox.layout.fixed.vertical,
    }

    -- countdown
    if countdown_textbox then
        table.insert(content, text_container(countdown_textbox, props.text_bg))
    end

    -- buttons
    table.insert(content, {
        cancel_button,
        yes_button,
        layout = wibox.layout.ratio.horizontal
    })

    local confirm_popup = awful.popup {
        widget = {
            content,
            margins = 10,
            widget  = wibox.container.margin
        },
        border_color = props.border_color,
        border_width = props.border_width,
        bg = props.bg,
        bgimage = props.bgimage,
        fg = props.fg,
        placement    = awful.placement.centered,
        shape        = gears.shape.rounded_rect,
        minimum_width = props.minimum_width,
        minimum_height = props.minimum_height,
        maxmimum_width = props.maxmimum_width,
        maximum_height = props.maximum_height,
        width = props.width,
        height = props.height,
        visible      = false,
        ontop = true,
        type = "dialog",
        screen = awful.screen.primary
    }

    local timer = nil

    local function hide_popup()
        if confirm_popup.visible then
            confirm_popup.visible = not confirm_popup.visible
        end
        if timer and timer.started then
            timer:stop()
            stop_countdown_timer()
        end
    end

    local function show_popup()
        reset_countdown_timer()
        if not confirm_popup.visible then
            confirm_popup.visible = not confirm_popup.visible
            if timer then
                timer:again()
            end
        end
    end

    local function do_confirm()
        hide_popup()
        confirm_callback()
    end

    local function do_cancel()
        hide_popup()
        cancel_callback()
    end

    function confirm_popup:show()
        show_popup()
    end

    function confirm_popup:hide()
        hide_popup()
    end

    confirm_popup:buttons(awful.util.table.join(awful.button({}, 3, function()
        do_cancel()
    end)))

    cancel_button:buttons(awful.util.table.join(awful.button({}, 1, function()
        do_cancel()
    end)))

    yes_button:buttons(awful.util.table.join(awful.button({}, 1, function()
        do_confirm()
    end)))

    if props.timeout then
        timer = gears.timer {
            timeout   = props.timeout,
            callback  = function()
                do_confirm()
            end
        }
    end

    return confirm_popup
end

return setmetatable({}, { __call = function(_, ...) return init_confirm_popup(...) end })