-- main.lua
local io = require("io")
local file = io.open("./2025/Day03/Task1/input", "r")
local score = 0

-- libs
require("libs.math")

-- execution
for bank in file:lines() do
    local max = 0

    for i = 1, #bank do
        for j = 1 + i, #bank do
            local s
            s = string.sub(bank, i, i) .. string.sub(bank, j, j)
            local n = tonumber(s)
            if n > max then
                max = n
            end
            ::continue::
        end
    end
    score = score + max
    max = 0
end

print(math.round(score))

io.close(file)
