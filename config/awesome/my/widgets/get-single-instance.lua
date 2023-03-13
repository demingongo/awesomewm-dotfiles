---comment
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