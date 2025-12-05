-- main.lua
local io = require("io")
local split = require("libs.split")
local file = io.open("./2025/Day05/Task1/input", "r")
local res = 0

-- vars
local map = {}

-- error handling
if not file then
    print("Invalid input file!")
    os.exit(84)
end

-- func
local ranges = {}
local ids = {}
local isIds = false

for line in file:lines() do
    if #line < 2 then
        isIds = true
        goto continue
    end
    if isIds then
        table.insert(ids, line)
    else
        table.insert(ranges, line)
    end
    ::continue::
end

local count = 0
for _, id in pairs(ids) do
    for _, range in pairs(ranges) do
        local min, max = string.match(range, "(%d+)%-(%d+)")
        min, max = tonumber(min), tonumber(max)
        if tonumber(id) >= min and tonumber(id) <= max then
            count = count + 1
            break
        end
    end
end

print(count)

io.close(file)