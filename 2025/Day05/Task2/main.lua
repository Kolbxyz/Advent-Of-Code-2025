-- main.lua
local io = require("io")
local file = io.open("./2025/Day05/Task2/input", "r")

-- error handling
if not file then
    print("Invalid input file!")
    os.exit(84)
end

-- vars
local ranges = {}

-- init
for line in file:lines() do
    local a, b = line:match("(%d+)%-(%d+)")

    if a and b then
        table.insert(ranges, {min = tonumber(a), max = tonumber(b)})
    end
end

table.sort(ranges, function(a, b)
    return a.min < b.min
end)

-- execution
local merged = {}
local current = ranges[1]
for i = 2, #ranges do
    local r = ranges[i]

    if r.min <= current.max + 1 then
        current.max = math.max(current.max, r.max)
    else
        table.insert(merged, current)
        current = r
    end
end

table.insert(merged, current)

local count = 0
for _, r in ipairs(merged) do
    count = count + (r.max - r.min + 1)
end

print(count)
