-- main.lua
local io = require("io")
local file = io.open("./2025/Day01/input", "r")

-- vars
local ptr = 50
local code = 0

-- error handling
if not file then
    print("Invalid input file!")
    os.exit(84)
end

-- func
for line in file:lines() do
    local direction = string.sub(line, 1, 1) == "R" and 1 or -1
    local step = string.sub(line, 2, #line)

    for _ = 1, step do
        code = code + (ptr + direction == 0 and 1 or ptr + direction == 100 and 1 or 0)
        ptr = ptr + direction == 100 and 0 or ptr + direction == 0 and ptr + direction or ptr + direction < 0 and 99 or ptr + direction
    end
end

print(code)

io.close(file)