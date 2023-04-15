---------------------------
-- underwork awesome theme --
---------------------------

local theme_name     = "underwork"

local theme_assets   = require("beautiful.theme_assets")
local xresources     = require("beautiful.xresources")
local dpi            = xresources.apply_dpi
local gears          = require("gears")
local wibox          = require("wibox")
local awful          = require("awful")

local mpris_widget   = require("awesomewm-mpris-widget")
local myminitasklist = require('my.screens.mini-tasklist')
local mytinytasklist = require('my.screens.tiny-tasklist')
local tasklist_popup = require("my.popups.tasklist-popup")
local naughty        = require("naughty")

local gfs            = require("gears.filesystem")
local themes_path    = gfs.get_themes_dir()

local ICONS_DIR      = os.getenv("HOME") .. "/.config/awesome/icons"

local function wrap_widget(widget, bg, h_margin)
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
            --top    = 5,
            --bottom = 5,
            widget = wibox.container.margin
        },
        bg                 = bg,
        shape_border_color = "#ffffff",
        shape_border_width = 1,
        shape              = function(cr, width, height)
            return gears.shape.rounded_rect(cr, width, height, dpi(6))
        end,
        widget             = wibox.widget.background
    }
end

local primary_bg_wrapper                        = "#689d6a"

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

--theme.terminal                                  = "kitty --config " .. theme.dir .. "/config/kitty.conf"

local wallpapers_dir                            = theme.dir .. "/wallpapers"

theme.wallpaper_list                            = {
    wallpapers_dir .. "/cropped-1600-900-1191506.jpg",
    wallpapers_dir .. "/69334-648812134-ousamaranking.png",
    wallpapers_dir .. "/69335-648812135-ousamaranking.png",
    wallpapers_dir .. "/desktop-1920x1080.png",
    wallpapers_dir .. "/osama-ranking-pixel-art-1220x686.png.webp"
}

theme.font                                      = "Hack Nerd Font 11"

theme.bg_normal                                 = "#2b2a29"
theme.bg_focus                                  = "#32302f"
theme.bg_urgent                                 = "#cd241c"
theme.bg_minimize                               = "#468387"
theme.bg_systray                                = theme.bg_normal
-- d5c4a1
theme.fg_normal                                 = "#ffffff"
theme.fg_focus                                  = "#d5c4a1"
theme.fg_urgent                                 = "#ed7a78"
theme.fg_minimize                               = "#817868"

theme.useless_gap                               = dpi(6)
theme.border_radius                             = dpi(6)
theme.border_width                              = dpi(2)
theme.border_normal                             = "#7b7c7c"
theme.border_focus                              = "#d5c4a1"
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
theme.tasklist_bg_focus                         = primary_bg_wrapper;
theme.tasklist_bg_urgent                        = theme.bg_urgent

theme.taglist_fg_focus                          = "#ffffff"
theme.taglist_fg_urgent                         = theme.fg_urgent
theme.taglist_fg_empty                          = theme.fg_normal
theme.taglist_bg_focus                          = "#ffffff33"
theme.taglist_bg_urgent                         = theme.bg_urgent .. "11"
theme.taglist_font                              = "Hack Nerd Font Bold 12"

theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

theme.prompt_bg                                 = primary_bg_wrapper
theme.prompt_bg_cursor                          = "#ffffff"

theme.popups_font                               = "Terminus 11"
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
theme.titlebar_close_button_normal              = ICONS_DIR .. "/titlebar/zenburn/close_normal.png"
theme.titlebar_close_button_focus               = ICONS_DIR .. "/titlebar/zenburn/close_focus.png"

