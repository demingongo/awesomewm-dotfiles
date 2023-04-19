---------------------------
-- waterwork awesome theme --
---------------------------

local theme_name                                = "waterwork"

local theme_assets                              = require("beautiful.theme_assets")
local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi
local gears                                     = require("gears")
local wibox                                     = require("wibox")
local awful                                     = require("awful")

local mpris_widget                              = require("awesomewm-mpris-widget")
local calendar_widget                           = require("awesome-wm-widgets.calendar-widget.calendar")
local mytinytasklist                            = require('my.screens.tiny-tasklist')
local tasklist_popup                            = require("my.popups.tasklist-popup")

local gfs                                       = require("gears.filesystem")
local themes_path                               = gfs.get_themes_dir()

local ICONS_DIR                                 = os.getenv("HOME") .. "/.config/awesome/icons"

local COLORS                                    = {
    background = "#002b36",
    normal = "#959CB7",
    primary = "#1c71a8",
    secondary = "#3EA0C1",
    hidden = "#48616a",
    warning = "#758b0d",
    urgent = "#d43682",
    transparent = "#00000000"
}

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

local wallpapers_dir                            = theme.dir .. "/wallpapers"

theme.wallpaper_list                            = {
    wallpapers_dir .. "/water.jpg",
    wallpapers_dir .. "/filesystem.png",
}

theme.font                                      = "Terminus 13"

theme.bg_normal                                 = COLORS.background
theme.bg_focus                                  = COLORS.secondary
theme.bg_urgent                                 = COLORS.urgent
theme.bg_minimize                               = COLORS.hidden
theme.bg_systray                                = theme.bg_normal

theme.fg_normal                                 = COLORS.normal
theme.fg_focus                                  = COLORS.primary
theme.fg_urgent                                 = COLORS.urgent
theme.fg_minimize                               = theme.fg_normal

theme.useless_gap                               = dpi(6)
theme.border_radius                             = dpi(6)
theme.border_width                              = dpi(1)
theme.border_normal                             = COLORS.hidden
theme.border_focus                              = COLORS.primary
theme.border_marked                             = COLORS.warning
theme.systray_icon_spacing                      = dpi(6)

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
-- Example:
theme.taglist_fg_focus                          = COLORS.secondary
theme.taglist_fg_urgent                         = theme.fg_urgent
theme.taglist_fg_empty                          = theme.fg_normal
theme.taglist_bg_focus                          = COLORS.transparent
theme.taglist_bg_urgent                         = COLORS.transparent
theme.taglist_font                              = "Terminus 16"

theme.prompt_font                               = "Terminus 11"

theme.titlebar_bg_focus                         = theme.bg_normal
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

theme.popups_font                               = "Terminus 11"
theme.popups_timeout_font                       = theme.font
theme.popups_fg                                 = nil
theme.popups_bgimage                            = nil
theme.popups_bg                                 = nil
theme.popups_text_bg                            = theme.bg_normal
theme.popups_confirm_bg                         = theme.bg_normal
theme.popups_cancel_bg                          = theme.bg_normal
theme.popups_close_bg                           = theme.bg_normal
theme.popups_close_fg                           = theme.fg_focus
theme.popups_confirm_hover_bg                   = theme.fg_normal
theme.popups_confirm_hover_fg                   = theme.bg_normal
theme.popups_cancel_hover_bg                    = theme.fg_normal
theme.popups_cancel_hover_fg                    = theme.bg_normal
theme.popups_border_width                       = theme.border_width
theme.popups_border_color                       = theme.fg_focus
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
theme.menu_width                                = dpi(150)
theme.menu_bg_focus                             = theme.bg_focus .. "22"
theme.menu_font                                 = "Terminus 11"

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

-- Generate Awesome icon:
theme.awesome_icon                              = theme.dir .. "/icons/launcher.svg"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

-- Widgets
--
--

theme.textclock_format                          = "%R"
theme.calendar_theme                            = "naughty"
theme.calendar_start_sunday                     = false

theme.batteryarc_main_color                     = theme.fg_normal
theme.batteryarc_size                           = dpi(28)
theme.batteryarc_arc_thickness                  = dpi(3)
theme.batteryarc_notification_position          = "bottom_right"

theme.volume_widget_type                        = "icon"

theme.cpu_widget_color                          = theme.fg_normal

-- Wibar
--
--

-- Wibar properties
--

