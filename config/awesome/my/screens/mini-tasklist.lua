local awful          = require("awful")
local wibox          = require("wibox")
local tag            = require("awful.tag")
local timer          = require("gears.timer")
local naughty        = require("naughty")
local tasklist_popup = require("my.popups.tasklist-popup")

-- useful to debug
local function notify_now(text)
    --[[
    naughty.notify({
        title = "my.mini-tasklist",
        text = text
    })
    --]]
end

local function create_mini_tasklist(s, args)
    local props = type(args) == "table" and args or {}

    local t_popup = props.popup or tasklist_popup.create_tasklist_popup(s)

    local mini_textbox = wibox.widget.textbox('')

    local mini_tasklist = type(props.create_widget) == "function" and props.create_widget(mini_textbox) or mini_textbox
    mini_tasklist.visible = false

    mini_tasklist:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                if t_popup then
                    t_popup.visible = not t_popup.visible
                end
            end),
            awful.button({}, 3, function()
                awful.menu.client_list({ theme = { width = 250 } })
            end),
            awful.button({}, 4, function()
                awful.client.focus.byidx(1)
            end),
            awful.button({}, 5, function()
                awful.client.focus.byidx(-1)
            end)
        )
    )

    local current_client = nil

    local current_text = ""

    local mini_tasklist_timer = nil

    local function update_text()
        if current_text == current_client.name then
            return
        end
        current_text = current_client.name
        mini_textbox:set_text(current_text or "")
        notify_now(current_text or "MISSING TEXT")
    end

    local function empty_text()
        current_text = ""
        mini_textbox:set_text(current_text)
        notify_now("empty_text")
    end

    local function _do_update(fn, c)
        -- check if timer is already running
        if mini_tasklist_timer then
            if mini_tasklist_timer.started
                and current_client and c
                and current_client.name ~= c.name then
                -- already trying to update it
                return
            end
            mini_tasklist_timer:stop()
        end
        -- init variables
        mini_tasklist_timer = nil
        current_client = c -- client or nil
        -- run timer
        mini_tasklist_timer = timer.weak_start_new(0.05, fn)
    end

    -- make widget visible
    local function update_widget(c)
        _do_update(function()
            mini_tasklist.visible = true
            update_text()
            current_client:connect_signal("property::name", update_text)
        end, c)
    end

    -- what is says
    local function hide_widget()
        if current_client then
            current_client:disconnect_signal("property::name", update_text)
        end
        current_client = nil
        _do_update(function()
            if mini_tasklist.visible then
                mini_tasklist.visible = not mini_tasklist.visible
                empty_text()
            end
        end, nil)
    end

    tag.attached_connect_signal(s, "property::selected", function()
        local t = awful.screen.focused().selected_tag
        -- no tag selected
        if not t then
            timer.delayed_call(hide_widget, "(no selected tag)")
            return
        end

        local clients = t:clients()
        -- no client in selected tag
        if not clients or #clients < 1 then
            timer.delayed_call(hide_widget, "(no clients in selected tag)")
            return
        end

        -- found selected tag and its clients

        -- check if there is a focused client
        local focused_c = client.focus
        if focused_c then
            -- TODO: check if focused client has selected tag
            timer.delayed_call(update_widget, focused_c)
        else
            timer.delayed_call(hide_widget, "(no focused client)")
        end
    end)

    client.connect_signal("focus", function(c)
        -- the newly focused tag is on this screen
        if c.screen.index == s.index then
            timer.delayed_call(update_widget, c)
        end
    end)

    client.connect_signal("unfocus", function(c)
        -- the newly focused tag is on this screen
        if c.screen.index == s.index then
            timer.delayed_call(hide_widget)
        end
    end)

    return mini_tasklist
end

return {
    create_mini_tasklist = create_mini_tasklist
}
