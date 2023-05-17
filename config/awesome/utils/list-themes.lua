--- utils/list-themes.lua
---
--- Author: demingongo
--- Link: https://github.com/demingongo
--- Availability: https://github.com/demingongo/awesomewm-dotfiles

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function read_lines_from(file)
  local result = {}
  if not file_exists(file) then return result end
  for line in io.lines(file) do
    if line and line ~= "" then
      table.insert(result, line)
    else
      break
    end
  end
  return result
end

local function list_themes()
  local file = os.getenv('HOME') .. '/.config/awesome/themes/themes.txt'
  return read_lines_from(file)
end

return list_themes