theme.wibar_position                            = "left"
theme.wibar_layout                              = wibox.layout.align.vertical
theme.wibar_width                               = dpi(36)
theme.wibar_stretch                             = true
theme.wibar_expand                              = "none"
theme.wibar_bg                                  = COLORS.transparent
theme.wibar_opacity                             = 0.9
theme.wibar_border_width                        = dpi(9)


-- Tasklist
--

local function create_tasklist(args, s)
    return mytinytasklist.create_tiny_tasklist(s, {
        popup = tasklist_popup.create_tasklist_popup(s, {
            close_button_text = "  "
        })
    })
end

theme.create_tasklist = create_tasklist


-- Taglist
--

theme.taglist_tags = { " ", " ", " ", " ", " ", " ", " " } -- tags 8 and 9: " ", " "

local function taglist_update_callback(widget, t, idx)
    if t.activated and #t:clients() > 0 then
        t.name = " "
    elseif t.name ~= theme.taglist_tags[idx] then
        t.name = theme.taglist_tags[idx];
    end
end

theme.taglist_template = {
    {
        {
            id = "text_role",
            widget = wibox.widget.textbox
        },
        right  = 8,
        widget = wibox.container.margin
    },
    id              = 'background_role',
    widget          = wibox.container.background,
    create_callback = taglist_update_callback,
    update_callback = taglist_update_callback
}


-- Left widgets / Top widgets
--

---comment
---@param screen any
---@return table
local function create_left_widgets(screen)
    return {
        widget = wibox.container.place,
        screen.mytasklist
    }
end

theme.create_left_widgets = create_left_widgets


-- Right widgets / Bottom widgets
--

---comment
---@param screen any
---@param widgets { load: function }
---@return table
local function create_right_widgets(screen, widgets)
    local systray = widgets:load("toggable_systray", {
        toggle_side = "right",
        text_icon_show = " 󰏝 ",
        text_icon_hide = " 󰏝 ",
        no_tooltip = true,
        hidden_at_start = true,
        margin_bottom = dpi(6),
        margin_top = dpi(6)
    })

    return {
        systray,
        direction = 'west',
        widget = wibox.container.rotate
    }
end

theme.create_right_widgets = create_right_widgets


-- Middle widgets
--

---comment
---@param s any
---@param widgets { load: function }
---@return table
theme.create_middle_widgets = function(s, widgets)
    local media_player = mpris_widget({
        state_playing = "",
        state_paused = "󰏤",
        display = "icon",
        --icon_width = dpi(26),
        popup_font = "Terminus 10",
        --[[
        media_icons = {
            musikcube = theme.dir .. "/icons/mpris/musikcube-neon.png",
            rhythmbox = theme.dir .. "/icons/clients/rhythmbox-neon.png",
            spotify = theme.dir .. "/icons/clients/spotify-neon.png",
            firefox = theme.dir .. "/icons/mpris/firefox-neon-2.png",
        },
        --]]
        max_chars = -1,
        popup_maximum_width = dpi(400)
    })
    local media_player_container = wibox.widget {
        media_player,
        widget = wibox.container.place
    }
    media_player_container:buttons(
        awful.util.table.join(
            awful.button({}, 4, function() media_player:next() end),
            awful.button({}, 5, function() media_player:previous() end)
        )
    )

    local clock_widget = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        {
            widget = wibox.container.place,
            wibox.widget {
                format = '%I',
                widget = wibox.widget.textclock
            }
        },
        {
            widget = wibox.container.place,
            wibox.widget {
                format = '%M',
                widget = wibox.widget.textclock
            },
        },
        {
            widget = wibox.container.place,
            wibox.widget {
                format = '%p',
                widget = wibox.widget.textclock
            }
        }
    }
    -- Calendar widget
    local calendar_widget = calendar_widget({
        theme = "naughty",
        placement = "bottom_right",
        start_sunday = false,
        radius = dpi(8),
        previous_month_button = 5,
        next_month_button = 4
    })
    clock_widget:connect_signal("button::press",
        function(_, _, _, button)
            if button == 1 then calendar_widget.toggle() end
        end)

    return {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(20),
        {
            s.mytaglist,
            direction = 'east',
            widget = wibox.container.rotate
        },
        media_player_container,
        widgets:load('battery_widget'),
        widgets:load('volume_widget'),
        {
            widget = wibox.container.place,
            clock_widget,
        },
        widgets:load("launcher")
    }
end


theme.autostart_shell_cmds = {
    --os.getenv("HOME") .. "/.local/bin/spice_on_rice Dreary Deeper"
}

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
