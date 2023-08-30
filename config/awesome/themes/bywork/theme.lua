---------------------------
-- rework awesome theme --
---------------------------

local theme_name                                = "bywork"

local theme_assets                              = require("beautiful.theme_assets")
local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi
local gears                                     = require("gears")
local wibox                                     = require("wibox")
local awful                                     = require("awful")
local naughty                                   = require("naughty")

local markup                                    = require("lain").util.markup
local mpris_widget                              = require("awesomewm-mpris-widget")
local calendar_widget_f                         = require("awesome-wm-widgets.calendar-widget.calendar")
local mytinytasklist                            = require('my.screens.tiny-tasklist')
local tasklist_popup                            = require("my.popups.tasklist-popup")

local gfs                                       = require("gears.filesystem")
local themes_path                               = gfs.get_themes_dir()

local ICONS_DIR                                 = os.getenv("HOME") .. "/.config/awesome/icons"

local COLORS                                    = {
    background = "#efe9c9",
    background_2 = "#f0e4be",
    background_3 = "#ecd4a4",
    white = "#fbfbf7",
    light = "#f2e6b6",
    normal = "#898a7c",
    primary = "#231b24",
    secondary = "#898a7c",
    hidden = "#adada3",
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
        bg                 = bg or COLORS.background_3,
        shape_border_color = COLORS.background_3,
        shape_border_width = 1,
        shape              = function(cr, width, height)
            return gears.shape.rounded_rect(cr, width, height, dpi(9))
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
    wallpapers_dir .. "/freepik/4084199.jpg",
    wallpapers_dir .. "/freepik/4164303.jpg",
    wallpapers_dir .. "/freepik/4164290.jpg",
    wallpapers_dir .. "/freepik/4186461.jpg",

    wallpapers_dir .. "/wp12676494-golden-summer-wallpapers.jpg",
}

theme.font                                      = "Terminus 13"

theme.bg_normal                                 = COLORS.background
theme.bg_focus                                  = COLORS.secondary
theme.bg_urgent                                 = COLORS.urgent
theme.bg_minimize                               = COLORS.hidden
theme.bg_systray                                = COLORS.background_3

theme.fg_normal                                 = COLORS.normal
theme.fg_focus                                  = COLORS.primary
theme.fg_urgent                                 = COLORS.urgent
theme.fg_minimize                               = theme.fg_normal

