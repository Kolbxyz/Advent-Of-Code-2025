--!strict
-- main.luau
-- vars
local file : string = require("./input")

-- types
type Shapes = { number }

-- funcs
local function parse_and_resolve(fileContent : string?)
    local lines: Shapes = {}
    local res = 0

    assert(fileContent, "Invalid file provided")
    local ptr = 1
    for _, line : string in ipairs(string.split(fileContent, "\n")) do
        if not line:match("%S") then continue end
        if string.sub(line, 2, 2) == ":" then
            ptr = string.sub(line, 1, 1)
            lines[ptr] = 0
        end
        for _, v in pairs(string.split(line, "")) do
            if v == "#" then
                lines[tostring((ptr))] += 1
            end
        end

        local x, y = string.match(line, "(%d+)x(%d+)")
        if x and y then
            local max = x * y
            local current = 0
            for i, n in ipairs(string.split(line, " ")) do
                if not tonumber(n) then continue end
                current += lines[tostring((i - 2))] * n
            end
            if current <= max then
                res += 1
            end
        end
    end
    print(res)
    return lines
end

parse_and_resolve(file)
