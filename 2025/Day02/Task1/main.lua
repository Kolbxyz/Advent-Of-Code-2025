-- main.lua
local io = require("io")
local file = io.open("./2025/Day02/Task1/input", "r")
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
    return (#pattern == 0 or #str % #pattern ~= 0) and false or string.sub(str,  math.round(#str / 2) + 1, #str) == pattern
end

-- execution
for _, range in pairs(split(file:read("*all"), ",")) do
    local split_t = split(range, "-")
    local str_start, str_end = split_t[1], split_t[2]

    for i = str_start, str_end do
        local n = tostring(math.round(i))
        local pattern = string.sub(n, 1, math.round(#n / 2))
        if isInStr(n, pattern) then
            score = score + i
        end
    end
end

print(math.round(score))

io.close(file)
