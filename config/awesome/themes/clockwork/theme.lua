---------------------------
-- clockwork awesome theme --
---------------------------

local theme_name                                = "clockwork"

local theme_assets                              = require("beautiful.theme_assets")
local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi
local gears                                     = require("gears")
local wibox                                     = require("wibox")
local awful                                     = require("awful")

local mpris_widget                              = require("awesomewm-mpris-widget")
local mytinytasklist                            = require('my.screens.tiny-tasklist')
local tasklist_popup                            = require("my.popups.tasklist-popup")

local gfs                                       = require("gears.filesystem")
local themes_path                               = gfs.get_themes_dir()

local ICONS_DIR                                 = os.getenv("HOME") .. "/.config/awesome/icons"

local NEON_COLORS = {
    yellow = "#FDFF00",
    light_green = "#9CFF2E",
    green = "#38E54D",
    blue = "#2192FF",
    purple = "#9254C8",
    light_purple = "#E15FED",
    cyan = "#6EDCD9",
    pink = "#F900BF",
    light_pink = "#FF85B3"
}

local COLORS = {
    background = "#1e1e2e",
    hidden = "#817868"
}

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

theme.terminal                                  = "kitty --config " .. theme.dir .. "/config/kitty.conf"

local wallpapers_dir                            = theme.dir .. "/wallpapers"

theme.wallpaper_list = {
    wallpapers_dir .. "/cyberpunk.jpg",
    wallpapers_dir .. "/akira.png",
}

theme.font                                      = "Commodore 64 Rounded 12"

theme.bg_normal                                 = COLORS.background
theme.bg_focus                                  = NEON_COLORS.green
theme.bg_urgent                                 = NEON_COLORS.blue
theme.bg_minimize                               = COLORS.background
theme.bg_systray                                = theme.bg_normal

theme.fg_normal                                 = NEON_COLORS.light_green
theme.fg_focus                                  = COLORS.background
theme.fg_urgent                                 = NEON_COLORS.pink
theme.fg_minimize                               = COLORS.hidden

theme.useless_gap                               = dpi(1)
theme.border_radius                             = dpi(1)
theme.border_width                              = dpi(6)
theme.border_normal                             = COLORS.background
theme.border_focus                              = COLORS.background
theme.border_marked                             = NEON_COLORS.pink
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
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.taglist_fg_focus                          = COLORS.background
theme.taglist_fg_urgent                         = theme.fg_urgent
theme.taglist_fg_empty                          = NEON_COLORS.light_pink
theme.taglist_bg_focus                          = NEON_COLORS.light_green
theme.taglist_font                              = theme.font

theme.tasklist_disable_icon                     = true
theme.tasklist_disable_task_name                = false
theme.tasklist_bg_focus                         = theme.bg_focus
theme.tasklist_max_width                        = dpi(1600 - 6) -- resolution width minus gaps

theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

theme.hotkeys_modifiers_fg                      = NEON_COLORS.light_pink

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
theme.menu_width                                = dpi(220)
theme.menu_fg_normal                            = NEON_COLORS.green

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
theme.clients_default_icon                      = theme.dir .. "/icons/clients/chip-circuit-256.png"
theme.clients_icons                             = {
    ["Spotify"] = theme.dir .. "/icons/clients/spotify-neon.png",
    ["kitty"] = theme.dir .. "/icons/clients/kitty.svg",
    ["firefox"] = theme.dir .. "/icons/clients/firefox-neon.png",
    ["org.gnome.Nautilus"] = theme.dir .. "/icons/clients/folder.svg",
    ["Rhythmbox"] = theme.dir .. "/icons/clients/rhythmbox-neon.png",
}

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

-- Define layouts
theme.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    awful.layout.suit.corner.se,
}

-- Widgets
--

theme.textclock_format                          = "%A  |  %Y-%m-%d  |  %R"
theme.calendar_theme                            = "naughty"
theme.calendar_start_sunday                     = false

theme.batteryarc_main_color                     = NEON_COLORS.blue

local function create_media_player_widget()
    local media_player = nil

    -- mpris widget args
    local mpris_widget_max_width = dpi(180)
    local mpris_widget_args = {
        state_playing = "",
        state_paused = "󰏤",
        --display = "icon_text",
        --icon_width = dpi(26),
        font = "Commodore 64 Angled 12",
        media_icons = {
            musikcube = theme.dir .. "/icons/mpris/musikcube-neon.png",
            rhythmbox = theme.dir .. "/icons/clients/rhythmbox-neon.png",
            spotify = theme.dir .. "/icons/clients/spotify-neon.png",
            firefox = theme.dir .. "/icons/mpris/firefox-neon-2.png",
        },
        max_chars = -1,
        scroll = {
            enabled = true,
            orientation = "horizontal",
            max_size = mpris_widget_max_width
        },
        popup_maximum_width = dpi(400)
    }

    -- Controls
    local previous_button = wibox.widget.textbox("󰒮 ")
    previous_button.font = "Commodore 64 Angled 15"
    previous_button.visible = false
    previous_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            media_player:previous()
        end
    end)
    local next_button = wibox.widget.textbox(" 󰒭 ")
    next_button.font = "Commodore 64 Angled 15"
    next_button.visible = false
    next_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            media_player:next()
        end
    end)

    -- Events
    mpris_widget_args.clients_running = function()
        if not previous_button.visible then
            previous_button.visible = not previous_button.visible
        end
        if not next_button.visible then
            next_button.visible = not next_button.visible
        end
    end
    mpris_widget_args.all_clients_closed = function()
        if previous_button.visible then
            previous_button.visible = not previous_button.visible
        end
        if next_button.visible then
            next_button.visible = not next_button.visible
        end
    end

    ---mpris widget
    media_player = mpris_widget(mpris_widget_args)

    return {
        layout = wibox.layout.fixed.horizontal,
        previous_button,
        {
            media_player,
            forced_width = mpris_widget_max_width,
            widget = wibox.container.constraint
        },
        next_button
    }
