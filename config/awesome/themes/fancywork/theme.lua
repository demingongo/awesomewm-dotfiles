---------------------------
-- fancywork awesome theme --
---------------------------

local theme_name                                = "fancywork"

local beautiful                                 = require("beautiful")
local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi
local gears                                     = require("gears")
local wibox                                     = require("wibox")
local awful                                     = require("awful")

local markup                                    = require("lain").util.markup
local mpris_widget                              = require("awesomewm-mpris-widget")
local myminitasklist                            = require('my.screens.mini-tasklist')
local tasklist_popup                            = require("my.popups.tasklist-popup")

local gfs                                       = require("gears.filesystem")
local themes_path                               = gfs.get_themes_dir()

local ICONS_DIR                                 = os.getenv("HOME") .. "/.config/awesome/icons"

local COLORS                                    = {
    purple = "#cdb4db",
    pink = "#ffafcc",
    light_pink = "#ffc8dd",
    blue = "#a2d2ff",
    blue_2 = "#cedde2",
    light_blue = "#bde0fe",

    background = "#ffffff",
    normal = "#959CB7",
    primary = "#1c71a8",
    secondary = "#3EA0C1",
    hidden = "#48616a",
    warning = "#758b0d",
    urgent = "#d43682",
    transparent = "#00000000"
}

