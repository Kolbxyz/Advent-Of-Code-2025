-- main.lua
local io = require("io")
local file = io.open("./2025/Day02/Task2/input", "r")
local score = 0

-- libs
require("libs.math")

-- functions
function split(inputstr, sep)
    sep = sep or "%s"
    local t = {}

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local function isInStr(str, pattern)
    if #pattern == 0 or #str % #pattern ~= 0 then
        return false
    end

    for i = 1, #str, #pattern do
        if string.sub(str, i, i + #pattern - 1) ~= pattern then
            return false
        end
    end
    return true
end

-- execution
for _, range in pairs(split(file:read("*all"), ",")) do
    local split_t = split(range, "-")
    local str_start, str_end = split_t[1], split_t[2]

    for i = str_start, str_end do
        local n = tostring(math.floor(i))
        for j = 1, math.floor(#n / 2) do
            local pattern = string.sub(n, 1, j)
            if isInStr(n, pattern) then
                score = score + i
                break
            end
        end
    end
end

print(math.round(score))

io.close(file)
