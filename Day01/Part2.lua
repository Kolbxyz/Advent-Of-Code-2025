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
        if (ptr + direction == 100 or ptr + direction == 0) then
            print(line)
        end
        if ptr + direction == 100 then
            ptr = 0
            code = code + 1
        elseif ptr + direction == 0 then
            ptr = ptr + direction
            code = code + 1
        elseif ptr + direction < 0 then
            ptr = 99
        else
            ptr = ptr + direction
        end
    end
end

print(code)

io.close(file)