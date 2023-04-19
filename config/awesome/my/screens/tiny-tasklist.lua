local awful   = require("awful")
local wibox   = require("wibox")
local tag     = require("awful.tag")
local timer   = require("gears.timer")
local naughty = require("naughty")
local tasklist_popup = require("my.popups.tasklist-popup")

-- useful to debug
local function notify_now(text)
    --[[
    naughty.notify({
        title = "my.tiny-tasklist",
        text = text
    })
    --]]
end

local function create_tiny_tasklist(s, args)
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
                awful.menu.client_list(
                    { theme = { width = 300 }},
                    nil,
                    function (c)
                        return awful.widget.tasklist.filter.currenttags(c, s)
                    end
                )
            end),
            awful.button({}, 4, function()
                awful.client.focus.byidx(1)
            end),
            awful.button({}, 5, function()
                awful.client.focus.byidx(-1)
            end)
        )
    )

    local nb_clients = 0;

    local mini_tasklist_timer = nil

    local function update_text()
        local prefix = " "
        if nb_clients > 1 then prefix = " " end
        mini_textbox:set_text(prefix .. nb_clients)
        notify_now(prefix .. nb_clients)
    end

    local function _do_update(fn, nb)
        if nb_clients == nb then return end
        -- check if timer is already running
        if mini_tasklist_timer then
            if mini_tasklist_timer.started
                and nb_clients and nb
                and nb_clients == nb then
                -- already trying to update it
                return
            end
            mini_tasklist_timer:stop()
        end
        -- init variables
        mini_tasklist_timer = nil
        nb_clients = nb
        -- run timer
        mini_tasklist_timer = timer.weak_start_new(0.05, fn)
    end

    -- what is says
    local function hide_widget()
        _do_update(function()
            if mini_tasklist.visible then
                mini_tasklist.visible = not mini_tasklist.visible
                update_text()
            end
        end, 0)
    end

    -- make widget visible if nb > 0
    local function update_widget(nb)
        if nb == 0 then
            return hide_widget()
        end
        _do_update(function()
            mini_tasklist.visible = true
            update_text()
        end, nb)
    end

    local function evaluate_situation()
        local selected_tags = awful.screen.focused().selected_tags
        -- no tag selected
        if not selected_tags or #selected_tags < 1 then
            timer.delayed_call(hide_widget, "(no selected tag)")
            return
        end

        local tmp_nb_clients = 0

        for k, t in ipairs(selected_tags) do
            local clients = t:clients()
            tmp_nb_clients = tmp_nb_clients + #clients
        end

        timer.delayed_call(update_widget, tmp_nb_clients)
    end

    tag.attached_connect_signal(s, "property::selected", function()
        timer.delayed_call(evaluate_situation)
    end)

    client.connect_signal("focus", function(c)
        -- the newly focused tag is on this screen
        if c.screen.index == s.index then
            timer.delayed_call(evaluate_situation)
        end
    end)

    client.connect_signal("unfocus", function(c)
        -- the newly unfocused tag is on this screen
        if c.screen.index == s.index then
            timer.delayed_call(evaluate_situation)
        end
    end)

    return mini_tasklist
end

return {
    create_tiny_tasklist = create_tiny_tasklist
}
