---------------------------
-- workless awesome theme --
---------------------------

local theme_name                                = "workless"

local theme_assets                              = require("beautiful.theme_assets")
local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi
local gears                                     = require("gears")
local wibox                                     = require("wibox")
local awful                                     = require("awful")

local mpris_widget                              = require("awesomewm-mpris-widget")

local gfs                                       = require("gears.filesystem")
local themes_path                               = gfs.get_themes_dir()

local color_purple                              = "#cba6f7"

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

theme.terminal                                  = "kitty --config " .. theme.dir .. "/config/kitty.conf"

theme.wallpaper                                 = theme.dir .. "/911476.png"

theme.font                                      = "Vanilla Caramel 12"

theme.bg_normal                                 = "#1e1e2e"
theme.bg_focus                                  = "#1e1e2e"
theme.bg_urgent                                 = "#1e1e2e"
theme.bg_minimize                               = "#1e1e2e"
theme.bg_systray                                = theme.bg_normal

theme.fg_normal                                 = "#cdd6f4"
theme.fg_focus                                  = "#91d6e2"
theme.fg_urgent                                 = "#f38ba8"
theme.fg_minimize                               = "#989898"

theme.useless_gap                               = dpi(0)
theme.border_radius                             = dpi(0)
theme.border_width                              = dpi(4)
theme.border_normal                             = theme.fg_normal
theme.border_focus                              = theme.fg_focus
theme.border_marked                             = "#CC9393"
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
theme.taglist_fg_focus                          = theme.fg_focus
theme.taglist_fg_urgent                         = theme.fg_urgent
theme.taglist_fg_empty                          = "#f7a064"
theme.taglist_bg_focus                          = theme.bg_focus .. "11"
theme.taglist_font                              = theme.font

theme.tasklist_disable_icon                     = false
theme.tasklist_disable_task_name                = true
theme.tasklist_bg_focus                         = theme.bg_focus .. "77"
theme.tasklist_bg_normal                        = theme.bg_normal .. "00"
theme.tasklist_bg_minimize                        = theme.bg_minimize .. "00"
theme.tasklist_max_width                        = dpi(1600 - 6) -- resolution width minus gaps

theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

theme.hotkeys_modifiers_fg                      = theme.fg_focus

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
theme.menu_width                                = dpi(160)

-- Define the image to load
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = theme.dir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.dir .. "/icons/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_max                                = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen                         = themes_path .. "defaults/layout/fullscreenw.png"
theme.layout_magnifier                          = themes_path .. "default/layouts/magnifierw.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_spiral                             = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle                            = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw                           = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne                           = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw                           = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse                           = themes_path .. "default/layouts/cornersew.png"

-- Client icons used in tasklist
theme.clients_default_icon = theme.dir .. "/icons/clients/monokuma_512x512.png"
theme.clients_icons = {
    ["Spotify"] = theme.dir .. "/icons/clients/spotify_512x512.png",
    ["kitty"] = theme.dir .. "/icons/clients/kitty.svg",
    ["firefox"] = theme.dir .. "/icons/clients/firefox.svg"
}

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

-- Widgets
--

theme.textclock_format                          = "%A %d/%m   %R"
theme.calendar_theme                            = "naughty"
theme.calendar_start_sunday                     = false

theme.batteryarc_main_color                     = color_purple

local function create_media_player_widget()
    local media_player = nil

    -- mpris widget args
    local mpris_widget_max_width = dpi(180)
    local mpris_widget_args = {
        state_playing = "",
        font = "Purple Smile 12",
        media_icons = {
            default = theme.dir .. "/icons/mpris/musicnote3d.png",
            musikcube = theme.dir .. "/icons/mpris/musikcube3d.png",
            rhythmbox = theme.dir .. "/icons/mpris/rhythmbox3d.png",
            firefox = theme.dir .. "/icons/mpris/firefox3d.png",
            spotify = theme.dir .. "/icons/mpris/spotify3d.png",
        },
        max_chars = -1,
        scroll = {
            enabled = true,
            max_size = mpris_widget_max_width
        },
        popup_maximum_width = dpi(400)
    }

    -- Controls
    local previous_button = wibox.widget.textbox("󰙣 ")
    previous_button.font = "Vanilla Caramel 18"
    previous_button.visible = false
    previous_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            media_player:previous()
        end
    end)
    local next_button = wibox.widget.textbox(" 󰙡 ")
    next_button.font = "Vanilla Caramel 18"
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

