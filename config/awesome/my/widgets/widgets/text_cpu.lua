--- my/widgets/widgets/text_cpu.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local watch = require("awful.widget.watch")
local wibox = require("wibox")

local CMD = [[grep --max-count=1 '^cpu.' /proc/stat]]


local text_cpu_widget = {}

local function init_text_cpu_widget(args)
    local props = type(args) == "table" and args or {}

    local timeout = type(props.timeout) == "number" and props.timeout or 2

    text_cpu_widget = wibox.widget.textbox()

    local maincpu = {}
    watch(CMD, timeout, function(widget, stdout)
            local _, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
                stdout:match('(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)')

            local total = user + nice + system + idle + iowait + irq + softirq + steal

            local diff_idle = idle - tonumber(maincpu['idle_prev'] == nil and 0 or maincpu['idle_prev'])
            local diff_total = total - tonumber(maincpu['total_prev'] == nil and 0 or maincpu['total_prev'])
            local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

            maincpu['total_prev'] = total
            maincpu['idle_prev'] = idle

            widget:set_text(tonumber(string.format("%." .. (2) .. "f", diff_usage)))
        end,
        text_cpu_widget
    )

    return text_cpu_widget
end

return setmetatable(text_cpu_widget, { __call = function(_, ...) return init_text_cpu_widget(...) end })
