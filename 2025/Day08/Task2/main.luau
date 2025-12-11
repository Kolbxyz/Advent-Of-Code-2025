--!strict
-- main.luau
-- vars
local file : string = require("./input")
local distances : { { distance: number, i: number, j: number } } = {}

-- types
type ParsedType = { { x: number, y: number, z: number } }

-- func
local function parse(fileContent : string?) : ParsedType
    local parsedFile : ParsedType = {}

    assert(fileContent, "Invalid file provided")
    for _, line : string in ipairs(string.split(fileContent, "\n")) do
        local values : { string } = {}
        values.x, values.y, values.z = line:match("(%d+),(%d+),(%d+)")
        table.insert(parsedFile, values)
    end
    return parsedFile
end

local function computeDistances(parsedFile: ParsedType)
    for i = 1, #parsedFile do
        for j = 2 + i, #parsedFile do
            local i_cell, j_cell = parsedFile[i], parsedFile[j]
            local distance = math.sqrt(
                math.pow(i_cell.x - j_cell.x, 2)
                + math.pow(i_cell.y - j_cell.y, 2)
                + math.pow(i_cell.z - j_cell.z, 2))
            table.insert(distances, {distance = distance, i = i, j = j})
        end
    end
    table.sort(distances, function(a, b)
        return a.distance < b.distance
    end)
end

local function areInSameGroup(groups: { { number } }, i: number, j: number)
    for _, v in ipairs(groups) do
        if table.find(v, i) and table.find(v, j) then
            return true
        end
    end
    return false
end

local function getGroup(groups: {{number}}, i: number)
    for index, v in ipairs(groups) do
        if table.find(v, i) then
            return index
        end
    end
    return -1
end

local function findResult(DATA: ParsedType) : number
    local groups : { { number } } = {}
    local toProcess = {}

    while #groups ~= 1 do
        for _, data in ipairs(distances) do
            if not areInSameGroup(groups, data.i, data.j) then
                toProcess = {i = data.i, j = data.j}
                local groupI = getGroup(groups, data.i)
                local groupJ = getGroup(groups, data.j)

                if groupI == -1 and groupJ == -1 then -- none have a group
                    table.insert(groups, {data.i, data.j})
                elseif groupI == -1 and groupJ ~= -1 then -- i has a group but j hasn't
                    table.insert(groups[groupJ], data.i)
                elseif groupI ~= -1 and groupJ == -1 then -- j has a group but i hasn't
                    table.insert(groups[groupI], data.j)
                else -- both are already in a group
                    table.move(groups[groupJ], 1, #groups[groupJ], #groups[groupI] + 1, groups[groupI])
                    table.remove(groups, groupJ)
                end
            end
        end
    end
    table.sort(groups, function(a, b) return #a > #b end)
    return DATA[toProcess.i].x * DATA[toProcess.j].x
end

local parsedFile = parse(file)
computeDistances(parsedFile)
print(findResult(parsedFile))