-- Tasklist
--
local function create_tasklist(args, s)
    args.layout = {
        layout = wibox.layout.fixed.horizontal
    }

    args.widget_template = {
        {
            {
                {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox
                        },
                        direction = 'east',
                        widget = wibox.container.rotate
                    },
                    margins = dpi(2),
                    widget = wibox.container.margin
                },
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal
            },
            left = dpi(10),
            right = dpi(10),
            widget = wibox.container.margin
        },
        id = "background_role",
        widget = wibox.container.background
    }

    return awful.widget.tasklist(args)
end

theme.create_tasklist = create_tasklist


-- Left widgets
--

theme.taglist_tags = { "󰺕 ", "󰺕 ", "󰺕 ", "󰺕 ", "󰺕 ", "󰺕 ", "󰺕 " }

theme.init_tags_for_screen = function(screen)
    return {
        {
            tag_name = "Hello",
            layout = awful.layout.suit.max
        },
        {
            tag_name = "Aloha",
            layout = awful.layout.suit.max
        },
        --[[
        {
            name = "bread",
            layout = awful.layout.suit.max
        },
        {
            name = "apple",
            layout = awful.layout.suit.max,
            screen = screen
        }
        --]]
    }
end

local function taglist_update_callback(widget, t, idx)
    if t.activated and #t:clients() > 0 then
        t.name = theme.taglist_tags[idx] and "󰪥 " or t.name
    elseif t.name ~= theme.taglist_tags[idx] then
        t.name = theme.taglist_tags[idx] or t.tag_name or t.name;
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
        left   = dpi(8),
        right  = dpi(8),
        widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background,
    create_callback = taglist_update_callback,
    update_callback = taglist_update_callback
}


local function create_left_widgets(_, _, w_taglist, w_promptbox)
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

local systrayDisplayed = false

---comment
---@param screen any
---@param widgets { load: function }
---@param w_layoutbox table
---@return table
local function create_right_widgets(screen, widgets, w_layoutbox)
    local systray = wibox.widget.systray(true)
    systray:set_base_size(13)

    -- separator
    local spr = {
        wibox.widget.textbox('|'),
        fg = theme.taglist_fg_empty,
        widget = wibox.container.background
    }

    local right_side_layout = {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(20),
        {
            widgets:load('textclock'),
            fg = color_purple,
            widget = wibox.container.background
        },
        spr,
        widgets:load('volume_widget'),
        spr,
        widgets:load('battery_widget'),
        spr
    }

    if not systrayDisplayed then
        systrayDisplayed = true
        table.insert(right_side_layout, wibox.widget {
            {
                -- vertical align center
                systray,
                widget = wibox.container.place
            },
            top = dpi(2), -- fine tuning for better vertical align center
            right = dpi(15),
            widget = wibox.container.margin
        })
        table.insert(right_side_layout, spr)
    end

    table.insert(right_side_layout, wibox.widget {
        {
            {
                    layout = wibox.layout.fixed.horizontal,
                    wibox.widget.textbox('CPU: '),
                    widgets:load('text_cpu_widget', { timeout = 5 }),
                    wibox.widget.textbox('%')
            },
            fg = color_purple,
            widget = wibox.container.background
        },
        forced_width = dpi(70),
        widget = wibox.container.constraint
    })

    return {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                right_side_layout,
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
theme.wibar_position = "top"
theme.wibar_height = dpi(34)
theme.wibar_expand = "none"
theme.wibar_bg = theme.bg_normal
theme.wibar_opacity = 1
theme.wibar_border_width = dpi(0)--theme.border_width
theme.wibar_border_color = theme.border_normal
theme.wibar_ontop = false

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
    s.mysidewibox = awful.wibar({
        screen = s,
        position = "left",
        width = dpi(44),
        bg = theme.bg_normal .. "77",
        border_width = dpi(0),
        ontop = false
    })

    s.mysidewibox:setup({
        layout = wibox.layout.ratio.vertical,
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            empty_widget,
            {
                middle_side,
                direction = 'west',
                widget = wibox.container.rotate
            },
            --middle_side,
            empty_widget
        },
        {
            layout = wibox.layout.align.vertical,
            expand = "none",
            empty_widget,
            empty_widget,
            widgets:load("launcher")
        }
    })
    s.mysidewibox.widget:ajust_ratio(2, 0.9, 0.1, 0)

    return layout;
end

theme.setup_wibar = setup_wibar


theme.autostart_shell_cmds = {
    --os.getenv("HOME") .. "/.local/bin/spice_on_rice Ziro rose-pine-moon"
}

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
