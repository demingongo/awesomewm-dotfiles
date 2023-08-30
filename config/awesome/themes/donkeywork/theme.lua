---------------------------
-- donkeywork awesome theme --
---------------------------

local theme_name                                = "donkeywork"

local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi
local gears                                     = require("gears")
local wibox                                     = require("wibox")
local awful                                     = require("awful")

local mpris_widget                              = require("awesomewm-mpris-widget")
local myminitasklist                            = require('my.screens.mini-tasklist')
local tasklist_popup                            = require("my.popups.tasklist-popup")

local gfs                                       = require("gears.filesystem")
local themes_path                               = gfs.get_themes_dir()

local ICONS_DIR                                 = os.getenv("HOME") .. "/.config/awesome/icons"

local COLORS                                    = {
    background = "#000000",
    background_2 = "#6e6a86",
    red = "#dc0500",
    blue = "#3e8fb0",
    yellow = "#e6e406",
    light_blue = "#9ccfd8",
    purple = "#c4a7e7",
    light_red = "#ebbcba",
    white = "#ffffff",
    orange = "#e66b1e",
    transparent = "#00000000"
}

local GAPS_VALUE = dpi(6)
local BORDER_RADIUS = dpi(0)

local function wrap_widget(widget, bg, h_margin, v_margin, border_width, border_color)
    return wibox.widget {
        {
            {
                wibox.widget.textbox(''),
                widget,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            left   = h_margin,
            right  = h_margin,
            top    = v_margin,
            bottom = v_margin,
            widget = wibox.container.margin
        },
        bg                 = bg or COLORS.transparent,
        shape_border_color = border_color or COLORS.transparent,
        shape_border_width = border_width or dpi(1),
        shape              = function(cr, width, height)
            return gears.shape.rounded_rect(cr, width, height, BORDER_RADIUS)
        end,
        widget             = wibox.widget.background
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

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

theme.terminal                                  = "kitty --config " .. theme.dir .. "/config/kitty.conf"

local wallpapers_dir                            = theme.dir .. "/wallpapers"

theme.wallpaper_list                            = {
    COLORS.background,
    COLORS.white,
    wallpapers_dir .. "/Undertale-sans.png",
    wallpapers_dir .. "/409593.jpg"
}

theme.font                                      = "Commodore 64 9"

theme.bg_normal                                 = COLORS.background
theme.bg_focus                                  = COLORS.background
theme.bg_urgent                                 = COLORS.red
theme.bg_minimize                               = COLORS.background_2
theme.bg_systray                                = COLORS.background

theme.fg_normal                                 = COLORS.white
theme.fg_focus                                  = COLORS.light_blue
theme.fg_urgent                                 = COLORS.white
theme.fg_minimize                               = COLORS.white

theme.useless_gap                               = GAPS_VALUE
theme.border_radius                             = BORDER_RADIUS
theme.border_width                              = dpi(4)
theme.border_normal                             = COLORS.white
theme.border_focus                              = COLORS.yellow
theme.border_marked                             = COLORS.orange
theme.systray_icon_spacing                      = dpi(10)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.taglist_fg_focus                          = COLORS.yellow
theme.taglist_fg_urgent                         = COLORS.orange
theme.taglist_fg_occupied                       = COLORS.red
theme.taglist_fg_empty                          = COLORS.red
theme.taglist_fg_volatile                       = COLORS.red
theme.taglist_bg_focus                          = COLORS.transparent
theme.taglist_bg_urgent                         = COLORS.transparent
theme.taglist_font                              = "Hack Nerd Font Bold 12"

theme.tasklist_disable_icon                     = false
theme.tasklist_disable_task_name                = false
theme.tasklist_fg_normal                        = COLORS.orange
theme.tasklist_fg_focus                         = COLORS.yellow
theme.tasklist_fg_urgent                        = COLORS.red
theme.tasklist_fg_minimize                      = COLORS.background_2
theme.tasklist_bg_normal                        = COLORS.transparent
theme.tasklist_bg_focus                         = COLORS.transparent
theme.tasklist_bg_urgent                        = COLORS.transparent
theme.tasklist_bg_minimize                      = COLORS.transparent
theme.tasklist_shape_border_color               = COLORS.orange
theme.tasklist_shape_border_color_focus         = COLORS.yellow
theme.tasklist_shape_border_color_urgent        = COLORS.red
theme.tasklist_shape_border_color_minimized     = COLORS.background_2
theme.tasklist_shape_border_width               = dpi(2)
theme.tasklist_shape                            = function(cr, width, height)
    return gears.shape.rounded_rect(cr, width, height, BORDER_RADIUS)
end

theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.titlebar_extra_args                       = { position = 'left', size = dpi(25) }

theme.prompt_bg                                 = COLORS.background
theme.prompt_bg_cursor                          = COLORS.yellow

theme.hotkeys_modifiers_fg                      = theme.fg_normal

theme.popups_font                               = "Commodore 64 9"
theme.popups_timeout_font                       = theme.font
theme.popups_fg                                 = nil
theme.popups_bgimage                            = nil
theme.popups_bg                                 = nil
theme.popups_text_bg                            = theme.bg_normal
theme.popups_confirm_bg                         = theme.bg_normal
theme.popups_cancel_bg                          = theme.bg_normal
theme.popups_confirm_hover_bg                   = theme.fg_normal
theme.popups_confirm_hover_fg                   = theme.bg_normal
theme.popups_cancel_hover_bg                    = theme.fg_normal
theme.popups_cancel_hover_fg                    = theme.bg_normal
theme.popups_border_width                       = theme.border_width
theme.popups_border_color                       = theme.border_focus
theme.popups_minimum_width                      = dpi(300)
theme.popups_minimum_height                     = nil
theme.popups_maxmimum_width                     = dpi(300)
theme.popups_maximum_height                     = nil
theme.popups_width                              = nil
theme.popups_height                             = nil

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.menu_height                               = dpi(22)
theme.menu_width                                = dpi(200)

-- Define the image to load
theme.titlebar_close_button_normal              = ICONS_DIR .. "/titlebar/copycats/close_normal.png"
theme.titlebar_close_button_focus               = ICONS_DIR .. "/titlebar/copycats/close_focus.png"

theme.titlebar_minimize_button_normal           = ICONS_DIR .. "/titlebar/copycats/minimize_normal.png"
theme.titlebar_minimize_button_focus            = ICONS_DIR .. "/titlebar/copycats/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = ICONS_DIR .. "/titlebar/copycats/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = ICONS_DIR .. "/titlebar/copycats/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = ICONS_DIR .. "/titlebar/copycats/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = ICONS_DIR .. "/titlebar/copycats/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = ICONS_DIR .. "/titlebar/copycats/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = ICONS_DIR .. "/titlebar/copycats/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = ICONS_DIR .. "/titlebar/copycats/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = ICONS_DIR .. "/titlebar/copycats/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = ICONS_DIR .. "/titlebar/copycats/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = ICONS_DIR .. "/titlebar/copycats/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = ICONS_DIR .. "/titlebar/copycats/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = ICONS_DIR .. "/titlebar/copycats/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = ICONS_DIR .. "/titlebar/copycats/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = ICONS_DIR .. "/titlebar/copycats/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = ICONS_DIR .. "/titlebar/copycats/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = ICONS_DIR .. "/titlebar/copycats/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairv                              = ICONS_DIR .. "/layouts/fairv.png"
theme.layout_fairh                              = ICONS_DIR .. "/layouts/fairh.png"
theme.layout_max                                = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen                         = themes_path .. "defaults/layout/fullscreenw.png"
theme.layout_magnifier                          = themes_path .. "default/layouts/magnifierw.png"
theme.layout_floating                           = ICONS_DIR .. "/layouts/floating.png"
theme.layout_tile                               = ICONS_DIR .. "/layouts/tile.png"
theme.layout_tileleft                           = ICONS_DIR .. "/layouts/tileleft.png"
theme.layout_tilebottom                         = ICONS_DIR .. "/layouts/tilebottom.png"
theme.layout_tiletop                            = ICONS_DIR .. "/layouts/tiletop.png"
theme.layout_spiral                             = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle                            = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw                           = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne                           = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw                           = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse                           = themes_path .. "default/layouts/cornersew.png"

-- Client icons used in tasklist
theme.clients_default_icon                      = theme.dir .. "/icons/clients/undertale-flowey.svg"
theme.clients_icons                             = {
    ["Spotify"] = theme.dir .. "/icons/clients/undertale-flowey-up-orange.svg",
    ["rhythmbox"] = theme.dir .. "/icons/clients/rhythmbox.svg",
    ["kitty"] = theme.dir .. "/icons/clients/undertale-flowey-orange.svg",
    ["firefox"] = theme.dir .. "/icons/clients/undertale-papyrus.svg"
}
theme.clients_focused_icons                             = {
    ["Spotify"] = theme.dir .. "/icons/clients/undertale-flowey-up-yellow.svg",
    ["kitty"] = theme.dir .. "/icons/clients/undertale-flowey-yellow.svg",
}

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

-- Widgets
--
--

theme.textclock_format                          = "%R"
theme.calendar_theme                            = "naughty"
theme.calendar_start_sunday                     = false

theme.volume_widget_type                        = "icon"

theme.batteryarc_main_color                     = theme.fg_normal

theme.cpu_widget_color                          = theme.fg_normal

theme.create_promptbox                          = function()
    local mypromptbox              = awful.widget.prompt()
    mypromptbox.prompt             = " " .. mypromptbox.prompt
    mypromptbox.bg                 = theme.prompt_bg
    mypromptbox.shape_border_color = COLORS.background
    mypromptbox.shape_border_width = 1
    mypromptbox.shape              = function(cr, width, height)
        return gears.shape.rounded_rect(cr, width, height, dpi(6))
    end
    return mypromptbox
end

local function create_media_player_widget()
    local media_player = nil
    local media_player_container = nil

    -- mpris widget args
    local mpris_widget_max_width = dpi(140)
    local mpris_widget_args = {
        state_playing = "",
        --font = "Purple Smile 12",
        media_icons = {
            musikcube = theme.dir .. "/icons/clients/musikcube.png",
            rhythmbox = theme.dir .. "/icons/clients/rhythmbox.svg",
            spotify = theme.dir .. "/icons/clients/undertale-flowey-up.svg",
            firefox = theme.dir .. "/icons/clients/undertale-papyrus.svg"
        },
        max_chars = -1,
        scroll = {
            enabled = true,
            orientation = "vertical",
            margin_bottom = dpi(8),
            margin_top = dpi(10),
            max_size = mpris_widget_max_width
        },
        popup_maximum_width = dpi(400)
    }

    -- Controls
    local previous_button = wibox.widget.textbox("󰒫 ")
    previous_button.font = "Commodore 64 9"
    previous_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            media_player:previous()
        end
    end)
    format_button(previous_button)
    local next_button = wibox.widget.textbox(" 󰒬 ")
    next_button.font = "Commodore 64 9"
    next_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            media_player:next()
        end
    end)
    format_button(next_button)

    -- Events
    mpris_widget_args.clients_running = function()
        if not media_player_container.visible then
            media_player_container.visible = not media_player_container.visible
        end
    end
    mpris_widget_args.all_clients_closed = function()
        if media_player_container.visible then
            media_player_container.visible = not media_player_container.visible
        end
    end

    ---mpris widget
    media_player = mpris_widget(mpris_widget_args)

    media_player_container = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        previous_button,
        {
            media_player,
            forced_width = mpris_widget_max_width,
            widget = wibox.container.constraint
        },
        next_button
    }

    return media_player_container
