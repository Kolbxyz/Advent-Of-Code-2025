--!strict
-- main.luau
-- vars
local file : string = require("./input")

-- types
type ParsedType = { { x: number, y: number, z: number } }

-- func
local function parse(fileContent : string?) : ParsedType
    local parsedFile : ParsedType = {}

    assert(fileContent, "Invalid file provided")
    for _, line : string in ipairs(string.split(fileContent, "\n")) do
        local values : { string } = {}
        values.x, values.y = line:match("(%d+),(%d+)")
        table.insert(parsedFile, values)
    end
    return parsedFile
end

local function getFurthest(parsedFile: ParsedType)
    local max = 0
    for i = 1, #parsedFile do
        for j = 2 + i, #parsedFile do
            local i_cell, j_cell = parsedFile[i], parsedFile[j]
            local width = math.abs(j_cell.x - i_cell.x) + 1
            local height = math.abs(j_cell.y - i_cell.y) + 1
            local distance = width * height
            max = math.max(distance, max)
        end
    end
    print("Largest Area: " .. max)
end

local parsedFile = parse(file)
getFurthest(parsedFile)
