--!strict
-- main.lua
-- vars
local file : string = require("./input")

-- types
type arr = { { string } }

-- func
local function parse(file : string?) : arr
    local parsedFile : arr = {}

    assert(file, "Invalid file provided")
    for _, line : string in ipairs(string.split(file, "\n")) do
        local values : { string } = {}
        for v : string in line:gmatch("%S+") do
            table.insert(values, v)
        end
        table.insert(parsedFile, values)
    end
    return parsedFile
end

local function findResult(parsedFile : arr) : number
    local res : number = 0

    for x = 1, #parsedFile[1] do
        local result = tonumber(parsedFile[1][x]) or 0
        local operator = parsedFile[#parsedFile][x]

        for y = 2, #parsedFile - 1 do
            if operator == "+" then
                result += tonumber(parsedFile[y][x]) or 0
            elseif operator == "*" then
                result *= tonumber(parsedFile[y][x]) or 0
            end
        end
        res += result
    end
    return res
end

local parsedFile = parse(file)
print(findResult(parsedFile))
