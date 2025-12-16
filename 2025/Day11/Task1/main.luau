--!strict
-- main.luau
-- vars
local file : string = require("./input")

-- types
type LightState = { number }
type Button = { number }
type Lines = { { string: { string } } }

-- funcs
local function parse(fileContent : string?)
    local lines: Lines = {}

    assert(fileContent, "Invalid file provided")
    for _, line : string in ipairs(string.split(fileContent, "\n")) do
        if not line:match("%S") then continue end
        local input, output = line:match("(%w+):%s*([%w%s]+)")
        lines[input] = string.split(output, " ")
    end
    return lines
end

local function getConnections(lines: Lines, input: string)
    local count: number = 0

    for _, v in pairs(lines[input]) do
        if v == "out" then
            return 1
        end
        count += getConnections(lines, v)
    end
    return count
end

local function compute(file)
    local lines: Lines = parse(file)
    local count: number = 0

    count += getConnections(lines, "you")
    print(count)
end

compute(file)
