--- my/clients/init.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local myclientsrules = require('my.clients.rules')

---Loads clients' rules and signals
local function load_rules_and_signals()
    myclientsrules:load()
    require('my.clients.signals')
end

return {
    load_rules_and_signals = load_rules_and_signals
}
