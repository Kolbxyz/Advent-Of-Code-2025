--!strict
-- main.luau
-- vars
local file : string = require("./input")

-- types
type Lines = { [string]: { string } }
type Cache = { [string]: number }

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

local function getConnections(lines: Lines, from: string, to: string, cache: Cache)
    local total = 0

    if from == "out" or from == to then return (from == to) and 1 or 0 end
    if cache[from] then return cache[from] end
    if lines[from] then
        for _, next in ipairs(lines[from]) do
            total += getConnections(lines, next, to, cache)
        end
    end
    cache[from] = total
    return total
end

local function compute(file)
    local lines: Lines = parse(file)
    local cache1: Cache = {}
    local cache2: Cache = {}
    local cache3: Cache = {}

    local paths1 = getConnections(lines, "svr", "fft", cache1)
    local paths2 = getConnections(lines, "fft", "dac", cache2)
    local paths3 = getConnections(lines, "dac", "out", cache3)
    local total = paths1 * paths2 * paths3
    print(total)
end

compute(file)
