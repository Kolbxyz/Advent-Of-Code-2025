-- main.lua
local io = require("io")
local file = io.open("./2025/Day03/Task1/input", "r")
local score = 0
local values = {}

-- libs
require("libs.math")

local function tableToStr(values)
    return table.concat(values)
end

-- execution
for bank in file:lines() do
    local max = 0
    local maxIndex = 0

    for l = 12, 1, -1 do
        for i = maxIndex + 1, #bank - l + 1 do
            local n = tonumber(string.sub(bank, i, i))

            if (n > max) then
                maxIndex = i
                max = n
            end
        end
        values[13 - l] = max
        max = 0
    end
    score = score + tonumber(tableToStr(values))
    values = {}
end

print(score)

io.close(file)