theme.titlebar_minimize_button_normal           = ICONS_DIR .. "/titlebar/zenburn/minimize_normal.png"
theme.titlebar_minimize_button_focus            = ICONS_DIR .. "/titlebar/zenburn/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = ICONS_DIR .. "/titlebar/zenburn/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = ICONS_DIR .. "/titlebar/zenburn/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = ICONS_DIR .. "/titlebar/zenburn/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = ICONS_DIR .. "/titlebar/zenburn/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = ICONS_DIR .. "/titlebar/zenburn/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = ICONS_DIR .. "/titlebar/zenburn/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = ICONS_DIR .. "/titlebar/zenburn/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = ICONS_DIR .. "/titlebar/zenburn/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = ICONS_DIR .. "/titlebar/zenburn/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = ICONS_DIR .. "/titlebar/zenburn/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = ICONS_DIR .. "/titlebar/zenburn/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = ICONS_DIR .. "/titlebar/zenburn/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = ICONS_DIR .. "/titlebar/zenburn/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = ICONS_DIR .. "/titlebar/zenburn/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = ICONS_DIR .. "/titlebar/zenburn/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = ICONS_DIR .. "/titlebar/zenburn/maximized_focus_active.png"

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
theme.clients_default_icon                      = theme.dir .. "/icons/clients/mitsumata_512x512.png"
theme.clients_icons                             = {
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
--

theme.textclock_format                          = "%R"
theme.calendar_theme                            = "dark"
theme.calendar_start_sunday                     = false

theme.batteryarc_main_color                     = theme.fg_normal

theme.cpu_widget_color                          = theme.fg_normal

theme.create_promptbox                          = function()
    local mypromptbox              = awful.widget.prompt()
    mypromptbox.prompt             = " " .. mypromptbox.prompt
    mypromptbox.bg                 = theme.prompt_bg
    mypromptbox.shape_border_color = "#ffffff"
    mypromptbox.shape_border_width = 1
    mypromptbox.shape              = function(cr, width, height)
        return gears.shape.rounded_rect(cr, width, height, dpi(6))
    end
    return mypromptbox
end

local function format_button(widget)
    widget:connect_signal("mouse::enter", function()
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "hand2" end
    end)
    widget:connect_signal("mouse::leave", function()
        -- Get the wibox currently under the mouse cursor
        local w = mouse.current_wibox
        if w then w.cursor = "left_ptr" end
    end)
end

local function create_media_player_widget()
    local w_mpris = nil

    local container = nil

    local w_mpris_args = {
        --ignore_player="totem,firefox,spotify",
        --empty_text = "Nothing's playing",
        --ignore_player = "rhythmbox,spotify",
        --media_icons = {
        --    rhythmbox = os.getenv("HOME") .. "/.icons/candy-icons/apps/scalable/juk.svg",
        --},
        --timeout = 3,
        --max_chars = 34,
        title_first = true,
        separator = " 󰞇  ",
        state_playing = "󰎈", -- 󰆥
        state_paused = "󰏤",
        max_chars = -1,
        scroll = {
            enabled = true,
            max_size = 700,
            -- step_function = wibox.container.scroll.step_functions.linear_increase,
            -- speed = 20, -- horizontal speed
            -- speed = 8, -- vertical speed
            -- fps = 10,
            --position = "vertical",
            margin_top = dpi(7),    -- if position vertical
            margin_bottom = dpi(7), -- if position vertical
        },
        popup_maximum_width = dpi(400),
        fg = theme.fg_focus
    }

    -- Controls
    local previous_button = wibox.widget.textbox("")
    previous_button.visible = false
    previous_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            w_mpris:previous()
        end
    end)
    local next_button = wibox.widget.textbox("")
    next_button.visible = false
    next_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            w_mpris:next()
        end
    end)
    local pause_button = wibox.widget.textbox("󰐎")
    pause_button.visible = false
    pause_button:connect_signal("button::release", function(self, _, _, button)
        if button == 1 then
            w_mpris:play_pause()
        end
    end)
    format_button(previous_button)
    format_button(next_button)
    format_button(pause_button)

    -- Events
    w_mpris_args.clients_running = function()
        if not container.visible then
            container.visible = not container.visible
        end
    end
    w_mpris_args.all_clients_closed = function()
        if container.visible then
            container.visible = not container.visible
        end
    end

    -- mpris widget
    w_mpris = mpris_widget(w_mpris_args)

    -- container
    container = wibox.widget {
        {
            {
                previous_button,
                forced_width = dpi(15),
                widget = wibox.container.constraint
            },
            {
                pause_button,
                forced_width = dpi(15),
                widget = wibox.container.constraint
            },
            {
                next_button,
                forced_width = dpi(15),
                widget = wibox.container.constraint
            },
            w_mpris, --wrap_widget(w_mpris, "#ad6084"),
            spacing = dpi(15),
            layout = wibox.layout.fixed.horizontal,
        },
        visible = false,
        halign = "left",
        widget = wibox.container.place
    }

    container:connect_signal("mouse::enter", function()
        -- Get the wibox currently under the mouse cursor
        if not previous_button.visible then
            previous_button.visible = not previous_button.visible
        end
        if not next_button.visible then
            next_button.visible = not next_button.visible
        end
        if not pause_button.visible then
            pause_button.visible = not pause_button.visible
        end
    end)
    container:connect_signal("mouse::leave", function()
        -- Get the wibox currently under the mouse cursor
        if previous_button.visible then
            previous_button.visible = not previous_button.visible
        end
        if next_button.visible then
            next_button.visible = not next_button.visible
        end
        if pause_button.visible then
            pause_button.visible = not pause_button.visible
        end
    end)

    -- wrap_widget(container, "#ad6084") --
    return container