theme.useless_gap                               = dpi(5)
theme.border_radius                             = dpi(6)
theme.border_width                              = dpi(1)
theme.border_normal                             = COLORS.background_2
theme.border_focus                              = COLORS.primary
theme.border_marked                             = COLORS.warning
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
theme.taglist_fg_focus                          = COLORS.primary
theme.taglist_fg_urgent                         = theme.fg_urgent
theme.taglist_fg_empty                          = COLORS.background
theme.taglist_fg_occupied                       = COLORS.secondary
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
theme.clients_default_icon                      = theme.dir .. "/icons/clients/weather-clear-night-large.svg"
theme.clients_icons                             = {
    ["Spotify"] = theme.dir .. "/icons/clients/spotify-client.svg",
    ["Rhythmbox"] = theme.dir .. "/icons/clients/rhythmbox.svg",
    ["kitty"] = theme.dir .. "/icons/clients/kitty.svg",
    ["firefox"] = theme.dir .. "/icons/clients/firefox.svg",
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
theme.batteryarc_size                           = dpi(25)
theme.batteryarc_arc_thickness                  = dpi(3)
theme.batteryarc_notification_position          = "bottom_left"

theme.volume_widget_type                        = "icon"

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

local function get_widget_separator()
    return {
        widget = wibox.container.place,
        {
            {
                widget = wibox.widget.textbox,
                text = " 󰇘 ",
                font = "Terminus 20"
            },
            fg = COLORS.hidden,
            widget = wibox.container.background
        }
    }
end

local function create_media_player_widget()
    local mpris_controls = nil
    local media_container = nil
    local mpris_controls_wrapper = nil

    local media_player = mpris_widget({
        state_playing = "",
        state_paused = "󰏤",
        display = "icon",
        popup_font = "Terminus 10",
        media_icons = {
            spotify     = theme.dir .. "/icons/clients/spotify-client.svg",
            rhythmbox   = theme.dir .. "/icons/clients/rhythmbox.svg",
            firefox     = theme.dir .. "/icons/clients/firefox.svg",
            mpv         = theme.dir .. "/icons/clients/mpv.svg"
        },
        max_chars = -1,
        popup_maximum_width = dpi(400),
        clients_running = function()
            if not media_container.visible then
                media_container.visible = not media_container.visible
            end
        end,
        all_clients_closed = function()
            if media_container.visible then
                media_container.visible = not media_container.visible
            end
        end,
        updated_callback = function(metadata)
            if metadata then
                --[[
                - create <tmp folder>
                - remove old files from <tmp folder>
                - check if <tmp art image> already exists in <tmp folder>:
                    - if not:
                        - download and resize + crop art image to <tmp folder>
                        - set the <tmp art image> as bgimage of <background container>
                    - otherise:
                        - do nothing (no downloading or resizing)
                        - set the <tmp art image> as bgimage of <background container>
                --]]
                if metadata.art_url then
                    local dirpath = "/tmp/awesomewm_mpris"

                    -- cmds
                    local create_dir_cmd = "mkdir -p " .. dirpath
                    local remove_old_files_cmd = "find " .. dirpath .. " -type f -amin +30 -delete"

                    local resizeopt = "-resize " .. (8192 * 2) + (8192 / 2) .. "@ -crop 0%x+42+10 +repage"
                    local bluropt = "" --"-blur 5x2"

                    if string.sub(metadata.art_url,1 , string.len("http")) == "http" then
                        local imagename = string.sub(metadata.art_url, 6):gsub( ":", "_"):gsub( "/", "_") .. ".png"
                        local imagepath = dirpath .. "/" .. imagename

                        -- cmds
                        local download_image_cmd = "wget " .. metadata.art_url .. " -O " .. imagepath
                        local resize_image_cmd = "convert " .. imagepath .. " " .. resizeopt .. " " .. bluropt .. " " .. imagepath
                        local file_not_exist_condition = "[ ! -f " .. imagepath .. " ]"
                        local do_nothing_cmd = "echo " .. imagepath
                        local create_file_cmd = download_image_cmd .. " && " .. resize_image_cmd

                        awful.spawn.easy_async_with_shell(
                            create_dir_cmd .." && " .. remove_old_files_cmd .. " && " .. file_not_exist_condition .. " && " .. create_file_cmd .. " || (" .. do_nothing_cmd .. ")",
                            function(stdout)
                                mpris_controls_wrapper.bgimage = imagepath
                            end
                        )
                    elseif string.sub(metadata.art_url,1 , string.len("file://")) == "file://" then
                        local original_imagepath = string.sub(metadata.art_url, string.len("file://") + 1)
                        local imagename = original_imagepath:gsub( "/", "_") .. ".png"
                        local imagepath = dirpath .. "/" .. imagename

                        -- cmds
                        local resize_image_cmd = "convert " .. original_imagepath .. " " .. resizeopt .. " " .. bluropt .. " " .. imagepath
                        local file_not_exist_condition = "[ ! -f " .. imagepath .. " ]"
                        local do_nothing_cmd = "echo " .. imagepath

                        awful.spawn.easy_async_with_shell(
                            create_dir_cmd .." && " .. remove_old_files_cmd .. " && " .. file_not_exist_condition .. " && " .. resize_image_cmd .. " || (" .. do_nothing_cmd .. ")",
                            function(stdout)
                                mpris_controls_wrapper.bgimage = imagepath
                            end
                        )
                    else
                        mpris_controls_wrapper.bgimage = nil
                    end
                else
                    --bgimage nil
                    mpris_controls_wrapper.bgimage = nil
                end
                --naughty.notify({text= "art_url is: ".. metadata.art_url})
            end
        end
    })
    local media_player_container = wibox.widget {
        media_player,
        widget = wibox.container.place
    }

    local previous_button = wibox.widget.textbox("󰒮 ")
    previous_button.font = "Terminus Bold 16"
    previous_button:buttons(
        awful.util.table.join(
            awful.button({}, 1, function() media_player:previous() end)
        )
    )
    format_button(previous_button)
    local next_button = wibox.widget.textbox("󰒭 ")
    next_button.font = "Terminus Bold 16"
    next_button:buttons(
        awful.util.table.join(
            awful.button({}, 1, function() media_player:next() end)
        )
    )
    format_button(next_button)
    local play_pause_button = wibox.widget.textbox("󰐎 ")
    play_pause_button.font = "Terminus Bold 16"
    play_pause_button:buttons(
        awful.util.table.join(
            awful.button({}, 1, function() media_player:play_pause() end)
        )
    )
    format_button(play_pause_button)

    mpris_controls = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(4),
        {
            forced_height = dpi(10),
            widget = wibox.container.background,
        },
        {
            previous_button,
            left = dpi(12),
            widget = wibox.container.margin,
        },
        {
            play_pause_button,
            left = dpi(10),
            widget = wibox.container.margin,
        },
        {
            next_button,
            left = dpi(12),
            widget = wibox.container.margin,
        },
        {
            forced_height = dpi(10),
            widget = wibox.container.background,
        }
    }

    mpris_controls_wrapper = wrap_widget(
        wrap_widget(mpris_controls,  COLORS.secondary .. "99", dpi(3))
    )
    mpris_controls_wrapper.fg = COLORS.background

    media_container = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        visible = false,
        get_widget_separator(),
        {
            mpris_controls_wrapper,
            left = dpi(3),
            right = dpi(3),
            widget = wibox.container.margin
        },
        {
            -- space
            forced_height = dpi(6),
            widget = wibox.container.constraint
        },
        {
            media_player_container,
            left = dpi(10),
            right = dpi(10),
            widget = wibox.container.margin
        }
    }

    return media_container
end

