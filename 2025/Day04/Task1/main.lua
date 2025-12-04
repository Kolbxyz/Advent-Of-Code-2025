-- main.lua
local io = require("io")
local file = io.open("./2025/Day04/Task1/input", "r")

-- vars
local map = {}

-- error handling
if not file then
    print("Invalid input file!")
    os.exit(84)
end

-- func
for line in file:lines() do table.insert(map, line) end

local function checkAdj(map, pos)
    local amnt = 0

    -- Regarde, j'ai pas fait de ternaires :p !
    if map[pos.y] and string.sub(map[pos.y], pos.x - 1, pos.x - 1) == "@" then amnt = amnt + 1 end
    if map[pos.y + 1] and string.sub(map[pos.y + 1], pos.x - 1, pos.x - 1) == "@" then amnt = amnt + 1 end
    if map[pos.y + 1] and string.sub(map[pos.y + 1], pos.x, pos.x) == "@" then amnt = amnt + 1 end
    if map[pos.y + 1] and string.sub(map[pos.y + 1], pos.x + 1, pos.x + 1) == "@" then amnt = amnt + 1 end
    if map[pos.y] and string.sub(map[pos.y], pos.x + 1, pos.x + 1) == "@" then amnt = amnt + 1 end
    if map[pos.y - 1] and string.sub(map[pos.y - 1], pos.x + 1, pos.x + 1) == "@" then amnt = amnt + 1 end
    if map[pos.y - 1] and string.sub(map[pos.y - 1], pos.x, pos.x) == "@" then amnt = amnt + 1 end
    if map[pos.y - 1] and string.sub(map[pos.y - 1], pos.x - 1, pos.x - 1) == "@" then amnt = amnt + 1 end
    return amnt
end

local count = 0
for y, v in pairs(map) do
    for x = 1, #v do
        if string.sub(v, x, x) == "@" then
            count = count + (checkAdj(map, {x = x, y = y}) < 4 and 1 or 0)
        end
    end
end

print(count)

io.close(file)