---------------------------
-- spywork awesome theme --
---------------------------

local theme_name                                = "spywork"

local theme_assets                              = require("beautiful.theme_assets")
local xresources                                = require("beautiful.xresources")
local dpi                                       = xresources.apply_dpi
local wibox                                     = require("wibox")

local mpris_widget                              = require("awesomewm-mpris-widget")

local gfs                                       = require("gears.filesystem")
local themes_path                               = gfs.get_themes_dir()

local ICONS_DIR                                 = os.getenv("HOME") .. "/.config/awesome/icons"

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name

--theme.terminal                                  = "kitty --config " .. theme.dir .. "/config/kitty.conf"
theme.terminal                                  = "cool-retro-term"

theme.wallpaper                                 = "#101010"

theme.font                                      = "Commodore 64 10"

theme.bg_normal                                 = "#101010"
theme.bg_focus                                  = "#101010"
theme.bg_urgent                                 = "#0b350b"
theme.bg_minimize                               = "#101010"
theme.bg_systray                                = theme.bg_normal

theme.fg_normal                                 = "#057f05"
theme.fg_focus                                  = "#019b01"
theme.fg_urgent                                 = "#FF0000"
theme.fg_minimize                               = "#0b350b"

theme.useless_gap                               = dpi(0)
theme.border_width                              = dpi(1)
theme.border_normal                             = "#101010"
theme.border_focus                              = "#101010"
theme.border_marked                             = "#FF0000"

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
theme.tasklist_disable_task_name                = false
theme.tasklist_disable_icon                     = true
theme.tasklist_bg_focus                         = "#101010"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

-- awful wibar properties
theme.wibar_position                            = "bottom"
theme.wibar_height                              = dpi(25)

-- Generate taglist squares:
local taglist_square_size                       = dpi(4)
theme.taglist_squares_sel                       = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel                     = theme_assets.taglist_squares_unsel(
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
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(180)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

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
theme.layout_fairv                              = theme.dir .. "/icons/layouts/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/layouts/fairh.png"
theme.layout_max                                = theme.dir .. "/icons/layouts/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/layout/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/layouts/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/layouts/floating.png"
theme.layout_tile                               = theme.dir .. "/icons/layouts/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/layouts/tiletop.png"
theme.layout_spiral                             = theme.dir .. "/icons/layouts/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/layouts/dwindle.png"
theme.layout_cornernw                           = theme.dir .. "/icons/layouts/cornernw.png"
theme.layout_cornerne                           = theme.dir .. "/icons/layouts/cornerne.png"
theme.layout_cornersw                           = theme.dir .. "/icons/layouts/cornersw.png"
theme.layout_cornerse                           = theme.dir .. "/icons/layouts/cornerse.png"

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

theme.textclock_format = "%R"
theme.calendar_theme = "naughty"
theme.calendar_position = "bottom_right"
theme.calendar_radius = 0
theme.calendar_start_sunday = false

theme.batteryarc_notification_position = "bottom_right"
theme.batteryarc_main_color = theme.fg_normal

theme.volume_widget_type = "horizontal_bar"

theme.cpu_widget_color  = theme.fg_normal

-- Right widgets
--

---comment
---@param screen any
---@param widgets { load: function }
---@param w_layoutbox table
---@return table
local function create_right_widgets(screen, widgets, w_layoutbox)
    local systray = widgets:load("toggable_systray", {
        hidden_at_start = true,
        no_tooltip = true,
        text_icon_show = "󱊖 ",
        font = "Commodore 64 20"
    })
    return {
        layout = wibox.layout.fixed.horizontal,
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 15,
                    systray,
                    mpris_widget({
                        bg = "#000000",
                        max_chars = -1,
                        scroll = {
                            enabled = true,
                            max_size = 100
                        },
                        media_icons = {
                            default = theme.dir .. "/icons/mpris/default.png",
                            firefox = theme.dir .. "/icons/mpris/firefox.png",
                            totem = theme.dir .. "/icons/mpris/totem.png",
                            rhythmbox = theme.dir .. "/icons/mpris/rhythmbox.png",
                            spotify = theme.dir .. "/icons/mpris/spotify.png",
                            musikcube = theme.dir .. "/icons/mpris/musikcube.png",
                        }
                    }),
                    widgets:load('cpu_widget'),
                    widgets:load('ram_widget'),
                    widgets:load('volume_widget'),
                    widgets:load('battery_widget'),
                    widgets:load('keyboardlayout'),
                    widgets:load('textclock'),
                    w_layoutbox
                },
                left = 15,
                right = 10,
                widget = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background
        }
    }
end

theme.create_right_widgets = create_right_widgets

return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