end

-- Wibar
--
--

-- Wibar properties
--

-- Wibar properties
theme.wibar_position                            = "top"
theme.wibar_height                              = dpi(36)
theme.wibar_expand                              = "none"
theme.wibar_bg                                  = "#00000000" -- transparent
theme.wibar_opacity                             = 1
theme.wibar_border_width                        = dpi(0)

-- Tasklist
--
theme.tasklist_max_width                        = dpi(1600 - (GAPS_VALUE * 4))
local function create_tasklist(args, s)

    args.layout = {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(20)
    }

    args.widget_template = {
        {
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox
                    },
                    margins = dpi(6),
                    widget = wibox.container.margin
                },
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal
            },
            left = dpi(15),
            right = dpi(15),
            widget = wibox.container.margin
        },
        id = "background_role",
        widget = wibox.container.background,
        update_callback = function(self, c, index, objects)
            if c._client_icon and c._client_focused_icon then
                local changed_icon = c._client_icon
                if c == client.focus then
                    changed_icon = c._client_focused_icon
                end

                -- change taskbar's icon
                -- The reason why I don't change client's icon is because
                -- it is extremely heavy. Memory load keeps increasing
                gears.timer ({
                    callback = function()
                        self:get_children_by_id('icon_role')[1].image = changed_icon
                    end,
                    timeout = 0.1,
                    autostart = true,
                    single_shot = true
                })
            end
        end,
    }

    return awful.widget.tasklist(args)
