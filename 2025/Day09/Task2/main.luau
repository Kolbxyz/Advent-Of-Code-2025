--!strict
-- main.luau
-- vars
local file : string = require("./input")

-- types
type ParsedType = { { x: number, y: number, z: number } }
type Point = { x:number, y:number }

-- func
local function parse(fileContent : string?) : ParsedType
    local parsedFile : ParsedType = {}

    assert(fileContent, "Invalid file provided")
    for _, line : string in ipairs(string.split(fileContent, "\n")) do
        local x, y = line:match("(%d+),(%d+)")
        local point = {
            x = tonumber(x),
            y = tonumber(y)
        }
        table.insert(parsedFile, point)
    end
    return parsedFile
end

local function linePoints(a:Point, b:Point)
    local points = {}
    local x1, x2 = math.min(a.x, b.x), math.max(a.x, b.x) -- Start and end x
    local y1, y2 = math.min(a.y, b.y), math.max(a.y, b.y) -- Start and end y

    for x = x1, x2 do
        for y = y1, y2 do
            table.insert(points, {x = x, y = y})
        end
    end
    return points
end

local function findPerimeter(tiles: ParsedType)
    local perimeter :  {[string]: boolean} = {}

    local function add(x, y)
        perimeter[x .. "," .. y] = true
    end
    for i = 2, #tiles do
        for _, p in ipairs(linePoints(tiles[i - 1], tiles[i])) do
            add(p.x, p.y)
        end
    end
    for _, p in ipairs(linePoints(tiles[#tiles], tiles[1])) do
        add(p.x, p.y)
    end
    return perimeter
end

local function rectangleIsValid(a: Point, b: Point, perimeter)
    local x1, x2 = math.min(a.x, b.x), math.max(a.x, b.x)
    local y1, y2 = math.min(a.y, b.y), math.max(a.y, b.y)

    for key in pairs(perimeter) do
        local sx, sy = key:match("(%d+),(%d+)")
        local px = tonumber(sx)
        local py = tonumber(sy)

        if px > x1 and px < x2 and py > y1 and py < y2 then
            return false
        end
    end
    return true
end

local function getLargestValid(parsedFile: ParsedType)
    local perimeter = findPerimeter(parsedFile)
    local distances = {}

    for i = 1, #parsedFile - 1 do
        for j = i + 1, #parsedFile do
            local pointA = parsedFile[i]
            local pointB = parsedFile[j]
            local width = math.abs(pointB.x - pointA.x) + 1
            local height = math.abs(pointB.y - pointA.y) + 1
            local area = width * height

            table.insert(distances, {
                area = area,
                i = i,
                j = j
            })
        end
    end

    table.sort(distances, function(a, b) return a.area > b.area end)

    for _, v in ipairs(distances) do
        local a = parsedFile[v.i]
        local b = parsedFile[v.j]
        if rectangleIsValid(a, b, perimeter) then return v.area end
    end
end

local parsedFile = parse(file)
print(getLargestValid(parsedFile))
