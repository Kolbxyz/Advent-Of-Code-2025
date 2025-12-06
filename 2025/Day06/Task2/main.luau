-- main.lua
local file = require("./input")

-- vars
local lines = { }
local height = #lines
local width = 0
local colStarts = { }
local lastRow = 0
local problems = { }

for _, line in ipairs(string.split(file, "\n")) do lines[#lines + 1] = line end
for _, line in ipairs(lines) do width = math.max(#line, width) end

-- execution
height = #lines
for i = 1, height do if #lines[i] < width then lines[i] = lines[i] .. string.rep(" ", width - #lines[i]) end end

lastRow = lines[height]
for i = 1, #lastRow do if lastRow:sub(i, i) ~= " " then colStarts[#colStarts + 1] = i end end
colStarts[#colStarts + 1] = width + 1

for k = 1, #colStarts - 1 do
    local seg, a, b = { }, colStarts[k], colStarts[k + 1] - 1

    for r = 1, height do seg[#seg + 1] = lines[r]:sub(a, b) end
    problems[#problems + 1] = seg
end

local function alignColumns(strs)
    local maxlen, out = 0, { }

    for _, s in ipairs(strs) do maxlen = math.max(#s, maxlen) end
    for i = 1, maxlen do
        local parts = { }
        for j = 1, #strs do parts[#parts + 1] = strs[j]:sub(i, i) end
        local n = tonumber(table.concat(parts))
        if n then out[#out + 1] = n end
    end
    return out
end

local function applyOperation(op, numbers)
    local acc = op == "*" and 1 or 0

    for _, v in ipairs(numbers) do
        if op == "*" then
            acc = acc * v
        elseif op == "+" then
            acc = acc + v
        end
    end
    return acc
end

local result = 0
for _, prob in ipairs(problems) do
    local opRow, op = prob[#prob], nil

    if opRow:find("%*") then op = "*" elseif opRow:find("%+") then op = "+" end
    if op then
        local numberLines = { }
        for i = 1, #prob - 1 do numberLines[#numberLines + 1] = prob[i] end
        local aligned = alignColumns(numberLines)
        if #aligned > 0 then result = result + applyOperation(op, aligned) end
    end
end

print(result)