local function wrap_widget(widget, bg, h_margin)
    return wibox.widget {
        {
            {
                wibox.widget.base.empty_widget(),
                widget,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            left   = h_margin,
            right  = h_margin,
            --top    = 5,
            --bottom = 5,
            widget = wibox.container.margin
        },
        bg                 = bg or COLORS.background,
        shape_border_color = COLORS.background,
        shape_border_width = 1,
        shape              = gears.shape.rounded_bar,
        widget             = wibox.widget.background
    }
end

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

theme.terminal                                  = "kitty --config " .. theme.dir .. "/config/kitty.conf"

local wallpapers_dir                            = theme.dir .. "/wallpapers"

local wallpaper_list = {
    {
        wallpaper = wallpapers_dir .. "/pastel-purple-background.jpg",
        action = function(s)
            beautiful.taglist_fg_empty = COLORS.normal
            beautiful.taglist_fg_occupied = COLORS.pink

            -- trick to refresh taglist
            local tag = s.selected_tag
            if tag then
                awful.tag.viewtoggle(tag)
                awful.tag.viewtoggle(tag)
            end
        end
    },
    {
        wallpaper = wallpapers_dir .. "/lava-design.jpg",
        action = function(s)
            beautiful.taglist_fg_empty = COLORS.background
            beautiful.taglist_fg_occupied = COLORS.normal

            -- trick to refresh taglist
            local tag = s.selected_tag
            if tag then
                awful.tag.viewtoggle(tag)
                awful.tag.viewtoggle(tag)
            end
        end
    },
    {
        wallpaper = wallpapers_dir .. "/lava-design-2.jpg",
        action = function(s)
            beautiful.taglist_fg_empty = COLORS.background
            beautiful.taglist_fg_occupied = COLORS.normal
        end
    }
}

---comment
---@param s any screen
---@return string | nil
theme.wallpaper = function (s)
    s.current_wallpaper_index = s.current_wallpaper_index or 0
    local current_wallpaper_index = s.current_wallpaper_index
    current_wallpaper_index = current_wallpaper_index + 1

    if current_wallpaper_index > #wallpaper_list then
        current_wallpaper_index = 1
    end
    s.current_wallpaper_index = current_wallpaper_index

    local elem = wallpaper_list[current_wallpaper_index]
    local wallpaper_path = nil
    if type(elem) == "table" then
        wallpaper_path = elem.wallpaper or ""
        if type(elem.action) == "function" then
            elem.action(s)
        end
    elseif type(elem) == "string" then
        wallpaper_path = elem
    end

    return wallpaper_path
end

theme.font                                      = "Terminus 13"

theme.bg_normal                                 = COLORS.background
theme.bg_focus                                  = COLORS.secondary
theme.bg_urgent                                 = COLORS.urgent
theme.bg_minimize                               = COLORS.hidden
theme.bg_systray                                = COLORS.pink

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
theme.taglist_fg_empty                          = COLORS.normal
theme.taglist_fg_occupied                       = COLORS.pink
theme.taglist_bg_occupied                       = COLORS.transparent
theme.taglist_bg_focus                          = COLORS.transparent
theme.taglist_bg_urgent                         = COLORS.transparent
theme.taglist_font                              = "Terminus 16"

theme.prompt_font                               = "Hack Nerd Font 11"

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

-- Client icons used in tasklist
theme.clients_default_icon                      = theme.dir .. "/icons/clients/Water_Type_Icon.svg"
theme.clients_icons                             = {
    ["Spotify"] = theme.dir .. "/icons/clients/spotify-client.svg",
    ["Rhythmbox"] = theme.dir .. "/icons/clients/rhythmbox.svg",
    ["kitty"] = theme.dir .. "/icons/clients/kitty.svg",
    ["firefox"] = theme.dir .. "/icons/clients/firefox.png",
    ["mpv"] = theme.dir .. "/icons/clients/mpv.svg",
}

-- Generate Awesome icon:
theme.awesome_icon                              = theme.dir .. "/icons/launcher.webp"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

-- Widgets
--
--

theme.textclock_format                          = "%R"
theme.calendar_theme                            = "light"
theme.calendar_start_sunday                     = false
theme.calendar_position                         = "bottom_right"

theme.batteryarc_main_color                     = theme.fg_normal
theme.batteryarc_size                           = dpi(20)
theme.batteryarc_arc_thickness                  = dpi(3)
theme.batteryarc_notification_position          = "bottom_left"

theme.volume_widget_type                        = "arc"

theme.cpu_widget_color                          = theme.fg_normal

theme.create_promptbox                          = function()
    local mypromptbox              = awful.widget.prompt()
    mypromptbox.prompt             = " " .. mypromptbox.prompt
    mypromptbox.bg                 = theme.prompt_bg or theme.bg_normal
    mypromptbox.shape_border_color = theme.prompt_bg or theme.bg_normal
    mypromptbox.shape_border_width = 1
    mypromptbox.shape              = gears.shape.rounded_bar
    return mypromptbox
end


-- Wibar
--
--

-- Wibar properties
--

theme.wibar_position                            = "bottom"
theme.wibar_layout                              = wibox.layout.align.horizontal
theme.wibar_width                               = dpi(36)
theme.wibar_stretch                             = true
theme.wibar_expand                              = "none"
theme.wibar_bg                                  = COLORS.transparent
theme.wibar_opacity                             = 1
theme.wibar_border_width                        = dpi(9)
theme.wibar_ontop                               = false


-- Tasklist
--

local function create_tasklist(args, s)
    return myminitasklist.create_mini_tasklist(s, {
        popup = tasklist_popup.create_tasklist_popup(s, {
            close_button_text = "  "
        })
    })
end

theme.create_tasklist = create_tasklist


-- Taglist
--

local tag_names = {
    home = " ",
    terminal = " ",
    browser = " ",
    music = "󰌳 ",
    video = "󰨜 ",
    image = "󰋹 ",
    communication = " ",
    tools = "󰺾 ",
    film = "󰿎 ",
    bash = " "
}

theme.taglist_tags = { }

theme.init_tags_for_screen = function(screen)
    return {
        {
            -- 1
            tag_name = tag_names.home,
            layout = awful.layout.suit.tile,
            selected = true
        },
        {
            -- 2
            tag_name = tag_names.terminal,
            layout = awful.layout.suit.tile,
        },
        {
            -- 3
            tag_name = tag_names.browser,
            layout = awful.layout.suit.max
        },
        {
            -- 4
            tag_name = tag_names.music,
            layout = awful.layout.suit.tile
        },
        {
            -- 5
            tag_name = tag_names.image,
            layout = awful.layout.suit.tile
        },
        {
            -- 6
            tag_name = tag_names.video,
            layout = awful.layout.suit.tile
        },
        {
            -- 7
            tag_name = tag_names.communication,
            layout = awful.layout.suit.max
        },
        {
            -- 8
            tag_name = tag_names.tools,
            layout = awful.layout.suit.tile
        }
    }
end

theme.taglist_template = {
    {
        {
            id = "text_role",
            widget = wibox.widget.textbox
        },
        left  = 10,
        right  = 0,
        widget = wibox.container.margin
    },
    id              = 'background_role',
    widget          = wibox.container.background
}


-- Left widgets / Top widgets
--

---comment
---@param screen any
---@param widgets { load: function }
---@return table
local function create_left_widgets(screen, widgets)
    local systray = widgets:load("toggable_systray", {
        toggle_side = "right",
        text_icon_show = " 󰏝 ",
        text_icon_hide = " 󰏝 ",
        no_tooltip = true,
        hidden_at_start = true,
        margin_bottom = dpi(8),
        margin_top = dpi(8),
        margin_left = dpi(6),
        margin_right = dpi(6),
        create_systray_box = function (systray_container)
            return wibox.widget {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(6),
                widgets:load('battery_widget'),
                widgets:load('volume_widget'),
                wrap_widget(systray_container, theme.bg_systray),
            }
            --return wrap_widget(systray_container, theme.bg_systray)
        end
    })
    return wrap_widget({
        widget = wibox.container.margin,
        bottom = dpi(2),
        top = dpi(2),
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(6),
            widgets:load("launcher"),
            systray,
            screen.mytasklist
        }
    }, nil, dpi(12))
