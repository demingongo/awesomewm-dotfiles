---------------------------
-- yumework awesome theme --
---------------------------

local theme_name = "yumework"

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local escape_f  = require("awful.util").escape

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}
theme.dir           = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

theme.wallpaper = theme.dir .. "/yumework.jpg"

theme.font          = "Terminus 9"

theme.bg_normal     = "#1A1A1A"
theme.bg_focus      = "#303446"
theme.bg_urgent     = "#313131"
theme.bg_minimize   = "#313131"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#959CB7"
theme.fg_focus      = "#DDDDFF"
theme.fg_urgent     = "#ED7A78"
theme.fg_minimize   = "#999999"

theme.useless_gap   = dpi(6)
theme.border_radius = 6
theme.border_width  = dpi(1)
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#767EA2"
theme.border_marked = "#CC9393"

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
theme.taglist_fg_focus    = "#3EA0C1"
theme.taglist_fg_urgent   = theme.fg_urgent
theme.taglist_fg_empty    = theme.fg_normal
theme.taglist_bg_focus    = theme.bg_focus .. "11"
theme.taglist_font        = "Hack Nerd Font Bold 12"

theme.tasklist_disable_icon = true
theme.tasklist_disable_task_name = false
theme.tasklist_bg_focus  = "#1A1A1A"

theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_focus

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
theme.menu_width  = dpi(140)

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
-- 

theme.textclock_format = "%R"
theme.calendar_theme = "naughty"
theme.calendar_start_sunday = false

theme.batteryarc_main_color = theme.fg_normal

-- Wibar
--
--

-- Wibar properties
--
theme.wibar_position = "top"
theme.wibar_height = dpi(25)
theme.wibar_expand = "none"
theme.wibar_bg = "#00000000" -- transparent
theme.wibar_opacity = 0.85
theme.wibar_border_width = dpi(12)

-- Tasklist
--
theme.tasklist_max_width = 600 
local function create_tasklist(args, s)

    args.style = {
        shape_border_width = 1,
        shape = gears.shape.rounded_bar
    }

    args.layout = {
        spacing = 20,
        spacing_widget = {
            {
                forced_width = 5,
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
                    margins = 2,
                    widget = wibox.container.margin
                },
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal
            },
            left = 15,
            right = 15,
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

local function ellipsize(text, length)
    return (text:len() > length and length > 0)
        and text:sub(0, length - 3) .. '...'
        or text
end

-- mpris widget
-- based on https://github.com/acrisci/playerctl
local mpris, mpris_timer = awful.widget.watch(
    -- format 'playerctl metadata' command result
    { awful.util.shell, "-c", "playerctl -f '{{status}};{{xesam:artist}};{{xesam:title}};{{mpris:artUrl}}{{xesam:album}}{{xesam:albumArtist}}' metadata" },
    2,
    function(widget, stdout)
        -- Declare/init vars
        local states = {
            Playing = "󰝚 ",
            Paused = " "
        }
        local mpris_now = {
            state        = "N/A",
            artist       = "N/A",
            title        = "N/A",
            art_url      = "N/A",
            album        = "N/A",
            album_artist = "N/A"
        }
        local link = {
            'state',
            'artist',
            'title',
            'art_url',
            'album',
            'album_artist'
        }

        -- Fill mpris_now
        local i = 1
        for v in string.gmatch(stdout, "([^;]+)") 
        do
            if link[i] then
                if link[i] ~= 'art_url' then
                    mpris_now[link[i]] = escape_f(v) or "N/A"
                else
                    mpris_now[link[i]] = v or "N/A"
                end
            end
            i = i + 1
        end
        
        if states[mpris_now.state] then
            mpris_now.state = states[mpris_now.state]
        else
            mpris_now.state = mpris_now.state .. " -"
        end

        -- Display
        if mpris_now.state ~= "N/A" then
            widget:set_text(ellipsize(mpris_now.state .. " " .. mpris_now.artist .. " - " .. mpris_now.title, 31))
        else
            widget:set_text('')
        end
    end
)


-- Left widgets
--

-- Taglist
-- nf-weather-moon_alt
theme.taglist_tags = { " ", " ", " ", " ", " ", " ", " " } -- tags 8 and 9: " ", " " 

local function taglist_update_callback(widget, t, idx)
    if t.activated and #t:clients() > 0 then
        t.name = " "
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
                margins = 1,
                widget = wibox.container.margin
            },
        },
        left  = 8,
        right = 0,
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
                    mpris,
                    w_promptbox
                },
                left = 15,
                right = 15,
                widget = wibox.container.margin
            },
            shape_border_width = 1,
            shape = gears.shape.rounded_bar,
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
    return {
        layout = wibox.layout.fixed.horizontal,
        
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 20,
                    wibox.widget.systray(),
                    w_cpu,
                    w_ram,
                    w_vol,
                    w_batt,
                    w_kb,
                    w_clock,
                    w_layout
                },
                left = 15,
                right = 10,
                widget = wibox.container.margin
            },
            shape_border_width = 1,
            shape = gears.shape.rounded_bar,
            bg = theme.bg_normal,
            id = "background_role",
            widget = wibox.container.background
        }
    }
end

theme.create_right_widgets = create_right_widgets

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