end

-- Wibar
--
--

-- Left widgets
--

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
        left   = dpi(12),
        right  = dpi(12),
        widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background
}


local function create_left_widgets(_, widgets, w_taglist, w_promptbox)
    return {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    w_taglist,
                    w_promptbox
                },
                right = dpi(15),
                widget = wibox.container.margin
            },
            bg = theme.bg_normal,
            id = "background_role",
            widget = wibox.container.background
        }
    }
end

theme.create_left_widgets = create_left_widgets


-- Right widgets
--

---comment
---@param screen any
---@param widgets { load: function }
---@param w_layoutbox table
---@return table
local function create_right_widgets(screen, widgets, w_layoutbox)
    -- separator
    local spr = {
        wibox.widget.textbox('|'),
        fg = theme.taglist_fg_empty,
        widget = wibox.container.background
    }

    local systray = widgets:load("toggable_systray", {
        toggle_side = "right",
        no_tooltip = true,
        margin_bottom = dpi(9),
        margin_top = dpi(9),
        margin_right = dpi(10)
    })

    screen.mytinytasklist = mytinytasklist.create_tiny_tasklist(screen, {
        popup = tasklist_popup.create_tasklist_popup(screen, {
            close_button_text= ""
        }),
        create_widget = function(textbox)
            return wibox.widget {
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(20),
                    spr,
                    textbox
                },
                widget = wibox.container.background,
            }
        end
    })

    return {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(20),
                    screen.mytinytasklist,
                    spr,
                    widgets:load('volume_widget'),
                    spr,
                    widgets:load('battery_widget'),
                    spr,
                    systray
                },
                left = dpi(15),
                right = dpi(15),
                widget = wibox.container.margin
            },
            bg = theme.bg_normal,
            id = "background_role",
            widget = wibox.container.background
        }
    }
end

theme.create_right_widgets = create_right_widgets

-- Wibar
--

-- Wibar properties
theme.wibar_position = "bottom"
theme.wibar_height = dpi(34)
theme.wibar_expand = "none"
theme.wibar_bg = theme.bg_normal
theme.wibar_opacity = 1

---Returns the argument for wibar:setup
local function setup_wibar(s, layout, left_side, middle_side, right_side, widgets)
    local empty_widget = wibox.widget.textbox('')

    local media_player_widget = create_media_player_widget()

    table.insert(layout, left_side)
    table.insert(layout, {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                media_player_widget,
                left = dpi(15),
                right = dpi(15),
                widget = wibox.container.margin
            },
            bg = theme.bg_normal,
            id = "background_role",
            widget = wibox.container.background
        }
    })
    table.insert(layout, right_side)

    -- add second wibar
    s.mytopwibox = awful.wibar({
        screen = s,
        position = "top",
        bg = theme.bg_normal .. "44"
    })

    s.mytopwibox:setup({
        layout = wibox.layout.ratio.horizontal,
        -- left
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            widgets:load("launcher")
        },
        -- middle
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            empty_widget,
            {
                widgets:load('textclock'),
                fg = NEON_COLORS.blue,
                widget = wibox.container.background
            },
            empty_widget
        },
        -- right
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            empty_widget,
            {
                {
                    {
                        layout = wibox.layout.fixed.horizontal,
                        widgets:load('text_cpu_widget', { timeout = 4 }),
                        wibox.widget.textbox('%')
                    },
                    fg = NEON_COLORS.blue,
                    widget = wibox.container.background
                },
                forced_width = dpi(80),
                widget = wibox.container.constraint
            },
            empty_widget
        }
    })
    s.mytopwibox.widget:ajust_ratio(2, 0.05, 0.89, 0.06)

    return layout;
end

theme.setup_wibar = setup_wibar


-- Clients
--
--


theme.additional_rules = {
    {
        rule_any = { type = { "normal", "dialog" }
        },
        except_any = {
            class = { "Eog", "org.gnome.Nautilus" },
        },
        properties = { titlebars_enabled = true }
    },
}

theme.autostart_shell_cmds = {
    --os.getenv("HOME") .. "/.local/bin/spice_on_rice Glaze Blase"
}

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
