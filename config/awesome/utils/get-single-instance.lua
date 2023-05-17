--- utils/get-single-instance.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

---Returns a function that will return the result of the function parameter.
---If the result is not nil, it will always return that same result without executing
---the function parameter.
---@param fn function
---@return function
local function get_single_instance(fn)
    local instance = nil

    return function(...)
        if not instance then
            instance = fn(...)
        end
        return instance
    end
end

return get_single_instance