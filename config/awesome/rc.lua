-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Allow handle focus when switching tags and other useful
-- corner cases (deprecated after v4)
require("awful.autofocus")

-- Error handling
require("error-handling")

-- {{{ Load the dislay environment
require("my.theme")
require("my.layouts"):load()
require("my.screens"):load()
require("my.global"):load_keybindings_and_buttonbindings()
require('my.clients'):load_rules_and_signals()
-- }}}

-- Autostart scripts
require('my.autostart')
