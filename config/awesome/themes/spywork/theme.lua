---------------------------
-- spywork awesome theme --
---------------------------

local theme_name = "spywork"

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}
theme.dir           = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

theme.terminal = "kitty --config " .. os.getenv("HOME") .. "/.config/kitty/kitty_spy.conf"

theme.wallpaper = "#101010"

theme.font          = "Terminus 10"

theme.bg_normal     = "#101010"
theme.bg_focus      = "#101010"
theme.bg_urgent     = "#FDC407"
theme.bg_minimize   = "#101010"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#009900"
theme.fg_focus      = "#00FF00"
theme.fg_urgent     = "#FF0000"
theme.fg_minimize   = "#FDC407"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = "#101010"
theme.border_focus  = "#101010"
theme.border_marked = "#FF0000"

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
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
theme.tasklist_bg_focus  = "#101010"
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_focus

-- awful wibar properties
theme.wibar_position = "bottom"
theme.wibar_height = dpi(25)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

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

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

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
theme.calendar_position = "bottom_right"
theme.calendar_radius = 0
theme.calendar_start_sunday = false

theme.batteryarc_notification_position = "bottom_right"
theme.batteryarc_main_color = theme.fg_normal

theme.volume_widget_type = "horizontal_bar"

local function create_taglist(args, s)
    --[[
    args.widget_template = {
      id = "background_role",
      forced_width = 10,
      widget = wibox.container.background,
      create_callback = function(widget, tag, _, _)
        widget:connect_signal("mouse::enter", function()
          widget.shape_border_color = "#FF0000"
        end)
        widget:connect_signal("mouse::leave", function()
          widget.shape_border_color = "#FFFFFF"
        end)
        -- optional bonus tooltip showing the tag name
        -- awful.tooltip({
        --   objects = { widget },
        --   mode = "outside",
        --   text = tag.name,
        -- })
      end,
    }
    --]]

    --[[
    args.widget_template = {
    {
        {
	    layout = wibox.layout.fixed.horizontal,
	    {
		{
                    {
                        id     = 'index_role',
                        widget = wibox.widget.textbox,
                    },
                    margins = 2,
                    widget  = wibox.container.margin,
                },
                bg     = '#00FF00',
                shape  = gears.shape.circle,
                widget = wibox.container.background,
            },
        },
        left  = 8,
        right = 8,
        widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background,
    }
    --]]

    return awful.widget.taglist(args)
end

theme.create_taglist = create_taglist

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
