local awful = require("awful")
local theme_layouts = require("my.variables").layouts

---Loads the available layouts (e.g.: tile, ...)
local function load_layouts()
    -- Table of layouts to cover with awful.layout.inc, order matters.
    awful.layout.layouts = theme_layouts
end

return {
    load = load_layouts
}
