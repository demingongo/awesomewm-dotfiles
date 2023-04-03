local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local myclientskeybindings = require("my.clients.keybindings")
local myclientsbuttonbindings = require("my.clients.buttonbindings")

---Loads rules (keybindings, border, titlebars, ...) for clients
local function load_rules()
  -- Rules to apply to new clients (through the "manage" signal).
  local clients_rules = {
    -- All clients will match this rule.
    {
      rule = {},
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = myclientskeybindings,
        buttons = myclientsbuttonbindings,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
    },

    -- Floating clients.
    {
      rule_any = {
        instance = {
          "DTA",   -- Firefox addon DownThemAll.
          "copyq", -- Includes session name in class.
          "pinentry",
          "pavucontrol"
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer" },
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester", -- xev.
        },
        role = {
          "AlarmWindow",   -- Thunderbird's calendar.
          "ConfigManager", -- Thunderbird's about:config.
          "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
        }
      },
      properties = { floating = true }
    },


    -- Disable titlebars to normal clients and dialogs
    {
      rule_any = { type = { "normal", "dialog" }
      },
      except_any = {
        instance = { "pavucontrol" },
        class = { "Blueman-manager" },
      },
      properties = { titlebars_enabled = false }
    },

    -- Add titlebars to some clients
    {
      rule_any = {
        instance = { "pavucontrol" },
        class = { "Blueman-manager" },
      },
      properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
  }

  --[[
  if type(beautiful.init_clients_rules) == "function" then
    local theme_rules = beautiful.init_clients_rules(clients_rules)
    if theme_rules then
      clients_rules = theme_rules
    end
  end
  --]]

  if type(beautiful.additional_rules) == "table" then
    clients_rules = gears.table.join(clients_rules, beautiful.additional_rules)
  end

  awful.rules.rules = clients_rules
end

return { 
  load = load_rules
}
