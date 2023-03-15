local awful = require("awful")
local default_layouts = require("my.static").default_layouts

---Loads the available layouts (e.g.: tile, ...)
local function load_layouts()
    -- Table of layouts to cover with awful.layout.inc, order matters.
    awful.layout.layouts = default_layouts
end

return {
    load = load_layouts
}
