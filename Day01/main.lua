-- main.lua
local io = require("io")
local file = io.open("input", "r")

-- vars
local ptr = 50
local code = 0

-- func
for line in file:lines() do
    local direction = string.sub(line, 1, 1) == "R" and 1 or -1
    local step = string.sub(line, 2, #line)

    for _ = 1, step do
        ptr = ptr + direction
        if ptr > 99 and direction > 0 then
            ptr = 0
        elseif ptr < 0 and direction < 0 then
            ptr = 99
        end
    end
    code = code + (ptr == 0 and 1 or 0)
end

print(code)

io.close(file)