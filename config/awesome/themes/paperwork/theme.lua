---------------------------
-- paperwork awesome theme --
---------------------------

local theme_name = "paperwork"

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
-- local naughty = require("naughty")

local mpris_widget = require("awesomewm-mpris-widget")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()


local theme = {}
theme.dir           = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

theme.terminal = "kitty --config " .. theme.dir .. "/config/kitty.conf"

theme.wallpaper = "#f9f7db" --theme.dir .. "/paperwork.jpg"

theme.font          = "URW Bookman Light 11"

theme.bg_normal     = "#f9f7db" -- "#f1f1f1"
theme.bg_focus      = "#f9f7db" -- "#f1f1f1"
theme.bg_urgent     = "#f9f7db" -- "#f1f1f1"
theme.bg_minimize   = "#f9f7db" -- "#f1f1f1"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#1a1a1a"
theme.fg_focus      = "#828000"
theme.fg_urgent     = "#a7060e"
theme.fg_minimize   = "#989898"

theme.useless_gap   = dpi(3)
theme.border_radius = dpi(6)
theme.border_width  = dpi(1)
theme.border_normal = "#eaedd0"
theme.border_focus  = theme.fg_focus
theme.border_marked = "#CC9393"
theme.systray_icon_spacing = dpi(10)

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
theme.taglist_fg_focus    = theme.fg_focus
theme.taglist_fg_urgent   = theme.fg_urgent
theme.taglist_fg_empty    = theme.fg_normal
theme.taglist_bg_focus    = theme.bg_focus .. "11"
theme.taglist_font        = theme.font

theme.tasklist_disable_icon = true
theme.tasklist_disable_task_name = false
theme.tasklist_bg_focus  = theme.bg_focus
theme.tasklist_font = "URW Bookman Semibold 10"

theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_focus

theme.hotkeys_modifiers_fg = "#828000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.menu_height = dpi(22)
theme.menu_width  = dpi(160)

-- Define the image to load
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.dir .. "/icons/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme.dir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme.dir .. "/icons/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.dir .. "/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.dir .. "/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.dir .. "/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.dir .. "/icons/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "defaults/layout/fullscreenw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Widgets
--

local mpris_widget_args = {
                        --ignore_player="totem,firefox,spotify",
                        --empty_text = "Nothing's playing",
                        --ignore_player = "rhythmbox,spotify",
                        --state_paused = "... ",
                        --media_icons = {
                        --    rhythmbox = os.getenv("HOME") .. "/.icons/candy-icons/apps/scalable/juk.svg",
                        --},
                        --timeout = 3,
                        --max_chars = 34,
                        max_chars = -1,
                        scroll = {
                            enabled = true,
 		            max_size = dpi(400),
 		            -- step_function = wibox.container.scroll.step_functions.linear_increase,
 		            -- speed = 20, -- horizontal speed
                            -- speed = 8, -- vertical speed
                            -- fps = 10,
                            position = "vertical",
                            margin_top = dpi(8), -- if position vertical
                            -- margin_bottom = 5, -- if position vertical
                        },
                        popup_maximum_width = dpi(400),
                        --bg = "#919191",
                        -- bgimage = gears.surface.load_uncached(os.getenv("HOME") 
                        --    .. "/Pictures/Wallpapers/Portraits/torii-japanese-shrine-anime-scenery-art-phone-wallpaper-400.jpg"),
                        widget_dir = os.getenv("HOME") .. "/.config/awesome/awesomewm-mpris-widget" 
                    }

theme.calendar_theme = "naughty"
theme.calendar_start_sunday = false

theme.batteryarc_main_color = theme.fg_normal

theme.cpu_widget_color = theme.fg_normal

-- Wibar
--
--

-- Wibar properties
--
theme.wibar_position = "top"
theme.wibar_height = dpi(34)
theme.wibar_expand = "none"
theme.wibar_bg = theme.bg_normal
theme.wibar_opacity = 1
theme.wibar_border_width = dpi(2)

-- return arg for wibar:setup
local function setup_wibar(s, layout, left_side, middle_side, right_side)

    table.insert(layout, left_side)
    table.insert(layout, {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    mpris_widget(mpris_widget_args),
                },
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
    s.mybottomwibox = awful.wibar({
        screen = s,
        position = "bottom"
    })

    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = theme.wibar_expand,
        {
            layout = wibox.layout.fixed.horizontal
        },
        middle_side,
        {
            layout = wibox.layout.fixed.horizontal
        }
    }

    return layout;
end

theme.setup_wibar = setup_wibar

-- Tasklist
--
theme.tasklist_max_width = dpi(1600 - 6) -- resolution width minus gaps 
local function create_tasklist(args, s)

    args.layout = {
        spacing = 10,
        spacing_widget = {
            {
                forced_width = dpi(5),
                shape = gears.shape.circle,
                widget = wibox.widget.separator
            },
            valign = "center",
            halign = "center",
            widget = wibox.container.place
        },
        layout = wibox.layout.fixed.horizontal
    }

    args.widget_template = {
        {   
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox
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

-- Custom widgets
--



-- Left widgets
--

-- Taglist
-- nf-weather-moon_alt
theme.taglist_tags = { " ", " ", " ", " ", " ", " ", " " } -- tags 8 and 9: " ", " " 

local function taglist_update_callback(widget, t, idx)
    if t.activated and #t:clients() > 0 then
        t.name = idx < 5 and "󰏢" or " "
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
        left  = dpi(8),
        right = dpi(0),
        widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background,
    create_callback = taglist_update_callback,
    update_callback = taglist_update_callback
}


local function create_left_widgets(w_launcher, w_taglist, w_promptbox)
    return {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    w_taglist,
                    w_promptbox
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

theme.create_left_widgets = create_left_widgets



-- Right widgets
--

local function create_right_widgets(w_cpu, w_ram, w_vol, w_batt, w_kb, w_clock, w_layout)
    local systray = wibox.widget.systray(false)
    systray:set_base_size(13)

    --local mprisw = mpris_widget({
    --                    ignore_player = "spotify"
    --                })
    --mprisw:play_pause()
    --mprisw:previous()
    --mprisw:next()
    return {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(20),
                    --mprisw,
                    wibox.widget {
                        {
                            -- vertical align center
                            systray,
                            widget = wibox.container.place
                        },
                        top = dpi(2), -- fine tuning for better vertical align center
                        right = dpi(10),
                        widget = wibox.container.margin
                    },
                    --systray,
                    w_cpu,
                    w_ram,
                    w_vol,
                    w_batt,
                    w_kb,
                    w_clock,
                    w_layout
                },
                left = dpi(15),
                right = dpi(10),
                widget = wibox.container.margin
            },
            bg = theme.bg_normal,
            id = "background_role",
            widget = wibox.container.background
        }
    }
end

theme.create_right_widgets = create_right_widgets


-- Comment it when developing
theme.autostart = function ()
    --[[
    awful.spawn.easy_async_with_shell(
        os.getenv("HOME") .. "/.local/bin/spice_on_rice Onepunch Light",
        function (stdout, stderr)
            -- naughty.notify({text = "spiced out"})
            -- naughty.notify({text = stderr})
        end
        )
    --]]
end

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