end

theme.create_left_widgets = create_left_widgets


-- Right widgets / Bottom widgets
--

---comment
---@param screen any
---@param widgets { load: function }
---@return table
local function create_right_widgets(screen, widgets)
    return {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(6),
        screen.mytaglist,
        wrap_widget(widgets:load('textclock'), nil, dpi(12))
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
    -- contains icon_box and media_player
    local media_player_container = nil

    -- shaped and colored wrapper
    local wrapped_container = nil

    local icon_box = wibox.widget {
        resize = true,
        widget = wibox.widget.imagebox,
    }

    local media_player = mpris_widget({
        state_playing = "",
        state_paused = markup.fg.color( COLORS.pink , "󰏤" ),
        display = "text",
        popup_font = "Terminus 10",
        media_icons = {
            musikcube   = theme.dir .. "/icons/clients/musikcube3d.png",
            spotify     = theme.dir .. "/icons/clients/spotify-client.svg",
            rhythmbox   = theme.dir .. "/icons/clients/rhythmbox.svg",
            firefox     = theme.dir .. "/icons/clients/firefox.png",
            mpv         = theme.dir .. "/icons/clients/mpv.svg",
        },
        max_chars = -1,
        popup_maximum_width = dpi(400),
        scroll = {
            enabled = true,
            max_size = dpi(300),
            orientation = "vertical",
            margin_top = dpi(6),
            margin_bottom = dpi(6)
        },
        updated_callback = function (metadata)
            if metadata then
                icon_box.image = metadata.icon
            end
        end,
        clients_running = function()
            if not wrapped_container.visible then
                wrapped_container.visible = not wrapped_container.visible
            end
        end,
        all_clients_closed = function()
            if wrapped_container.visible then
                wrapped_container.visible = not wrapped_container.visible
            end
        end
    })

    media_player_container = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(6),
        icon_box,
        media_player
    }

    wrapped_container = wrap_widget(
        media_player_container
        , nil, dpi(12))
    wrapped_container.visible = false
    wrapped_container:buttons(
        awful.util.table.join(
            awful.button({}, 4, function() media_player:next() end),
            awful.button({}, 5, function() media_player:previous() end)
        )
    )

    return {
        layout = wibox.layout.fixed.horizontal,
        wrapped_container,
        s.mypromptbox
    }
end


-- Clients
--
--

theme.additional_rules = {
    {
        rule = { class = "firefox" },
        properties = { tag = tag_names.browser }
    },
    {
        rule_any = { class = { "Spotify", "Rhythmbox" } },
        properties = { tag = tag_names.music }
    },
    {
        rule = { class = "Gimp" },
        properties = { tag = tag_names.image }
    },
    {
        rule_any = { class = { "mpv", "vlc" } },
        properties = { tag = tag_names.video }
    },
    {
        rule = { class = "mpv" },
        properties = { sticky = true, floating = true }
    },
    {
        rule = { class = "Skype" },
        properties = { tag = tag_names.communication }
    },
    {
        rule = { class = "Lxappearance" },
        properties = { tag = tag_names.tools }
    },
    {
        rule = { class = "obs" },
        properties = { new_tag = {
            name     = tag_names.film, -- The tag name.
            layout   = awful.layout.suit.max, -- Set the tag layout.
            volatile = true, -- Remove the tag when the client is closed.
        } }
    }
}


theme.autostart_shell_cmds = {
    os.getenv("HOME") .. "/.local/bin/spice_on_rice Ziro rose-pine-dawn"
}

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
