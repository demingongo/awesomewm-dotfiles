local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function first_line_from(file)
  local result = ''
  if not file_exists(file) then return result end
  for line in io.lines(file) do
    result = line
    break
  end
  return result
end

local function get_current_theme_name()
  local file = os.getenv('HOME') .. '/.config/awesome/theme.txt'
  return first_line_from(file)
end

return get_current_theme_name