local function create_clock_widget()
    local clock_widget = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        {
            widget = wibox.container.place,
            wibox.widget {
                format = '%H',
                font = "Terminus Bold 16",
                widget = wibox.widget.textclock
            }
        },
        {
            widget = wibox.container.margin,
            left = dpi(5),
            {
                wibox.widget {
                    markup = ':',
                    font = "Terminus Bold 16",
                    widget = wibox.widget.textbox
                },
                direction = 'west',
                widget = wibox.container.rotate
            }
        },
        {
            widget = wibox.container.place,
            wibox.widget {
                format = '%M',
                font = "Terminus Bold 16",
                widget = wibox.widget.textclock
            },
        },
    }
    -- Calendar widget
    local calendar_widget = calendar_widget_f({
        theme = "light",
        placement = "top_left",
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
        wrap_widget(clock_widget, nil, dpi(6)),
        left = dpi(5),
        right = dpi(5),
        widget = wibox.container.margin
    }
end


-- Wibar
--
--

-- Wibar properties
--
theme.wibar_position     = "left"
theme.wibar_layout       = wibox.layout.align.vertical
theme.wibar_width        = dpi(50)
theme.wibar_stretch      = true
theme.wibar_expand       = "none"
theme.wibar_bg           = COLORS.transparent
theme.wibar_opacity      = 1
theme.wibar_border_width = dpi(0)
theme.wibar_border_color = COLORS.transparent
theme.wibar_ontop        = false

-- Tasklist
--

local function create_tasklist(args, s)
    return mytinytasklist.create_tiny_tasklist(s, {
        popup = tasklist_popup.create_tasklist_popup(s, {
            close_button_text = "  "
        }),
        create_widget = function(textbox)
            return wibox.widget {
                layout = wibox.layout.fixed.vertical,
                wibox.widget {
                    wrap_widget({
                        textbox,
                        widget = wibox.container.place
                    }),
                    left = dpi(5),
                    right = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    get_widget_separator(),
                    widget = wibox.container.place
                }
            }
        end
    })
end

theme.create_tasklist = create_tasklist


-- Taglist
--

local tag_names = {
    home = "󰋜 ",
    terminal = " ",
    browser = "󰊷 ",
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
            {
                id = "text_role",
                widget = wibox.widget.textbox
            },
            direction = "west",
            widget = wibox.container.rotate
        },
        left  = dpi(5),
        top = dpi(8),
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
    local launcher_widget = widgets:load('launcher')
    format_button(launcher_widget)

    return {
        widget = wibox.container.place,
        {
            {
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(10),
                {
                    {
                        launcher_widget,
                        width = dpi(25),
                        widget = wibox.container.constraint
                    },
                    widget = wibox.container.place
                },
                {
                    wrap_widget({
                        {
                            {
                                screen.mytaglist,
                                direction = 'east',
                                widget = wibox.container.rotate
                            },
                            widget = wibox.container.place
                        },
                        top = dpi(1),
                        left = dpi(3),
                        right = dpi(3),
                        widget = wibox.container.margin
                    }),
                    widget = wibox.container.place
                }
            },
            top = dpi(10),
            widget = wibox.container.margin
        }
    }
end

theme.create_left_widgets = create_left_widgets


-- Right widgets / Bottom widgets
--

local systray_displayed = false

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
        margin_top = dpi(9),
        margin_bottom = dpi(9),
        create_systray_box = function (systray_container)
            local toggable_content = {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(10),
                {
                    widgets:load('volume_widget'),
                    direction = 'east',
                    widget = wibox.container.rotate
                },
                {
                    widgets:load('battery_widget'),
                    direction = 'east',
                    widget = wibox.container.rotate
                }
            }
            if not systray_displayed then
                systray_displayed = true
                table.insert(toggable_content, systray_container)
            end
            return wibox.widget {
                wrap_widget({
                    toggable_content,
                    right = dpi(10),
                    left = dpi(10),
                    widget = wibox.container.margin
                } ,theme.bg_systray),
                top = dpi(5),
                bottom = dpi(5),
                widget = wibox.container.margin
            }
        end
    })

    local toggable_systray_container = {
        systray,
        direction = 'west',
        widget = wibox.container.rotate
    }

    return {
        layout = wibox.layout.fixed.vertical,
        screen.mytasklist,
        toggable_systray_container
    }
end

theme.create_right_widgets = create_right_widgets


-- Middle widgets
--

---comment
---@return table
theme.create_middle_widgets = function()
    return {
        layout = wibox.layout.fixed.vertical,

        -- clock
        {
            widget = wibox.container.place,
            create_clock_widget()
        },

        -- mpris
        {
            create_media_player_widget(),
            widget = wibox.container.place
        },
    }
end


---Returns the argument for wibar:setup
local function setup_wibar(s, layout, left_side, middle_side, right_side, widgets)

    table.insert(layout, left_side)
    table.insert(layout, middle_side)
    table.insert(layout, right_side)

    return {
        layout,
        widget = wibox.container.background,
        bg = COLORS.background
    }
end

theme.setup_wibar = setup_wibar


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
        rule = { class = "Skype" },
        properties = { tag = tag_names.communication }
    },
    {
        rule_any = { class = { "Lxappearance", "Studio 3T" } },
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
    os.getenv("HOME") .. "/.local/bin/spice_on_rice Onepunch Light"
}

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
