--- my/theme.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local current_theme = require('my.static').current_theme
local beautiful = require("beautiful")

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), current_theme))