end

theme.create_tasklist = create_tasklist

-- Left widgets
--

-- Taglist
-- nf-weather-moon_alt
theme.taglist_tags = { "󰋔 ", "󰋔 ", "󰋔 ", "󰋔 ", "󰋔 ", "󰋔 ", "󰋔 " } -- tags 8 and 9: " ", " "

local function taglist_update_callback(widget, t, idx)
    if t.activated and #t:clients() > 0 then
        t.name = "󰣐 "
    elseif t.name ~= theme.taglist_tags[idx] then
        t.name = theme.taglist_tags[idx];
    end
end
-- Taglist widget template
theme.taglist_template = {
    {
        {
            layout = wibox.layout.fixed.horizontal,
            {
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                margins = dpi(1),
                widget = wibox.container.margin
            },
        },
        left   = 8,
        right  = 0,
        widget = wibox.container.margin
    },
    id              = 'background_role',
    widget          = wibox.container.background,
    create_callback = taglist_update_callback,
    update_callback = taglist_update_callback
}

local wrap_top_widget = function (widget)
    return {
        widget = wibox.container.place,
        {
            widget,
            top = GAPS_VALUE,
            left = GAPS_VALUE * 2,
            right = GAPS_VALUE * 2,
            widget = wibox.container.margin
        }
    }
