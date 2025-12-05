-- main.lua
local io = require("io")
local file = io.open("./2025/Day05/Task2/input", "r")
local res = 0

-- vars
local map = {}

-- error handling
if not file then
    print("Invalid input file!")
    os.exit(84)
end

-- func
for line in file:lines() do table.insert(map, line) end

print(res)

io.close(file)