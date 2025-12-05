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
for _, v in ipairs(split(file:read("*all"), "-")) do
    table.insert(map, v)
end

print(res)

io.close(file)