end

---comment
---@param screen any
---@param widgets any
---@param w_taglist table
---@param w_promptbox table
---@return table
local function create_left_widgets(screen, widgets, w_taglist, w_promptbox)
    local my_tasklist_popup = tasklist_popup.create_tasklist_popup(screen, {
        close_button_text= ""
    })

    screen.myminitasklist = wibox.widget({
        myminitasklist.create_mini_tasklist(screen, {
            popup = my_tasklist_popup,
            create_widget = function(textbox)
                return wrap_widget({
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                            {
                                {
                                    textbox,
                                    width = dpi(200), -- max width
                                    widget = wibox.container.constraint
                                },
                                margins = dpi(1), -- margins
                                widget = wibox.container.margin
                            },
                        },
                        -- h margins
                        left   = 8,
                        right  = 8,
                        widget = wibox.container.margin
                    },
                    id     = 'background_role',
                    widget = wibox.container.background,
                })
            end
        }),
        widget = wibox.container.background
    })
    screen.myminitasklist.visible = false

    return wrap_top_widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = GAPS_VALUE,
        screen.myminitasklist,
        w_promptbox
    })
end

theme.create_left_widgets = create_left_widgets



-- Right widgets
--

---comment
---@param screen any
---@param widgets { load: function }
---@return table
local function create_right_widgets(screen, widgets)
    local systray = wibox.widget.systray(false)

    local widgets_container = wrap_widget({
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(20),
            widgets:load('volume_widget'),
            create_media_player_widget(),
            wibox.widget {
                {
                    -- vertical align center
                    systray,
                    widget = wibox.container.place
                },
                top = dpi(6),
                bottom = dpi(6),
                widget = wibox.container.margin
            },
            widgets:load('textclock'),
            widgets:load('battery_widget')
        },
        left = dpi(15),
        right = dpi(10),
        widget = wibox.container.margin
    })
    widgets_container.visible = false

    local chevron = wibox.widget.textbox('󰄽 ')
    chevron.font = 'Commodore 64 18'
    format_button(chevron);
    chevron:connect_signal("button::release", function(_, _, _, button)
        if button == 1 then
            widgets_container.visible = not widgets_container.visible
            if widgets_container.visible then
                screen.myminitasklist.visible = true
                chevron.text = '󰄾 '
            else
                screen.myminitasklist.visible = false
                chevron.text = '󰄽 '
            end
        end
    end)

    return wrap_top_widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = GAPS_VALUE,
        widgets_container,
        chevron
    })
end

theme.create_right_widgets = create_right_widgets


-- Middle widgets
--

---comment
---@return table
theme.create_middle_widgets = function(s)
    return wrap_top_widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = GAPS_VALUE,
        wrap_widget(s.mytaglist, nil, nil, GAPS_VALUE)
    })
end

---Return args for wibar:setup
local function setup_wibar(s, layout, left_side, middle_side, right_side)
    table.insert(layout, left_side)
    table.insert(layout, middle_side)
    table.insert(layout, right_side)

    -- add second wibar
    s.mybottomwibox = awful.wibar({
        screen = s,
        position = "bottom",
        height = theme.wibar_height + GAPS_VALUE
    })

    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = theme.wibar_expand,
        {
            layout = wibox.layout.fixed.horizontal
        },
        wibox.container.constraint(
            wibox.widget {
                widget = wibox.container.margin,
                bottom = GAPS_VALUE,
                s.mytasklist
            },
            "max",
            theme.tasklist_max_width
        ),
        {
            layout = wibox.layout.fixed.horizontal
        }
    }

    return layout;
end

theme.setup_wibar = setup_wibar

theme.autostart_shell_cmds = {
    os.getenv("HOME") .. "/.local/bin/spice_on_rice Glaze Blase"
}

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
