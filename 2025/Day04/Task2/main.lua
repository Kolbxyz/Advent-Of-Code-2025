-- main.lua
local io = require("io")
local file = io.open("./2025/Day04/Task1/input", "r")

-- vars
local map = {}
local actualMap = {}

-- error handling
if not file then
    print("Invalid input file!")
    os.exit(84)
end

-- func
for line in file:lines() do
    table.insert(map, line)
    table.insert(actualMap, line)
end

local function replaceChar(str, index, newChar)
    return str:sub(1, index - 1) .. newChar .. str:sub(index + 1)
end

local function checkAdj(map, pos, actualMap)
    local amnt = 0

    -- left
    if map[pos.y] and string.sub(map[pos.y], pos.x - 1, pos.x - 1) == "@" then
        amnt = amnt + 1
        actualMap[pos.y] = replaceChar(map[pos.y], pos.x - 1, "x")
    end
    -- bottom-left
    if map[pos.y + 1] and string.sub(map[pos.y + 1], pos.x - 1, pos.x - 1) == "@" then
        amnt = amnt + 1
        actualMap[pos.y + 1] = replaceChar(map[pos.y + 1], pos.x - 1, "x")
    end
    -- bottom
    if map[pos.y + 1] and string.sub(map[pos.y + 1], pos.x, pos.x) == "@" then
        amnt = amnt + 1
        actualMap[pos.y + 1] = replaceChar(map[pos.y + 1], pos.x, "x")
    end
    -- bottom-right
    if map[pos.y + 1] and string.sub(map[pos.y + 1], pos.x + 1, pos.x + 1) == "@" then
        amnt = amnt + 1
        actualMap[pos.y + 1] = replaceChar(map[pos.y + 1], pos.x + 1, "x")
    end
    -- right
    if map[pos.y] and string.sub(map[pos.y], pos.x + 1, pos.x + 1) == "@" then
        amnt = amnt + 1
        actualMap[pos.y] = replaceChar(map[pos.y], pos.x + 1, "x")
    end
    -- top-right
    if map[pos.y - 1] and string.sub(map[pos.y - 1], pos.x + 1, pos.x + 1) == "@" then
        amnt = amnt + 1
        actualMap[pos.y - 1] = replaceChar(map[pos.y - 1], pos.x + 1, "x")
    end
    -- top
    if map[pos.y - 1] and string.sub(map[pos.y - 1], pos.x, pos.x) == "@" then
        amnt = amnt + 1
        actualMap[pos.y - 1] = replaceChar(map[pos.y - 1], pos.x, "x")
    end
    -- top-left
    if map[pos.y - 1] and string.sub(map[pos.y - 1], pos.x - 1, pos.x - 1) == "@" then
        amnt = amnt + 1
        actualMap[pos.y - 1] = replaceChar(map[pos.y - 1], pos.x - 1, "x")
    end
    return amnt
end

local count = 0
while true do
    local toDelete = {}

    for y, v in ipairs(map) do
        for x = 1, #v do
            if string.sub(v, x, x) == "@" then
                if checkAdj(map, {x = x, y = y}, actualMap) < 4 then
                    table.insert(toDelete, {x = x, y = y})
                end
            end
        end
    end

    if #toDelete < 1 then
        break
    end

    for _, coord in ipairs(toDelete) do
        count = count + 1
        map[coord.y] = replaceChar(map[coord.y], coord.x, "x")
    end
end

print(count)

io.close(file)