end

-- Wibar
--
--

-- Wibar properties
--

-- Wibar properties
theme.wibar_position     = "top"
theme.wibar_height       = dpi(32)
--theme.wibar_expand                              = "none"
theme.wibar_bg           = "#00000000"                        -- transparent
theme.wibar_opacity      = 0.85
theme.wibar_border_width = dpi(9)


-- Left widgets
--

-- Taglist
-- Generate taglist squares:
theme.taglist_squares_sel = theme.dir .. "/icons/arrow_square_sel.png"

theme.taglist_squares_unsel = theme.dir .. "/icons/arrow_square_sel.png"

theme.taglist_tags = { "1", "2", "3", "4" }

theme.init_tags_for_screen = function(screen)
    return {
        {
            tag_name = "5",
            layout = awful.layout.suit.max
        },
    }
end

-- Taglist widget template
theme.taglist_template = {
    {
        {
            layout = wibox.layout.fixed.horizontal,
            {
                --[[
                    to display icons instead of text
                {
                    id     = 'icon_role',
                    widget = wibox.widget.imagebox,
                },
                --]]
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                margins = dpi(1),
                widget = wibox.container.margin
            },
        },
        left   = 8,
        right  = 8,
        widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background
}

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

    screen.myminitasklist = myminitasklist.create_mini_tasklist(screen, {
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
            }, primary_bg_wrapper)
        end
    })

    screen.mytinytasklist = mytinytasklist.create_tiny_tasklist(screen, {
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
            }, "#468387")
        end
    })

    return {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
                wrap_widget(w_taglist, primary_bg_wrapper),
                screen.mytinytasklist,
                screen.myminitasklist,
                w_promptbox,
            },
            left = dpi(3),
            right = dpi(10),
            widget = wibox.container.margin
        }
    }
end

theme.create_left_widgets = create_left_widgets

-- Middle widgets
--

-- Replace awesome tasklist
---@param screen any
---@param widgets { load: function }
---@return table
local function create_middle_widgets(screen, widgets)
    --return widgets:load('spr')
    return create_media_player_widget()
end

theme.create_middle_widgets = create_middle_widgets

-- Right widgets
--

local systrayDisplayed = false

---Widgets for the right side of the wibar
---@param screen any
---@param widgets { load: function }
---@return table
local function create_right_widgets(screen, widgets)
    local right_side_layout = {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(10),
        wrap_widget(widgets:load('volume_widget'), "#468387", dpi(8)),
        wrap_widget(widgets:load('battery_widget'), "#989719", dpi(8)),
        wrap_widget({
            {
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.textbox('󱐋 '),
                widgets:load('text_cpu_widget', { timeout = 5 }),
                wibox.widget.textbox('%')
            },
            --forced_width = dpi(75),
            widget = wibox.container.constraint
        }, "#d69821", dpi(8))
    }

    if not systrayDisplayed then
        systrayDisplayed = true
        local systray = wibox.widget.systray(false)
        table.insert(right_side_layout, wrap_widget(wibox.widget {
            {
                -- vertical align center
                systray,
                widget = wibox.container.place
            },
            top = dpi(6),
            bottom = dpi(6),
            widget = wibox.container.margin
        }, theme.bg_systray, dpi(8)))
    end

    table.insert(right_side_layout, wrap_widget(widgets:load('textclock'), "#cd241c", dpi(8)))

    return {
        layout = wibox.layout.fixed.horizontal,
        {
            right_side_layout,
            left = dpi(15),
            right = dpi(3),
            widget = wibox.container.margin
        }
    }
end

theme.create_right_widgets = create_right_widgets


-- Clients
--
--


theme.additional_rules = {
    {
        rule = { class = "Skype" },
        properties = { new_tag = {
            name     = "skype", -- The tag name.
            layout   = awful.layout.suit.max, -- Set the tag layout.
            volatile = true, -- Remove the tag when the client is closed.
        } }
    },
    {
        rule = { class = "obs" },
        properties = { new_tag = {
            name     = "obs", -- The tag name.
            layout   = awful.layout.suit.max, -- Set the tag layout.
            volatile = true, -- Remove the tag when the client is closed.
        } }
    },
    {
        rule = { class = "firefox" },
        properties = { tag = "3" }
    }
}


theme.autostart_shell_cmds = {
    --os.getenv("HOME") .. "/.local/bin/spice_on_rice Onepunch Dark"
}

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
