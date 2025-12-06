-- main2.luau
local file : string = require("./input")

-- vars
local ptr : number = 50
local code : number = 0

-- func
for _, line : string in ipairs(string.split(file, "\n")) do
    local direction : number = string.sub(line, 1, 1) == "R" and 1 or -1
    local step : string = string.sub(line, 2, #line)

    for _ = 1, step do
        ptr = ptr + direction
        if ptr > 99 and direction > 0 then
            ptr = 0
        elseif ptr < 0 and direction < 0 then
            ptr = 99
        end
    end
    code += (ptr == 0 and 1 or 0)
end

print(code)
