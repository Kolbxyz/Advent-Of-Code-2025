--!strict
-- main.luau
-- vars
local file : string = require("./input")

-- types
type ParsedType = { { string } }

-- func
local function parse(fileContent : string?) : ParsedType
    local parsedFile : ParsedType = {}

    assert(fileContent, "Invalid file provided")
    for _, line : string in ipairs(string.split(fileContent, "\n")) do
        local values : { string } = {}
        for v : string in line:gmatch("%S") do
            table.insert(values, v)
        end
        table.insert(parsedFile, values)
    end
    return parsedFile, string.find(table.concat(parsedFile[1]), "S")
end

local function findResult(parsedFile : ParsedType, emitter : number) : number
    local res : number = 0
    local actives : { [number]: number } = {[emitter] = 1}

    for y = 1, #parsedFile do
        local nextActives : { [number]: number } = {}

        for x, count in pairs(actives) do
            if parsedFile[y][x] == "^" then
                if x > 1 then
                    nextActives[x - 1] = (nextActives[x - 1] or 0) + count
                end
                if x < #parsedFile[1] then
                    nextActives[x + 1] = (nextActives[x + 1] or 0) + count
                end
            else
                nextActives[x] = (nextActives[x] or 0) + count
            end
        end
        actives = nextActives
    end

    for _, count in pairs(actives) do
        res += count
    end
    return res
end

local parsedFile, emitter = parse(file)
print(findResult(parsedFile, emitter))

